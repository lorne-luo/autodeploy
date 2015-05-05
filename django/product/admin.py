import shutil

from django.contrib import admin
from django.db import transaction
from django.core.exceptions import FieldError

from product.models import *

from autodeploy.util import zip_dir, unzip, generate_url_md5


class ComponentPackageInline(admin.TabularInline):
    model = ComponentPackage
    verbose_name = 'Component Package'
    verbose_name_plural = 'Component Package in this Version'
    extra = 0
    readonly_fields = [ 'component', 'package_url', 'create_date']
    exclude = ['package', 'package_md5', ]

    def queryset(self, request):
        # only show the component package belong to this product version
        if request.resolver_match.url_name == u'product_productversion_change':
            pv_id = int(request.resolver_match.args[0])
            qs = ComponentPackage.objects.filter(product_version_id=pv_id)
            return qs
        else:
            return super(ComponentPackageInline, self).queryset(request)

    def has_add_permission(self, request):
        return False


class ComponentPackageReadonlyInline(admin.TabularInline):
    model = ComponentPackage
    verbose_name = 'Component Package'
    verbose_name_plural = 'Component Package in this Version'
    extra = 0
    readonly_fields = ['package_url', 'component', 'deploy_kit', 'create_date']
    exclude = ['package', 'package_md5', ]

    def queryset(self, request):
        # only show the component package belong to this product version
        if request.resolver_match.url_name == u'product_productversion_change':
            pv_id = int(request.resolver_match.args[0])
            qs = ComponentPackage.objects.filter(product_version_id=pv_id)
            return qs
        else:
            return super(ComponentPackageReadonlyInline, self).queryset(request)

    def has_add_permission(self, request):
        return False


class DeployKitAdmin(admin.ModelAdmin):
    search_fields = ('name', 'product')
    list_display = ('name', 'product', 'version', 'package_url')
    list_filter = ('product', 'name',)
    exclude = []
    #actions = ['some_other_action']

    def add_view(self, request, form_url='', extra_context=None):
        self.exclude = ['package_url', 'package_md5']
        self.readonly_fields = []
        return super(DeployKitAdmin, self).add_view(request, form_url, extra_context)

    def change_view(self, request, object_id, form_url='', extra_context=None):
        self.exclude = ['package_md5',]
        self.readonly_fields = ['package_url', ]
        groupstr = ''
        for gourp in request.user.groups.all():
            groupstr = groupstr+gourp.name.lower()
        if groupstr.find('test') > -1 or groupstr.find('maint') > -1:
            self.readonly_fields = ['package_url', 'name', 'product', 'version', 'package']
        return super(DeployKitAdmin, self).change_view(request, object_id, form_url, extra_context)

    def save_model(self, request, obj, form, change):
        if not change:
            if str(obj.package):
                package_path = get_kit_upload_full_path(obj, '').replace('\\', '/')
                if os.path.exists(package_path):
                    os.remove(package_path)
                # must save() before generate_url_md5(), to let package file upload to server,then file package_url and packge_md5 field
                obj.save()
                generate_url_md5(obj)
            else:
                obj.save()
        else:
            obj.save()
            if str(obj.package):
                new_path = get_kit_upload_full_path(obj, '').replace('\\', '/')
                old_path = str(obj.package).replace('\\', '/')
                if old_path != new_path:
                    if not os.path.exists(old_path):
                        raise FieldError('%s not exist!' % old_path)
                    if os.path.exists(new_path):
                        os.remove(new_path)
                    if not os.path.exists(os.path.dirname(new_path)):
                        os.makedirs(os.path.dirname(new_path))
                    shutil.move(old_path, new_path)
                    obj.package = new_path
                    generate_url_md5(obj)

    def delete_model(self, request, obj):
        if os.path.exists(str(obj.package)):
            os.remove(str(obj.package))
        obj.delete()


admin.site.register(DeployKit, DeployKitAdmin)


class ProductVersionAdmin(admin.ModelAdmin):
    # customize class change list template
    #change_list_template = 'admin/productversion_change_list.html'
    search_fields = ('product', 'version')
    list_display = ('product', 'version', 'package', 'is_release')
    list_filter = ('product', 'version', 'is_release')
    ordering = ('-id',)
    inlines = []
    exclude = []

    def has_delete_permission(self, request, obj=None):
        return True if request.user.is_superuser else False

    def add_view(self, request, form_url='', extra_context=None):
        self.exclude = ['is_release', 'package_url', 'package_md5']
        self.inlines = []
        self.readonly_fields = []
        return super(ProductVersionAdmin, self).add_view(request)

    def change_view(self, request, object_id, form_url='', extra_context=None):
        self.inlines = [ComponentPackageInline, ]
        self.exclude = ['is_release']
        self.readonly_fields = ['package_url', 'package_md5']

        if request.user.is_superuser:
            self.exclude = []
        else:
            groupstr = ''
            for gourp in request.user.groups.all():
                groupstr = groupstr+gourp.name.lower()
            if groupstr.find('test') > -1:
                self.exclude = []
                self.inlines = [ComponentPackageReadonlyInline, ]
                self.readonly_fields = ['product', 'version', 'package', 'deploy_kit', 'publish_date',
                                        'package_url', 'package_md5']
            if groupstr.find('maint') > -1:
                self.inlines = [ComponentPackageReadonlyInline, ]
                self.readonly_fields = ['product', 'version', 'package', 'deploy_kit', 'publish_date',
                                        'package_url', 'package_md5']

        return super(ProductVersionAdmin, self).change_view(request, object_id)

    @transaction.atomic
    def save_model(self, request, obj, form, change):
        obj.save()
        package_path = str(obj.package)
        if not change:
            # add entity
            if package_path:
                if not os.path.exists(package_path):
                    raise FieldError('% not exist!' % package_path)
                upload_path = get_product_upload_full_path(obj, '').replace('\\', '/')
                #if os.path.exists(upload_path):
                #    os.remove(upload_path)
                package_dir_path = os.path.join(os.path.dirname(package_path), 'temp')
                # unzip package
                unzip(package_path, package_dir_path)
                # get component list
                component_list = Component.objects.filter(product=obj.product)
                for com in component_list:
                    com_dir = os.path.join(package_dir_path, com.name)
                    if not os.path.exists(com_dir):
                        continue
                    zip_filename = '%s_%s.zip' % (com.name, obj.version)
                    zip_file = os.path.join(os.path.dirname(package_path), zip_filename)
                    if os.path.isfile(zip_file):
                        os.remove(zip_file)
                    zip_dir(com_dir, zip_file)

                    cp_filter = ComponentPackage.objects.filter(component=com, product_version=obj)
                    if cp_filter.count() > 0:
                        # already have one, update it
                        com_pack = cp_filter[0]
                        com_pack.deploy_kit = obj.deploy_kit
                        com_pack.package = zip_file
                    else:
                        # add new
                        com_pack = ComponentPackage(component=com, product_version=obj, deploy_kit=obj.deploy_kit,
                                                    package=zip_file)
                    com_pack.save()
                    # generate package url and md5
                    generate_url_md5(com_pack)
                    # delete temp folder
                shutil.rmtree(package_dir_path)
                # generate package url and md5
                generate_url_md5(obj)
            obj.save()
        else:
            # change entity
            if package_path:
                new_path = get_product_upload_full_path(obj, '').replace('\\', '/')
                old_path = str(obj.package).replace('\\', '/')
                #storage path changed
                if old_path != new_path:
                    if not os.path.exists(old_path):
                        raise FieldError('%s not exist!' % old_path)
                    if os.path.exists(new_path):
                        os.remove(new_path)
                    new_folder = os.path.dirname(new_path)
                    if not os.path.exists(new_folder):
                        os.makedirs(new_folder)
                    old_folder = os.path.dirname(old_path)

                    component_list = Component.objects.filter(product=obj.product)
                    for com in component_list:
                        cp_filter = ComponentPackage.objects.filter(component=com, product_version=obj)
                        if cp_filter.count() > 0:
                            # this component have package, update it
                            com_pack = cp_filter[0]
                            com_pack.deploy_kit = obj.deploy_kit
                            if not os.path.exists(str(com_pack.package)):
                                com_pack.package = None
                            if os.path.dirname(str(com_pack.package)) != new_path:
                                zip_filename = '%s_%s.zip' % (com.name, obj.version)
                                new_cp_path = os.path.join(new_folder, zip_filename)
                                if os.path.exists(new_cp_path):
                                    os.remove(new_cp_path)
                                shutil.copy(str(com_pack.package), new_cp_path)
                                com_pack.package = new_cp_path
                            com_pack.save()
                            # generate package url and md5
                            generate_url_md5(com_pack)
                    shutil.copy(old_path, new_path)
                    obj.package = new_path
                    generate_url_md5(obj)
                    shutil.rmtree(old_folder)
            obj.save()

    def delete_model(self, request, obj):
        folder = os.path.dirname(str(obj.package))
        if os.path.exists(folder):
            shutil.rmtree(folder)
        obj.delete()


admin.site.register(ProductVersion, ProductVersionAdmin)


class ProductVersionChangeInline(admin.TabularInline):
    model = ProductVersion
    verbose_name_plural = 'This Product have following version already'
    verbose_name = 'Product Version'
    extra = 0
    can_delete = True
    max_num = None
    readonly_fields = ['is_release', 'deploy_kit', 'version']
    exclude = ['package_url', 'package_md5', ]

class ProductVersionReadonlyInline(admin.TabularInline):
    model = ProductVersion
    verbose_name_plural = 'This Product have following version already'
    verbose_name = 'Product Version'
    extra = 0
    can_delete = True
    max_num = None
    readonly_fields = ['package_url', 'deploy_kit', 'version']
    exclude = ['package', 'package_md5', ]


class ProductVersionAddInline(admin.TabularInline):
    model = ProductVersion
    verbose_name_plural = 'Add Version for this Product now'
    verbose_name = 'Product Version'
    extra = 1
    can_delete = False
    max_num = 1


class ComponentInline(admin.TabularInline):
    model = Component
    #template = 'admin/edit_inline/tabular.html'
    extra = 0
    can_delete = True
    verbose_name_plural = 'This Product have these components'
    verbose_name = 'Component'
    readonly_fields = ['name', 'description']
    exclude = ['config_path']

    def has_add_permission(self, request):
        return False


class ProductAdmin(admin.ModelAdmin):
    inlines = ()
    search_fields = ('name',)
    fields = [('name', 'description'), ]
    list_display = ('name', 'description', 'create_date')
    list_filter = ('name',)
    #date_hierarchy = 'create_date'
    ordering = ('-id',)

    #def has_delete_permission(self, request, obj=None):
    #    return True if request.user.is_superuser else False

    # different InlineAdmin for add and change view
    def add_view(self, request, form_url='', extra_context=None):
        #self.inlines = (ProductVersionAddInline, )
        return super(ProductAdmin, self).add_view(request)

    def change_view(self, request, object_id, form_url='', extra_context=None):
        self.exclude = []
        self.inlines = (ComponentInline, ProductVersionChangeInline, )  # add ComponentInline if needed
        groupstr = ''
        for gourp in request.user.groups.all():
            groupstr = groupstr+gourp.name.lower()
        if groupstr.find('test') > -1 or groupstr.find('maint') > -1:
            self.readonly_fields = ['name', 'description', 'create_date']
            self.inlines = (ComponentInline, ProductVersionReadonlyInline, )
        else:
            self.readonly_fields = []
        return super(ProductAdmin, self).change_view(request, object_id)


admin.site.register(Product, ProductAdmin)


class ConfigTemplateItemInline(admin.TabularInline):
    model = ConfigTemplateItem
    verbose_name = 'Comfig Template Item'
    verbose_name_plural = 'Component Config Template Item: (Key name could not be duplicate)'
    exclude = ['environment']
    extra = 1

#admin.site.register(ConfigTemplateItem)


class ComponentAdmin(admin.ModelAdmin):
    change_form_template = 'admin/component_change_form.html'
    inlines = [ConfigTemplateItemInline, ]
    search_fields = ('name', 'description')
    list_display = ('name', 'product', 'description')
    list_filter = ('product', 'name',)

    def change_view(self, request, object_id, form_url='', extra_context=None):
        self.inlines = (ConfigTemplateItemInline, )
        self.readonly_fields = []
        groupstr = ''
        for gourp in request.user.groups.all():
            groupstr = groupstr+gourp.name.lower()
        if groupstr.find('test') > -1 or groupstr.find('maint') > -1:
            self.readonly_fields = ['name', 'description', 'product', 'config_path']
        return super(ComponentAdmin, self).change_view(request, object_id)

admin.site.register(Component, ComponentAdmin)


class ConfigTemplateItemAdmin(admin.ModelAdmin):
    list_display = ('component', 'key_name', 'defult_value')
    list_editable = ('defult_value',)
    list_filter = ('component',)


#admin.site.register(ConfigTemplateItem, ConfigTemplateItemAdmin)


class ComponentPackageAdmin(admin.ModelAdmin):
    search_fields = ('component', 'product_version')
    list_display = ('__unicode__', 'package', 'package_url')
    list_filter = ('component', 'product_version')
    ordering = ('-id',)

    def add_view(self, request, form_url='', extra_context=None):
        self.exclude = ['package_url', 'package_md5']
        self.readonly_fields = []
        return super(ComponentPackageAdmin, self).add_view(request, form_url, extra_context)

    def change_view(self, request, object_id, form_url='', extra_context=None):
        self.exclude = []
        self.readonly_fields = ['package_url', 'package_md5']
        groupstr=''
        for gourp in request.user.groups.all():
            groupstr=groupstr+gourp.name.lower()
        if groupstr.find('test') > -1:
            self.readonly_fields = ['component', 'product_version', 'package', 'deploy_kit', 'package_url',
                                    'package_md5', 'create_date']
        return super(ComponentPackageAdmin, self).change_view(request, object_id)

    def save_model(self, request, obj, form, change):
        # add new
        if not change:
            if str(obj.package):
                package_path = get_component_upload_full_path(obj, '').replace('\\', '/')
                if os.path.exists(package_path):
                    os.remove(package_path)
                # must save() before generate_url_md5, to let package file upload to server,then file package_url and packge_md5 field
                obj.save()
                generate_url_md5(obj)
            else:
                obj.save()
        # change
        else:
            obj.save()
            if str(obj.package):
                new_path = get_component_upload_full_path(obj, '').replace('\\', '/')
                old_path = str(obj.package).replace('\\', '/')
                if old_path != new_path:
                    if not os.path.exists(old_path):
                        raise FieldError('%s not exist!' % old_path)
                    if os.path.exists(new_path):
                        os.remove(new_path)
                    if not os.path.exists(os.path.dirname(new_path)):
                        os.makedirs(os.path.dirname(new_path))
                    shutil.move(old_path, new_path)
                    obj.package = new_path
                    generate_url_md5(obj)

    def delete_model(self, request, obj):
        if os.path.exists(str(obj.package)):
            os.remove(str(obj.package))
        obj.delete()


admin.site.register(ComponentPackage, ComponentPackageAdmin)
