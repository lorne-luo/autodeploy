import os
import datetime

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
from autodeploy.settings import COMPONENT_CONFIG_PATH, COMPONENT_CONFIG_FOLDER,PRODUCT_CONFIG_FOLDER,\
    PUPPET_MANIFEST_PATH, ACTION_DEPLOY, ACTION_UPGRADE


IS_POPUP_VAR = '_popup'
csrf_protect_m = method_decorator(csrf_protect)


class ComponentForm(ModelForm):
    #name = forms.CharField(max_length=100)

    class Meta:
        model = Component
        fields = ['name']
        #, 'description'


class ComponentDeploymentHistoryInline(admin.StackedInline):
    model = ComponentDeploymentHistory
    verbose_name = 'Component deployment config history'
    verbose_name_plural = 'Component deployment config history'
    exclude = ('service_provider', 'action', 'operator', 'environment', 'former_upgrade_id', 'deploykit_config_file', 'component_config_file')
    extra = 0
    readonly_fields = ['component_package', 'server', 'product_deployment']
    #form = ComponentForm
    #raw_id_fields = ("component_package",)
    #modelform_factory(Component, fields=["pub_date", ])

    #def formfield_for_foreignkey(self, db_field, request, **kwargs):
    #    if db_field.name == "component_package":
    #        kwargs["queryset"] = ComponentPackage.objects.all()
    #    return super(ProductDeploymentHistoryAdmin, self).formfield_for_foreignkey(db_field, request, **kwargs)

    def has_add_permission(self, request):
        return False


class ComponentInline(admin.StackedInline):
    model = Component


from product_deployment_admin import ProductDeploymentAdmin

admin.site.register(ProductDeployment, ProductDeploymentAdmin)


class ProductDeploymentHistoryForm(ModelForm):
    class Meta:
        model = ProductDeploymentHistory

    # doc limit product version select option in when upgrade
    def __init__(self, *args, **kwargs):
        super(ProductDeploymentHistoryForm, self).__init__(*args, **kwargs)
        if 'instance' in kwargs:
            prod_id = self.instance.product_version.product.id
            if 'product_version' in self.fields:
                self.fields['product_version'].queryset = ProductVersion.objects.filter(
                    product__id=prod_id).order_by('-id')


class ProductDeploymentHistoryAdmin(admin.ModelAdmin):
    change_list_template = None
    delete_confirmation_template = None
    object_history_template = None
    form = ProductDeploymentHistoryForm
    search_fields = ('service_provider', 'product_version', 'operator')
    list_display = ('service_provider', 'action', 'product_version', 'puppet_config_link', 'operator', 'create_date')
    list_filter = ('service_provider', 'action', 'product_version')
    exclude = ['operator', 'former_upgrade_id']
    inlines = [ComponentDeploymentHistoryInline, ]
    #form = ComponentForm

    def has_add_permission(self, request):
        return True if request.user.is_superuser else False

    def has_delete_permission(self, request, obj=None):
        return True if request.user.is_superuser else False

    # special process for service_provider and product_version
    def formfield_for_foreignkey(self, db_field, request, **kwargs):
        if db_field.name == "component_package":
            kwargs["queryset"] = ComponentPackage.objects.all()
        return super(ProductDeploymentHistoryAdmin, self).formfield_for_foreignkey(db_field, request, **kwargs)

    def add_view(self, request, form_url='', extra_context=None):
        if request.user.is_superuser:
            return super(ProductDeploymentHistoryAdmin, self).add_view(request, form_url, extra_context)
        return super(ProductDeploymentHistoryAdmin, self).changelist_view(request, extra_context)

    def change_view(self, request, object_id, form_url='', extra_context=None):
        if request.user.is_superuser:
            self.change_form_template = None
            return super(ProductDeploymentHistoryAdmin, self).change_view(request, object_id, form_url, extra_context)
        self.readonly_fields = ('product_version', 'action', 'service_provider', 'environment', 'puppet_config_file',
                                'product_deployment', 'operator', 'create_date', 'puppet_config_content')
        self.change_form_template = 'admin/product_history_change_form.html'
        self.exclude = ['former_upgrade_id', 'action']
        product_deploy_record = ProductDeploymentHistory.objects.get(pk=object_id)
        deploy_component_list = ComponentDeploymentHistory.objects.filter(product_deployment=product_deploy_record.id)
        env_name = product_deploy_record.environment.name
        environment = Environment(name=env_name)
        server_list = Server.objects.filter(environment=product_deploy_record.environment)
        #form_url = '../upgrade/'

        deployment_config = []
        for deploy in deploy_component_list:
            temp_list = {}
            component = Component.objects.get(pk=deploy.component_package.component_id)
            temp_list['component'] = component
            temp_list['server_id'] = deploy.server.id
            config_list = []

            config_history_list = ConfigItem.objects.filter(product_deployment=object_id, component_deploy=deploy.id)
            for item in config_history_list:
                config_list.append({'id': item.config_template_item.id, 'key_name': item.key_name, 'value': item.value})

            # if there is new config template item,add it into history config set
            config_template_list = ConfigTemplateItem.objects.filter(component=component)
            for item in config_template_list:
                count = config_history_list.filter(config_template_item_id=item.id).count()
                if count == 0:
                    config_list.append({'id': item.id, 'key_name': item.key_name, 'value': item.defult_value})

            temp_list['configs'] = config_list
            deployment_config.append(temp_list)

        extra_context = {
            'title': _('Product Deploy Configuration History'),
            'deployment_config': deployment_config,
            'server_list': server_list,
            'service_provider_id': product_deploy_record.service_provider_id,
            'action': ACTION_UPGRADE,
            'product_version_id': product_deploy_record.product_version_id,
            'environment': product_deploy_record.environment.name,
            'product_version': product_deploy_record.product_version.version,
            'upgrade_id': object_id,
        }
        return super(ProductDeploymentHistoryAdmin, self).change_view(request, object_id, form_url, extra_context)

    def get_urls(self):
        urls = super(ProductDeploymentHistoryAdmin, self).get_urls()
        my_urls = patterns('',
                           #(r'^deploy_config/$', self.deploy_config_view),
                           #(r'^deploy/$', self.deploy),
                           #(r'^upgrade/$', self.upgrade),
        )
        return my_urls + urls

    # automatically fill 'operator' field
    def save_model(self, request, obj, form, change):
        instance = form.save(commit=False)
        if not hasattr(instance, 'operator'):
            instance.operator = request.user
        instance.save()
        form.save_m2m()
        return instance

    def save_formset(self, request, form, formset, change):

        def set_user(instance):
            if not instance.operator:
                instance.operator = request.user
            instance.save()

        if formset.model == ProductDeploymentHistory:
            instances = formset.save(commit=False)
            map(set_user, instances)
            formset.save_m2m()
            return instances
        else:
            return formset.save()

admin.site.register(ProductDeploymentHistory, ProductDeploymentHistoryAdmin)


class ComponentDeploymentHistoryForm(ModelForm):
    class Meta:
        model = ComponentDeploymentHistory

    def __init__(self, *args, **kwargs):
        super(ComponentDeploymentHistoryForm, self).__init__(*args, **kwargs)
        #if 'instance' in kwargs:
        #    self.fields['component_package'].queryset = ComponentPackage.objects.filter(
        #        component__id=self.instance.component_package.component.id)


class ComponentDeploymentHistoryAdmin(admin.ModelAdmin):
    form = ComponentDeploymentHistoryForm
    search_fields = ('service_provider', 'server', 'component_package', 'operator')
    list_display = ('service_provider', 'action', 'component_package', 'operator', 'create_date')
    list_filter = ('service_provider', 'action', 'component_package')
    exclude = ['operator', 'former_upgrade_id']

    # automatically fill 'operator' field
    def save_model(self, request, obj, form, change):
        instance = form.save(commit=False)
        if not hasattr(instance, 'operator'):
            instance.operator = request.user
        instance.save()
        form.save_m2m()
        return instance

    def save_formset(self, request, form, formset, change):
        def set_user(instance):
            if not instance.operator:
                instance.operator = request.user
            instance.save()
        if formset.model == ComponentDeploymentHistory:
            instances = formset.save(commit=False)
            map(set_user, instances)
            formset.save_m2m()
            return instances
        else:
            return formset.save()

    def add_view(self, request, form_url='', extra_context=None):
        if request.user.is_superuser:
            return super(ComponentDeploymentHistoryAdmin, self).add_view(request, form_url, extra_context)

        return super(ComponentDeploymentHistoryAdmin, self).changelist_view(request, extra_context)

    # only superuser can delete
    def has_delete_permission(self, request, obj=None):
        return True if request.user.is_superuser else False

    def has_add_permission(self, request):
        return True if request.user.is_superuser else False

    def get_urls(self):
        urls = super(ComponentDeploymentHistoryAdmin, self).get_urls()
        my_urls = patterns('',
                           #(r'^deploy_config/$', self.deploy_config_view),
                           #(r'^deploy/$', self.deploy),
                           #(r'^upgrade/$', self.upgrade),
        )
        return my_urls + urls

    def change_view(self, request, object_id, form_url='', extra_context=None):
        if request.user.is_superuser:
            self.change_form_template = None
            return super(ComponentDeploymentHistoryAdmin, self).change_view(request, object_id, form_url, extra_context)
        self.change_form_template = 'admin/component_deployment_history_change_form.html'
        self.readonly_fields = ('component_package', 'deploykit_config_file', 'component_config_file',
            'service_provider', 'action', 'environment', 'server', 'operator', 'product_deployment_history',
            'create_date', 'product_deployment')
        self.exclude = ['former_upgrade_id', 'action']
        deploy_component = ComponentDeploymentHistory.objects.get(pk=object_id)
        #environment = Environment(name=deploy_component.environment)
        server_id = deploy_component.server_id
        server_list = Server.objects.filter(environment=deploy_component.environment)
        config_item_list = ConfigItem.objects.filter(component_deploy=deploy_component.id)
        config_list = []
        for item in config_item_list:
            config_list.append({'id': item.config_template_item.id, 'key_name': item.key_name, 'value': item.value})
        config_template_list = ConfigTemplateItem.objects.filter(
            component_id=deploy_component.component_package.component_id)
        for item in config_template_list:
            count = config_item_list.filter(config_template_item_id=item.id).count()
            if count == 0:
                config_list.append({'id': item.id, 'key_name': item.key_name, 'value': item.defult_value})
        form_url = '../upgrade/'

        extra_context = {
            'title': _('Modify Upgrade Configuration for this component'),
            'server_list': server_list,
            'service_provider_id': deploy_component.service_provider_id,
            'action': ACTION_UPGRADE,
            'product_version_id': deploy_component.component_package.product_version_id,
            'environment': deploy_component.environment.name,
            'product_version': deploy_component.component_package.product_version.version,
            'config_list': config_list,
            'upgrade_id': object_id,
            'server_id': server_id,
            'component_package_id': deploy_component.component_package.id
        }
        return super(ComponentDeploymentHistoryAdmin, self).change_view(request, object_id, form_url, extra_context)


admin.site.register(ComponentDeploymentHistory, ComponentDeploymentHistoryAdmin)


#admin.site.register(ConfigItem)

