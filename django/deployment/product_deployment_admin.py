__author__ = 'Lorne'

import copy
import datetime
import django

from django.contrib import admin
from django.forms import ModelForm
from django.forms.models import modelformset_factory
from django.conf.urls import patterns
from django.http import HttpResponse
from django.utils.translation import ugettext as _
from django.template.response import TemplateResponse
from django.contrib.admin import helpers
from django.utils.encoding import force_text
from django.forms.formsets import all_valid
from django.core.exceptions import ObjectDoesNotExist
from django.core.exceptions import PermissionDenied
from django.db import transaction
from django.utils.decorators import method_decorator
from django.views.decorators.csrf import csrf_protect

from deployment.models import *
from product.models import *
from autodeploy.settings import COMPONENT_CONFIG_PATH, COMPONENT_CONFIG_FOLDER, PRODUCT_CONFIG_FOLDER,\
    PUPPET_MANIFEST_PATH, ACTION_DEPLOY, ACTION_UPGRADE, DEFAULT_ENVIRONMENT
from autodeploy.util import download_package

csrf_protect_m = method_decorator(csrf_protect)


class ProductDeploymentSelectVersionForm(ModelForm):
    class Meta:
        model = ProductDeployment

    def __init__(self, *args, **kwargs):
        super(ProductDeploymentSelectVersionForm, self).__init__(*args, **kwargs)
        if len(args) and args[0]['product']:
            prod_id = args[0]['product']
            self.fields['product'].queryset = Product.objects.filter(pk=prod_id)
            self.fields['product'].empty_label = None
            self.fields['product'].empty_value = []
            if 'current_product_version' in self.fields:
                if DEFAULT_ENVIRONMENT == ENVIRONMENT_PRODUCTION or DEFAULT_ENVIRONMENT == ENVIRONMENT_STAGING:
                    self.fields['current_product_version'].queryset = ProductVersion.objects.filter(product__id=prod_id, is_release=True).order_by('-id')
                else:
                    self.fields['current_product_version'].queryset = ProductVersion.objects.filter(product__id=prod_id).order_by('-id')
                #self.fields['product'].empty_label = None
                #self.fields['product'].empty_value = []
        if len(args) and args[0]['service_provider']:
            sp_id = args[0]['service_provider']
            self.fields['service_provider'].queryset = ServiceProvider.objects.filter(pk=sp_id)
            self.fields['service_provider'].empty_label = None
            self.fields['service_provider'].empty_value = []
        if len(args) and args[0]['environment']:
            environment = args[0]['environment']
            self.fields['environment'].queryset = Environment.objects.filter(pk=environment)
            self.fields['environment'].empty_label = None
            self.fields['environment'].empty_value = []


class ProductDeploymentConfigForm(ModelForm):
    class Meta:
        model = ProductDeployment

    def __init__(self, *args, **kwargs):
        super(ProductDeploymentConfigForm, self).__init__(*args, **kwargs)
        if len(args) and args[0]['product']:
            prod_id = args[0]['product']
            self.fields['product'].queryset = Product.objects.filter(pk=prod_id)
            self.fields['product'].empty_label = None
            self.fields['product'].empty_value = []
        if len(args) and args[0]['current_product_version']:
            prod_ver_id = args[0]['current_product_version']
            self.fields['current_product_version'].queryset = ProductVersion.objects.filter(pk=prod_ver_id)
            self.fields['current_product_version'].empty_label = None
            self.fields['current_product_version'].empty_value = []
        if len(args) and args[0]['service_provider']:
            sp_id = args[0]['service_provider']
            self.fields['service_provider'].queryset = ServiceProvider.objects.filter(pk=sp_id)
            self.fields['service_provider'].empty_label = None
            self.fields['service_provider'].empty_value = []
        if len(args) and args[0]['environment']:
            environment = args[0]['environment']
            self.fields['environment'].queryset = Environment.objects.filter(pk=environment)
            self.fields['environment'].empty_label = None
            self.fields['environment'].empty_value = []


class ProductDeploymentUpgradeForm(ModelForm):
    class Meta:
        model = ProductDeployment

    def __init__(self, *args, **kwargs):
        super(ProductDeploymentUpgradeForm, self).__init__(*args, **kwargs)
        if 'instance' in kwargs:
            prod_ver = self.instance.current_product_version
            # doc in production environment only show release version
            if DEFAULT_ENVIRONMENT == ENVIRONMENT_PRODUCTION or DEFAULT_ENVIRONMENT == ENVIRONMENT_STAGING:
                self.fields['current_product_version'].queryset = ProductVersion.objects.filter(product_id=prod_ver.product_id,
                                                        version__gte=prod_ver.version, is_release=True).order_by('-id')
            else:
                self.fields['current_product_version'].queryset = ProductVersion.objects.filter(product_id=prod_ver.product_id,
                                                                        version__gte=prod_ver.version).order_by('-id')
            self.fields['current_product_version'].empty_label = None
            self.fields['current_product_version'].empty_value = []
            self.fields['current_product_version'].help_text = \
                'current version is %s <br /> ' \
                'Select a new version and click <font color="red">Upgrade Product Version</font> button' \
                'above to upgrade a full product version<br/>' % str(prod_ver)
                #'Select current version and click <font color="red">Upgrade Component Version</font> button above to re-deploy or re-upgrade a certain component' % str(prod_ver)


class ProductDeploymentUpgradeConfigForm(ModelForm):
    class Meta:
        model = ProductDeployment

    def __init__(self, *args, **kwargs):
        super(ProductDeploymentUpgradeConfigForm, self).__init__(*args, **kwargs)
        if 'instance' in kwargs:
            prod_ver = self.instance.current_product_version


class ProductDeploymentHistoryInline(admin.StackedInline):
    model = ProductDeploymentHistory
    verbose_name = 'Product Deployment & Upgrade Record'
    verbose_name_plural = 'Product Deployment & Upgrade History'
    readonly_fields = ['product_version', 'action', 'puppet_config_file', 'operator', 'create_date']
    exclude = ['service_provider', 'environment']
    extra = 1
    ordering = ('-id',)
    max_num = 5
    can_delete = False

    def has_add_permission(self, request):
        return False

class ProductDeploymentAdmin(admin.ModelAdmin):
    class Media:
        # hide the foreignkey field's plus button
        js = ("js/hide_fkfield_addlink.js",)

    list_filter = ('service_provider', 'environment', 'product')
    search_fields = ('service_provider', 'product')
    list_display = ('service_provider', 'environment', 'product', 'current_product_version', 'operator', 'create_date')
    exclude = ['operator', 'create_date']
    readonly_fields = []
    add_form_template = None
    inlines = [ProductDeploymentHistoryInline, ]

    def add_view(self, request, form_url='', extra_context=None):
        self.form = django.forms.ModelForm
        self.add_form_template = None
        self.readonly_fields = []
        self.inlines = []
        extra_context = dict()
        model = self.model
        opts = model._meta

        if not self.has_add_permission(request):
            raise PermissionDenied

        modelForm = None
        formsets = []
        inline_instances = self.get_inline_instances(request, None)
        if request.method == 'POST':
            self.form = django.forms.ModelForm
            modelForm = self.get_form(request)
            form = modelForm(request.POST, request.FILES)
            if form.is_valid():
                new_object = self.save_form(request, form, change=False)
                form_validated = True
            else:
                form_validated = False
                new_object = self.model()
            prefixes = {}
            for FormSet, inline in zip(self.get_formsets(request), inline_instances):
                prefix = FormSet.get_default_prefix()
                prefixes[prefix] = prefixes.get(prefix, 0) + 1
                if prefixes[prefix] != 1 or not prefix:
                    prefix = "%s-%s" % (prefix, prefixes[prefix])
                formset = FormSet(data=request.POST, files=request.FILES,
                                  instance=new_object,
                                  save_as_new="_saveasnew" in request.POST,
                                  prefix=prefix, queryset=inline.get_queryset(request))
                formsets.append(formset)
            if all_valid(formsets) and form_validated:
                if 'current_product_version' in form.fields:
                    # already selected product version , nothing to do
                    pass
                else:
                    # should select a product version
                    self.form = ProductDeploymentSelectVersionForm
                    self.exclude = ['operator', 'create_date']
                    modelForm = self.get_form(request)
                    form = modelForm(request.POST, request.FILES)
                    extra_context = {
                        'title': _('Select a Product Version'),
                    }
                    form_url = '../deploy_config/'
                    #form.fields['last_version'].help_text = 'select a version wanna be deployed'
            else:
                self.form = django.forms.ModelForm
        else:
            self.exclude = ['operator', 'create_date', 'current_product_version']
            ModelForm = self.get_form(request)
            # Prepare the dict of initial data from the request.
            # We have to special-case M2Ms as a list of comma-separated PKs.
            initial = dict(request.GET.items())
            for k in initial:
                try:
                    f = opts.get_field(k)
                except models.FieldDoesNotExist:
                    continue
                if isinstance(f, models.ManyToManyField):
                    initial[k] = initial[k].split(",")
            form = ModelForm(initial=initial)
            prefixes = {}
            for FormSet, inline in zip(self.get_formsets(request), inline_instances):
                prefix = FormSet.get_default_prefix()
                prefixes[prefix] = prefixes.get(prefix, 0) + 1
                if prefixes[prefix] != 1 or not prefix:
                    prefix = "%s-%s" % (prefix, prefixes[prefix])
                formset = FormSet(instance=self.model(), prefix=prefix,
                                  queryset=inline.get_queryset(request))
                formsets.append(formset)
            self.exclude = ['operator', 'create_date', 'current_product_version']
            extra_context = {
                'title': _('Newly Deploy Product for ServiceProvider'),
            }

        adminForm = helpers.AdminForm(form, list(self.get_fieldsets(request)),
            self.get_prepopulated_fields(request),
            self.get_readonly_fields(request),
            model_admin=self)
        media = self.media + adminForm.media

        inline_admin_formsets = []
        for inline, formset in zip(inline_instances, formsets):
            fieldsets = list(inline.get_fieldsets(request))
            readonly = list(inline.get_readonly_fields(request))
            prepopulated = dict(inline.get_prepopulated_fields(request))
            inline_admin_formset = helpers.InlineAdminFormSet(inline, formset,
                fieldsets, prepopulated, readonly, model_admin=self)
            inline_admin_formsets.append(inline_admin_formset)
            media = media + inline_admin_formset.media

        context = {
            'adminform': adminForm,
            'is_popup': False,
            'media': media,
            'inline_admin_formsets': inline_admin_formsets,
            'errors': helpers.AdminErrorList(form, formsets),
            'app_label': opts.app_label,
            'preserved_filters': self.get_preserved_filters(request),
        }
        context.update(extra_context or {})
        return self.render_change_form(request, context, form_url=form_url, add=True)

        #self.inlines = []
        extra_context = {
            'title': _('Newly Deploy Product for ServiceProvider'),
        }
        return super(ProductDeploymentAdmin, self).add_view(request, form_url, extra_context)

    @csrf_protect_m
    @transaction.atomic
    def deploy_config_view(self, request, form_url='', extra_context=None):
        self.add_form_template = 'admin/product_deploy_config_form.html'
        self.form = ProductDeploymentConfigForm
        if not u'current_product_version' in request.POST:
            raise ObjectDoesNotExist('no current_product_version field')
        prod_ver_str = str(request.POST[u'current_product_version'])
        if prod_ver_str == '':
            return HttpResponse('please navigate back and choose a product version')
        prod_ver_id = int(request.POST[u'current_product_version'])
        prod_ver = ProductVersion.objects.get(id=prod_ver_id)

        service_provider_id = int(request.POST[u'service_provider'])
        # metadata sp which id less than 0 could not be deployed any version more than once , check this logic
        if service_provider_id < 0:
            prod_ver_deploy_list = ProductDeploymentHistory.objects.filter(product_version_id=prod_ver_id,
                                                                           service_provider_id=service_provider_id)
            if prod_ver_deploy_list.count() > 0:
                return HttpResponse('each product version can only deploy once for metadata sp, you can upgrade the existing deployment to modify configuration')

        # if component have no corresponding version package with specific product version , it'll not show
        component_package_list = ComponentPackage.objects.filter(product_version_id=prod_ver_id)
        # doc on production env, need to download package from development server
        if DEFAULT_ENVIRONMENT == ENVIRONMENT_PRODUCTION or DEFAULT_ENVIRONMENT == ENVIRONMENT_STAGING:
            for com_pack in component_package_list:
                download_package(com_pack)

        id_list = []
        for com in component_package_list:
            id_list.append(com.component_id)
        components = Component.objects.filter(product_id=prod_ver.product_id, id__in=id_list)
        environment = Environment(name=request.POST[u'environment'])
        server_list = Server.objects.filter(environment=environment)

        components_config = []
        #loop components
        i = 0
        for com in components:
            temp_list = {}
            temp_list['component'] = com
            temp_list['configs'] = ConfigTemplateItem.objects.filter(component=com)
            #temp_list['index'] = i
            components_config.append(temp_list)
            i = i + 1

        extra_context = {
            'server_list': server_list,
            'components_config': components_config,
            'service_provider_id': request.POST[u'service_provider'],
            'action': ACTION_DEPLOY,
            'product_version_id': request.POST[u'current_product_version'],
            'environment': request.POST[u'environment'],
            'title': _('Config for this deployment'),
            'form_url': '../deploy/',
            'show_save_and_add_another': False,
            'show_save_and_continue': False,
        }

        model = self.model
        opts = model._meta
        ModelForm = self.get_form(request)
        formsets = []
        inline_instances = self.get_inline_instances(request, None)
        form = ModelForm(request.POST, request.FILES)
        if form.is_valid():
            new_object = self.save_form(request, form, change=False)
            form_validated = True
        else:
            form_validated = False
            new_object = self.model()
        prefixes = {}
        for FormSet, inline in zip(self.get_formsets(request), inline_instances):
            prefix = FormSet.get_default_prefix()
            prefixes[prefix] = prefixes.get(prefix, 0) + 1
            if prefixes[prefix] != 1 or not prefix:
                prefix = "%s-%s" % (prefix, prefixes[prefix])
            formset = FormSet(data=request.POST, files=request.FILES,
                              instance=new_object,
                              save_as_new="_saveasnew" in request.POST,
                              prefix=prefix, queryset=inline.get_queryset(request))
            formsets.append(formset)
        adminForm = helpers.AdminForm(form, list(self.get_fieldsets(request)),
            self.get_prepopulated_fields(request),
            self.get_readonly_fields(request),
            model_admin=self)
        media = self.media + adminForm.media

        inline_admin_formsets = []
        for inline, formset in zip(inline_instances, formsets):
            fieldsets = list(inline.get_fieldsets(request))
            readonly = list(inline.get_readonly_fields(request))
            prepopulated = dict(inline.get_prepopulated_fields(request))
            inline_admin_formset = helpers.InlineAdminFormSet(inline, formset,
                fieldsets, prepopulated, readonly, model_admin=self)
            inline_admin_formsets.append(inline_admin_formset)
            media = media + inline_admin_formset.media

        context = {
            'title': _('Add %s') % force_text(opts.verbose_name),
            'adminform': adminForm,
            'is_popup': False,
            'media': media,
            'inline_admin_formsets': inline_admin_formsets,
            'errors': helpers.AdminErrorList(form, formsets),
            'app_label': opts.app_label,
            'preserved_filters': self.get_preserved_filters(request),
        }
        form_url = '../deploy/'
        context.update(extra_context or {})
        return self.render_change_form(request, context, form_url=form_url, add=True)

    @csrf_protect_m
    @transaction.atomic
    def deploy(self, request, form_url='', extra_context=None):
        action = ACTION_DEPLOY
        prod_ver_id = int(request.POST[u'current_product_version']) if action is ACTION_UPGRADE else \
            int(request.POST[u'product_version_id'])
        prod_ver = ProductVersion.objects.get(id=prod_ver_id)
        sp_id = int(request.POST[u'service_provider_id'])
        sp = ServiceProvider.objects.get(pk=sp_id)
        env_name = request.POST[u'environment']
        environment = Environment(name=env_name)
        sp_str = 'SP%s_%s' % (sp.id, sp.name)
        prod_ver_str = '%s_%s' % (prod_ver.product.name, prod_ver.version)
        # kit directory path couple with product.modles.get_kit_upload_relative_path function
        kit_str = "%s_%s.zip" % (prod_ver.deploy_kit.name, prod_ver.deploy_kit.version)

        component_package = ComponentPackage.objects.filter(product_version_id=prod_ver_id)
        id_list = []
        for com in component_package:
            id_list.append(com.component_id)
        components = Component.objects.filter(product_id=prod_ver.product_id, id__in=id_list)

        component_config = []
        for com in components:
            temp_dict = dict()
            temp_dict['component'] = com

            if not ('server_' + str(com.id)) in request.POST:
                continue
            server_list = request.POST.getlist('server_' + str(com.id))
            if not len(server_list) > 0:
                continue
            temp_dict['server'] = server_list
            #if not temp_dict['server']:
            #    return HttpResponse('You must select a server for component %s' % com.name)
            config_list = ConfigTemplateItem.objects.filter(component=com)
            for item in config_list:
                item.defult_value = request.POST['config_' + str(item.id)]
            temp_dict['config_list'] = config_list
            component_config.append(temp_dict)

        product_deployment = ProductDeployment(service_provider_id=sp_id, product=prod_ver.product, current_product_version=prod_ver,
                                               operator=request.user, environment=environment)
        product_deployment.save()

        product_deployment_record = ProductDeploymentHistory(service_provider_id=sp_id, product_version=prod_ver, operator=request.user,
                                           action=action, environment=environment, product_deployment=product_deployment)
        product_deployment_record.save()

        key_value_template = "<add key=\"%s\" value=\"%s\" />\r\n"
        puppet_config_content_dict = {}
        component_config_content_list = dict()
        kit_config_content_list = dict()

        for com in component_config:
            package_list = ComponentPackage.objects.filter(component=com['component'], product_version=prod_ver_id) \
                                    .order_by('-id')
            if package_list.count():
                component_package = package_list[0]
            else:
                continue
            component_deployment = ComponentDeploymentHistory(service_provider_id=sp_id,
                                                       product_deployment_history_id=product_deployment_record.id,
                                                       product_deployment_id=product_deployment.id,
                                                       operator=request.user, action=action, environment=environment,
                                                       component_package_id=component_package.id)

            component_deployment.save()
            component_deployment.server = com['server']
            component_deployment.save()

            server_list = []
            for serverid in com['server']:
                server_list.append(Server.objects.get(pk=serverid))

            component_config_content = []
            kit_config_content = []
            for config in com['config_list']:
                # totest replace all variable with actual value in component config item
                config.defult_value = config.defult_value.replace('%SPID%', str(sp_id))
                config.defult_value = config.defult_value.replace('%SPNAME%', sp.name.replace(' ', '-'))
                config.defult_value = config.defult_value.replace('%ENV%', environment.name)
                config.defult_value = config.defult_value.replace('%ACTION%', action)
                config.defult_value = config.defult_value.replace('%VERSION%', prod_ver.version)
                config.defult_value = config.defult_value.replace('%PRODUCT%', prod_ver.product.name)

                new_config = ConfigItem(key_name=config.key_name, value=config.defult_value, type=config.type,
                                        product_deployment_id=product_deployment_record.id,
                                        component_deploy_id=component_deployment.id,
                                        component_package=component_package, config_template_item_id=config.id)
                new_config.save()
                if config.type == CONFIG_ITEM_COMPONENT:
                    component_config_content.append(key_value_template % (config.key_name, config.defult_value))
                else:
                    kit_config_content.append(key_value_template % (config.key_name, config.defult_value))

            # relative path of kit and component config
            relative_config_path = os.path.join(PRODUCT_CONFIG_FOLDER, sp_str, prod_ver_str)
            if not os.path.exists(os.path.join(PUPPET_FILES_PATH, relative_config_path)):
                os.makedirs(os.path.join(PUPPET_FILES_PATH, relative_config_path))
            # save deploy kit config
            com['component'].config_path = com['component'].config_path.replace('%SPID%', str(sp_id))
            com['component'].config_path = com['component'].config_path.replace('%SPNAME%', sp.name.replace(' ', '-'))
            com['component'].config_path = com['component'].config_path.replace('%ENV%', environment.name)
            com['component'].config_path = com['component'].config_path.replace('%ACTION%', action)
            com['component'].config_path = com['component'].config_path.replace('%VERSION%', prod_ver.version)
            com['component'].config_path = com['component'].config_path.replace('%PRODUCT%', prod_ver.product.name)

            kit_config_content.append(key_value_template % ('DstConfigPath', com['component'].config_path))
            kit_config_content.append(key_value_template % ('ComponetPackagePath',
                                                            '../../../'+get_component_upload_relative_path(component_package)))
            kit_config_content.append(key_value_template % ('ActionType', action.upper()))
            if sp is not None:
                kit_config_content.append(key_value_template % ('SpId', sp_id))
                kit_config_content.append(key_value_template % ('SpName', sp.name))

            for server in server_list:
                # kit and component filename
                config_filename = '%s_%s@%s' % (product_deployment_record.id, com['component'].name, server.name)
                # save component config
                component_config_path = os.path.join(relative_config_path, config_filename + '.config')
                fileHandle = open(os.path.join(PUPPET_FILES_PATH, component_config_path), 'w')
                fileHandle.write('<deployConfiguration>\r\n'+''.join(component_config_content)+'</deployConfiguration>')
                fileHandle.close()
                # save component config
                kit_config_path = os.path.join(relative_config_path, config_filename + '.xml')
                kit_config_content_str = '<Service type="%s">\r\n%s\r\n</Service>' % (com['component'].name.upper(), ''.join(kit_config_content))
                fileHandle = open(os.path.join(PUPPET_FILES_PATH, kit_config_path), 'w')
                fileHandle.write(kit_config_content_str)
                fileHandle.close()

                kit_config_content.append(key_value_template % ('SrcConfigPath', '../../../'+component_config_path))

                deploy_kit_path = get_kit_upload_relative_path(prod_ver.deploy_kit)
                puppet_config_content = '''
    autodeploycomponent {"%s":
        product_version => '%s',
        service_provider => '%s',
        component_name => '%s',
        package_filename => '%s',
        component_config_filename => '%s',
        kit_config_filename => '%s',
        kit_package_filename =>'%s',
        kit_name =>'%s',
        kit_version =>'%s',
    }\r\n''' % (config_filename, prod_ver_str, sp_str, com['component'].name, get_component_upload_relative_path(component_package),
              component_config_path,  kit_config_path, deploy_kit_path, prod_ver.deploy_kit.name, prod_ver.deploy_kit.version)

                if not server.name in puppet_config_content_dict:
                    puppet_config_content_dict[server.name] = []
                puppet_config_content_dict[server.name].append(puppet_config_content)
                #store config path into database
                component_deployment.deploykit_config_file = os.path.join(PUPPET_FILES_PATH, kit_config_path)
                component_deployment.component_config_file = os.path.join(PUPPET_FILES_PATH, component_config_path)
                # todo add config url
                #component_deployment.deploykit_config_content = kit_config_content_str
                #component_deployment.component_config_content = '<deployConfiguration>\r\n'+''.join(component_config_content)+'</deployConfiguration>'
                component_deployment.save()
                component_config_content_list[component_config_path] = component_config_content
                kit_config_content_list[kit_config_path] = kit_config_content

        # save puppet config below
        # relative path of puppet pp config file
        relative_puppet_config_path = os.path.join(prod_ver.product.name, sp_str, prod_ver_str)
        # !!tightly couple with puppet module, refer /etc/puppet/module/$environment/$module_name/manifest/init.pp
        puppet_config_folder = os.path.join(PUPPET_MANIFEST_PATH, DEFAULT_ENVIRONMENT, relative_puppet_config_path)
        if not os.path.exists(puppet_config_folder):
            os.makedirs(puppet_config_folder)
        puppet_config_filename = '%s@%s.pp' % (action, datetime.datetime.now().strftime('%Y%m%d-%H%M%S'))
        puppet_config = os.path.join(puppet_config_folder, puppet_config_filename)
        puppet_config_file = open(puppet_config, 'a')
        try:
            # output puppet config of each server node
            all_puppet_config_content = ''
            for (k, v) in puppet_config_content_dict.items():
                node_content = '''node '%s'{
    include windows_7z
    %s
}\r\n\r\n''' % (k, ''.join(v))
                all_puppet_config_content += node_content
            puppet_config_file.write(all_puppet_config_content)
        finally:
            puppet_config_file.close()

        # store puppet config into database
        product_deployment_record.puppet_config_file = puppet_config
        # todo add config url
        product_deployment_record.puppet_config_content = all_puppet_config_content
        product_deployment_record.save()

        # wirte config to puppet site.pp(actually run_once.pp import by site.pp)
        site_config_content = 'import \'%s\'\r\n' % os.path.join(relative_puppet_config_path, puppet_config_filename)
        site_config = os.path.join(PUPPET_MANIFEST_PATH, DEFAULT_ENVIRONMENT, 'run_once.pp')
        history_config = os.path.join(PUPPET_MANIFEST_PATH, DEFAULT_ENVIRONMENT, 'autodeploy_history.pp')
        site_file = open(site_config, 'w')
        site_file.write(site_config_content)
        site_file.close()
        history_file = open(history_config, 'a')
        history_file.write('#'+site_config_content)
        history_file.close()

        # no component deployed actually
        if len(component_config_content_list) == 0:
            product_deployment_record.delete()
            return HttpResponse('None component deployed')

        # generate deploy report, show component_config_content_list,kit_config_content_list,puppet_config_content_list repeatedly
        report = '</ br>Deploy Successfully</ br> <pre>'
        for k, v in component_config_content_list.items():
            content = ('<deployConfiguration>\r\n'+''.join(v)+'</deployConfiguration>').replace('<', '&lt;').replace('>', '&gt;')
            report += 'PRODUCT_CONFIG : %s<br/>%s<br/><br/>' % (k, content)

        for k, v in kit_config_content_list.items():
            content = ''.join(v).replace('<', '&lt;').replace('>', '&gt;')
            report += 'DEPLOY_KIT_CONFIG : %s<br/>%s<br/><br/>' % (k, content)

        for k, v in puppet_config_content_dict.items():
            report += '''PUPPET_CONFIG for node %s:</ br>
node '%s'{
    include windows_7z
    %s
}<br/><br/>''' % (k, k, ''.join(v))

        return HttpResponse(report+'</pre>')

    def change_view(self, request, object_id, form_url='', extra_context=None):
        self.form = ProductDeploymentUpgradeForm
        self.change_form_template = 'admin/product_update_form.html'
        self.exclude = ['operator', 'create_date']
        self.readonly_fields = ['service_provider', 'environment', 'product']
        self.inlines = [ProductDeploymentHistoryInline,]
        #extra_context = extra_context or {}
        #extra_context['show_save_and_add_another'] = False
        #extra_context['really_hide_save_and_add_another_damnit'] = True
        form_url = '../upgrade_config/?id=%s' % object_id
        return super(ProductDeploymentAdmin, self).change_view(request, object_id, form_url, extra_context)

    @csrf_protect_m
    @transaction.atomic
    def upgrade_config_view(self, request, form_url='', extra_context=None):
        if request.method == 'GET':
            return super(ProductDeploymentAdmin, self).changelist_view(request, extra_context)

        self.change_form_template = 'admin/product_update_form.html'
        product_depyloyment_id = request.GET['id']
        object_id = product_depyloyment_id
        prod_ver_id = request.POST['current_product_version']
        product_deployment = ProductDeployment.objects.get(pk=product_depyloyment_id)
        if int(product_deployment.current_product_version.id) > int(prod_ver_id):
            # choose the same version
            self.inlines = [ProductDeploymentHistoryInline, ]
            self.exclude = ['operator', 'create_date']
            self.readonly_fields = ['service_provider', 'environment', 'product']
            self.form = ProductDeploymentUpgradeForm
            extra_context = extra_context or {}
            extra_context['error'] = 'Please select a newer version!'
            request.method = 'GET'
            return super(ProductDeploymentAdmin, self).change_view(request, object_id, form_url, extra_context)
        else:
            # to upgrade configuring
            self.form = ProductDeploymentUpgradeConfigForm
            self.change_form_template = 'admin/product_upgrade_config_form.html'
            self.inlines = []
            request.method = 'GET'
            self.readonly_fields = ['current_product_version', 'service_provider', 'environment', 'product']
            self.exclude = ['operator', 'create_date']

            upgrade_prod_ver_id = request.POST['current_product_version']
            upgrade_prod_ver = ProductVersion.objects.get(pk=upgrade_prod_ver_id)
            product_deployment_history = ProductDeploymentHistory.objects.filter(
                                                    product_deployment_id=product_depyloyment_id).order_by('-id')
            if product_deployment_history.count() == 0:
                raise ObjectDoesNotExist('this Service Provider have no deploy history')
            product_deployment_upgrade_record = product_deployment_history[0]

            deploy_component_list = ComponentDeploymentHistory.objects.filter(product_deployment_history=product_deployment_upgrade_record.id)
            env_name = product_deployment_upgrade_record.environment.name
            environment = Environment(name=env_name)
            server_list = Server.objects.filter(environment=product_deployment_upgrade_record.environment)
            form_url = '../upgrade/'

            deployment_config = []
            component_list = Component.objects.filter(product=product_deployment_upgrade_record.product_version.product)
            for component in component_list:
                try:
                    new_component_package = ComponentPackage.objects.get(component=component, product_version=upgrade_prod_ver)
                except ObjectDoesNotExist:
                    # the upgrade product version have no package for this component
                    continue
                temp_list = dict()
                temp_list['component'] = component
                count = deploy_component_list.filter(component_package__component__id=component.id).count()
                config_list = []
                config_template_list = ConfigTemplateItem.objects.filter(component=component)
                if count > 0:
                    # have deploy history in database, output history config value
                    com_deploy = deploy_component_list.get(component_package__component__id=component.id)
                    temp_list['server'] = com_deploy.server.all()
                    temp_list['former_component_version'] = ' upgrade from ' + com_deploy.component_package.product_version.version
#totest normal
                    config_history_list = ConfigItem.objects.filter(component_deploy=com_deploy.id) #product_deployment_id=product_depyloyment_id,
                    for item in config_template_list:
                        try:
                            history_item = config_history_list.get(config_template_item=item)
                            item.defult_value = history_item.value
                        except ObjectDoesNotExist:
                            # a new config item, no history, continue
                            pass
                        config_list.append({'id': item.id, 'key_name': item.key_name, 'value': item.defult_value})
                else:
 #totest special
                    # have no deploy history, output template config default value
                    # first check is there any former history
                    com_deploy_history_list = ComponentDeploymentHistory.objects.filter(product_deployment_history=product_deployment,
                                                                component_package__component=component).order_by('-id')
                    if com_deploy_history_list.count() > 0:
                        com_deploy_history = com_deploy_history_list[0]
                        temp_list['server'] = com_deploy_history.server.all()
                        temp_list['former_component_version'] = ' upgrade from ' + com_deploy_history.component_package.product_version.version
                        config_history_list = ConfigItem.objects.filter(product_deployment=product_depyloyment_id, component_deploy=com_deploy_history.id)
                        for item in config_template_list:
                            try:
                                history_item = config_history_list.get(config_template_item=item)
                                item.defult_value = history_item.value
                            except ObjectDoesNotExist:
                                # a new config item, no history, continue
                                pass
                            config_list.append({'id': item.id, 'key_name': item.key_name, 'value': item.defult_value})
                    else:
                        # totally a new component, no any history, all blank fill with default value.
                        temp_list['server'] = []
                        config_template_list = ConfigTemplateItem.objects.filter(component=component)
                        for item in config_template_list:
                            config_list.append({'id': item.id, 'key_name': item.key_name, 'value': item.defult_value})
                temp_list['configs'] = config_list
                deployment_config.append(temp_list)

                #prepare server_list for display on frontend
                server_list_copy = copy.deepcopy(server_list)
                for server in server_list_copy:
                    if server in temp_list['server']:
                        server.description = 'selected'
                temp_list['server'] = server_list_copy

            extra_context = {
                'title': _('Upgrade Configuration for %s' % upgrade_prod_ver),
                'deployment_config': deployment_config,
                'server_list': server_list,
                'service_provider_id': product_deployment_upgrade_record.service_provider_id,
                'product_version_id': product_deployment_upgrade_record.product_version_id,
                'environment': product_deployment_upgrade_record.environment.name,
                'product_version': upgrade_prod_ver.version,
                'product_deploy_id': object_id,
                'new_product_version_id': upgrade_prod_ver_id,
                'upgrade_version_notice': ' configuring for upgrade to %s' % upgrade_prod_ver,
            }
            return super(ProductDeploymentAdmin, self).change_view(request, object_id, form_url, extra_context)

    @csrf_protect_m
    @transaction.atomic
    def upgrade(self, request, form_url='', extra_context=None):
        product_deploy_id = request.POST['product_deploy_id']
        product_deployment = ProductDeployment.objects.get(pk=product_deploy_id)
        new_prod_ver_id = int(request.POST[u'new_product_version_id'])
        #if product_deployment_history.current_product_version_id == new_prod_ver_id:
        #    return HttpResponse('%s current %s version is already %s' % (product_deployment_history.service_provider,
        #                                        product_deployment_history.product, product_deployment_history.current_product_version))
        new_prod_ver = ProductVersion.objects.get(id=new_prod_ver_id)
        action = ACTION_UPGRADE
        sp_id = int(request.POST[u'service_provider_id'])
        sp = ServiceProvider.objects.get(pk=sp_id)
        env_name = request.POST[u'environment']
        environment = Environment(name=env_name)
        sp_str = 'SP%s_%s' % (sp.id, sp.name)
        prod_ver_str = '%s_%s' % (new_prod_ver.product.name, new_prod_ver.version)
        # kit directory path couple with product.modles.get_kit_upload_relative_path function
        kit_str = "%s_%s.zip" % (new_prod_ver.deploy_kit.name, new_prod_ver.deploy_kit.version)

        component_package = ComponentPackage.objects.filter(product_version_id=new_prod_ver_id)
        id_list = []
        for com in component_package:
            id_list.append(com.component_id)
        components = Component.objects.filter(product_id=new_prod_ver.product_id, id__in=id_list)

        component_config = []
        for com in components:
            temp_dict = dict()
            temp_dict['component'] = com

            if not ('server_' + str(com.id)) in request.POST:
                continue
            server_list = request.POST.getlist('server_' + str(com.id))
            if not len(server_list) > 0:
                continue
            temp_dict['server'] = server_list
            #if not temp_dict['server']:
            #    return HttpResponse('You must select a server for component %s' % com.name)
            config_list = ConfigTemplateItem.objects.filter(component=com)
            for item in config_list:
                item.defult_value = request.POST['config_' + str(item.id)]
            temp_dict['config_list'] = config_list
            component_config.append(temp_dict)

        product_deployment_record = ProductDeploymentHistory(service_provider_id=sp_id, product_version=new_prod_ver,
                operator=request.user, action=action, environment=environment, product_deployment_id=product_deploy_id)
        product_deployment_record.save()

        key_value_template = "<add key=\"%s\" value=\"%s\" />\r\n"
        puppet_config_content_dict = {}
        component_config_content_list = dict()
        kit_config_content_list = dict()

        for com in component_config:
            package_list = ComponentPackage.objects.filter(component=com['component'], product_version=new_prod_ver_id) \
                                    .order_by('-id')
            if package_list.count():
                component_package = package_list[0]
            else:
                continue
            component_deployment = ComponentDeploymentHistory(service_provider_id=sp_id,
                                                       product_deployment_history_id=product_deployment_record.id,
                                                       product_deployment_id=product_deployment.id,
                                                       operator=request.user, action=action, environment=environment,
                                                       component_package_id=component_package.id)
            component_deployment.save()
            component_deployment.server = com['server']
            component_deployment.save()

            server_list = []
            for serverid in com['server']:
                server_list.append(Server.objects.get(pk=serverid))

            component_config_content = []
            kit_config_content = []
            for config in com['config_list']:
                config.defult_value = config.defult_value.replace('%SPID%', str(sp_id))
                config.defult_value = config.defult_value.replace('%SPNAME%', sp.name.replace(' ', '-'))
                config.defult_value = config.defult_value.replace('%ENV%', environment.name)
                config.defult_value = config.defult_value.replace('%ACTION%', action)
                config.defult_value = config.defult_value.replace('%VERSION%', new_prod_ver.version)
                config.defult_value = config.defult_value.replace('%PRODUCT%', new_prod_ver.product.name)

                new_config = ConfigItem(key_name=config.key_name, value=config.defult_value, type=config.type,
                                        product_deployment_id=product_deployment_record.id,
                                        component_deploy_id=component_deployment.id,
                                        component_package=component_package, config_template_item_id=config.id)
                new_config.save()
                if config.type == CONFIG_ITEM_COMPONENT:
                    component_config_content.append(key_value_template % (config.key_name, config.defult_value))
                else:
                    kit_config_content.append(key_value_template % (config.key_name, config.defult_value))

            relative_config_path = os.path.join(PRODUCT_CONFIG_FOLDER, sp_str, prod_ver_str)
            com['component'].config_path = com['component'].config_path.replace('%SPID%', str(sp_id))
            com['component'].config_path = com['component'].config_path.replace('%SPNAME%', sp.name.replace(' ', '-'))
            com['component'].config_path = com['component'].config_path.replace('%SERVER%', server.name)
            com['component'].config_path = com['component'].config_path.replace('%ENV%', environment.name)
            com['component'].config_path = com['component'].config_path.replace('%ACTION%', action)
            com['component'].config_path = com['component'].config_path.replace('%VERSION%', new_prod_ver.version)
            com['component'].config_path = com['component'].config_path.replace('%PRODUCT%', new_prod_ver.product.name)

            kit_config_content.append(key_value_template % ('DstConfigPath', com['component'].config_path))
            kit_config_content.append(key_value_template % ('ComponetPackagePath',
                                                            '../../../'+get_component_upload_relative_path(component_package)))
            # only for minorupgrade for testing environment
            if env_name == ENVIRONMENT_TESTING and action.upper() == 'upgrade':
                kit_config_content.append(key_value_template % ('ActionType', 'MINORUPGRADE'))
            else:
                kit_config_content.append(key_value_template % ('ActionType', action.upper()))
            if sp is not None:
                kit_config_content.append(key_value_template % ('SpId', sp_id))
                kit_config_content.append(key_value_template % ('SpName', sp.name))

            for server in server_list:
                # kit and component filename
                config_filename = '%s_%s@%s' % (product_deployment_record.id, com['component'].name, server.name)
                # relative path of kit and component config

                if not os.path.exists(os.path.join(PUPPET_FILES_PATH, relative_config_path)):
                    os.makedirs(os.path.join(PUPPET_FILES_PATH, relative_config_path))
                # save component config
                component_config_path = os.path.join(relative_config_path, config_filename + '.config')
                fileHandle = open(os.path.join(PUPPET_FILES_PATH, component_config_path), 'w')
                fileHandle.write('<deployConfiguration>\r\n'+''.join(component_config_content)+'</deployConfiguration>')
                fileHandle.close()

                # save deploy kit config
                kit_config_content.append(key_value_template % ('SrcConfigPath', '../../../'+component_config_path))
                kit_config_path = os.path.join(relative_config_path, config_filename + '.xml')
                kit_config_content_str = '<Service type="%s">\r\n%s\r\n</Service>' % (com['component'].name.upper(), ''.join(kit_config_content))
                fileHandle = open(os.path.join(PUPPET_FILES_PATH, kit_config_path), 'w')
                fileHandle.write(kit_config_content_str)
                fileHandle.close()

                deploy_kit_path = get_kit_upload_relative_path(new_prod_ver.deploy_kit)
                puppet_config_content = '''
    autodeploycomponent {"%s":
        product_version => '%s',
        service_provider => '%s',
        component_name => '%s',
        package_filename => '%s',
        component_config_filename => '%s',
        kit_config_filename => '%s',
        kit_package_filename =>'%s',
        kit_name =>'%s',
        kit_version =>'%s',
    }\r\n''' % (config_filename, prod_ver_str, sp_str, com['component'].name, get_component_upload_relative_path(component_package),
              component_config_path,  kit_config_path, deploy_kit_path, new_prod_ver.deploy_kit.name, new_prod_ver.deploy_kit.version)

                if not server.name in puppet_config_content_dict:
                    puppet_config_content_dict[server.name] = []
                puppet_config_content_dict[server.name].append(puppet_config_content)
                #store config path into database
                component_deployment.deploykit_config_file = os.path.join(PUPPET_FILES_PATH, kit_config_path)
                component_deployment.component_config_file = os.path.join(PUPPET_FILES_PATH, component_config_path)
                # todo add content
                #component_deployment.deploykit_config_content = kit_config_content_str
                #component_deployment.component_config_content = '<deployConfiguration>\r\n'+''.join(component_config_content)+'</deployConfiguration>'
                component_deployment.save()
                component_config_content_list[component_config_path] = component_config_content
                kit_config_content_list[kit_config_path] = kit_config_content

        # save puppet config below
        # relative path of puppet pp config file
        relative_puppet_config_path = os.path.join(new_prod_ver.product.name, sp_str, prod_ver_str)
        # !!tightly couple with puppet module, refer /etc/puppet/module/$environment/$module_name/manifest/init.pp
        puppet_config_folder = os.path.join(PUPPET_MANIFEST_PATH, DEFAULT_ENVIRONMENT, relative_puppet_config_path)
        if not os.path.exists(puppet_config_folder):
            os.makedirs(puppet_config_folder)
        puppet_config_filename = '%s@%s.pp' % (action, datetime.datetime.now().strftime('%Y%m%d-%H%M%S'))
        puppet_config = os.path.join(puppet_config_folder, puppet_config_filename)
        puppet_config_file = open(puppet_config, 'a')
        try:
            # output puppet config of each server node
            all_puppet_config_content = ''
            for (k, v) in puppet_config_content_dict.items():
                node_content = '''node '%s'{
    include windows_7z
    %s
}\r\n\r\n''' % (k, ''.join(v))
            all_puppet_config_content += node_content
            puppet_config_file.write(all_puppet_config_content)
        finally:
            puppet_config_file.close()

        # store puppet config into database
        product_deployment_record.puppet_config_file = puppet_config
        # todo add content
        product_deployment_record.puppet_config_content = all_puppet_config_content
        product_deployment_record.save()

        # wirte config to puppet site.pp(actually run_once.pp import by site.pp)
        site_config_content = 'import \'%s\'\r\n' % os.path.join(relative_puppet_config_path, puppet_config_filename)
        site_config = os.path.join(PUPPET_MANIFEST_PATH, DEFAULT_ENVIRONMENT, 'run_once.pp')
        history_config = os.path.join(PUPPET_MANIFEST_PATH, DEFAULT_ENVIRONMENT, 'autodeploy_history.pp')
        site_file = open(site_config, 'w')
        site_file.write(site_config_content)
        site_file.close()
        history_file = open(history_config, 'a')
        history_file.write('#'+site_config_content)
        history_file.close()

        # upgrade finished ,update ProductDeployment
        product_deployment = ProductDeployment.objects.get(pk=product_deploy_id)
        product_deployment.current_product_version_id = new_prod_ver_id
        product_deployment.save()

        # no component deployed actually
        if len(component_config_content_list) == 0:
            product_deployment_record.delete()
            return HttpResponse('None component deployed')

        # generate upgrade report, show component_config_content_list,kit_config_content_list,puppet_config_content_list repeatedly
        report = '</ br>Deploy Successfully</ br> <pre>'
        for k, v in component_config_content_list.items():
            content = ('<deployConfiguration>\r\n'+''.join(v)+'</deployConfiguration>').replace('<', '&lt;').replace('>', '&gt;')
            report += 'PRODUCT_CONFIG : %s<br/>%s<br/><br/>' % (k, content)

        for k, v in kit_config_content_list.items():
            content = ''.join(v).replace('<', '&lt;').replace('>', '&gt;')
            report += 'DEPLOY_KIT_CONFIG : %s<br/>%s<br/><br/>' % (k, content)

        for k, v in puppet_config_content_dict.items():
            report += '''PUPPET_CONFIG for node %s:</ br>
node '%s'{
    include windows_7z
    %s
}<br/><br/>''' % (k, k, ''.join(v))
        return HttpResponse(report+'</pre>')

    @csrf_protect_m
    @transaction.atomic
    def upgrade_component_view(self, request, object_id, form_url='', extra_context=None):
        sdgf = object_id

        return HttpResponse('sdf')

    def get_urls(self):
        urls = super(ProductDeploymentAdmin, self).get_urls()
        my_urls = patterns('',
                           (r'^(\d+)/upgrade_component/$', self.upgrade_component_view),
                           (r'^deploy_config/$', self.deploy_config_view),
                           #(r'^select_production_version/$', self.select_production_version_view),
                           (r'^deploy/$', self.deploy),
                           (r'^upgrade/$', self.upgrade),
                           (r'^upgrade_config/$', self.upgrade_config_view),
                           )
        return my_urls + urls