from django.contrib import admin
from django import forms
from metadata.models import *
from deployment.models import ComponentDeploymentHistory, ProductDeploymentHistory
from deployment.product_deployment_admin import ProductDeployment


class ComponentDeploymentInline(admin.TabularInline):
    model = ComponentDeploymentHistory
    verbose_name_plural = 'Component deployments on this server'
    verbose_name = 'Component'
    extra = 0
    can_delete = False
    exclude = ('environment',)
    readonly_fields = ['service_provider', 'action', 'component_package', 'operator']

    def has_add_permission(self, request):
        return False


class ProductDeploymentHistoryInline(admin.TabularInline):
    model = ProductDeploymentHistory
    verbose_name_plural = 'Product deployments for this Service Provider'
    verbose_name = 'Product deployment'
    extra = 0
    can_delete = False
    ordering = ('-id',)
    exclude = ('product_deployment', 'puppet_config_content', 'service_provider')
    readonly_fields = ['product_version', 'environment', 'action', 'puppet_config_file', 'operator', 'create_date']

    def has_add_permission(self, request):
        return False


class ServerForm(forms.ModelForm):
    '''
    how to use form see here
    https://docs.djangoproject.com/en/1.6/ref/forms/api/
    '''

    class Meta:
        model = Server
        exclude = ['description']


class ServerAdmin(admin.ModelAdmin):
    list_display = ('__unicode__', 'name', 'internal_ip', 'environment')
    list_editable = ('name', 'internal_ip', 'environment')
    search_fields = ('name',)
    list_filter = ('environment',)
    form = ServerForm
    inlines = []

    def add_view(self, request, form_url='', extra_context=None):
        self.inlines = []
        return super(ServerAdmin, self).add_view(request)

    # only show deployment log on change view
    def change_view(self, request, object_id, form_url='', extra_context=None):
        #self.inlines = (ComponentDeploymentInline, )
        self.list_editable = ('name', 'internal_ip', 'environment')
        self.readonly_fields = []
        groupstr = ''
        for gourp in request.user.groups.all():
            groupstr = groupstr+gourp.name.lower()
        if groupstr.find('test') > -1:
            self.list_editable = ()
            self.inlines = ()
            self.readonly_fields = ['name', 'internal_ip','external_ip', 'environment']
        return super(ServerAdmin, self).change_view(request, object_id)


admin.site.register(Server, ServerAdmin)


class ServerInline(admin.TabularInline):
    model = Server
    verbose_name_plural = 'Server list of this environment'
    extra = 1
    can_delete = True
    #exclude = ('environment',)
    #readonly_fields = ['name', 'ip', 'description']


class EnvironmentAdmin(admin.ModelAdmin):
    inlines = []
    readonly_fields = []

    def add_view(self, request, form_url='', extra_context=None):
        self.inlines = []
        self.readonly_fields = []
        return super(EnvironmentAdmin, self).add_view(request)

    # only show server list on environment list view and make environment name readonly
    def change_view(self, request, object_id, form_url='', extra_context=None):
        self.inlines = [ServerInline, ]
        self.readonly_fields = ['name', ]
        return super(EnvironmentAdmin, self).change_view(request, object_id)
admin.site.register(Environment, EnvironmentAdmin)


class ServiceProviderAdmin(admin.ModelAdmin):
    search_fields = ('name',)
    list_display = ('name', 'address', 'telephone', 'email')
    #list_filter = ('name',)
    inlines = []

    def add_view(self, request, form_url='', extra_context=None):
        self.inlines = []
        return super(ServiceProviderAdmin, self).add_view(request)

    # only show deployment info on change view
    def change_view(self, request, object_id, form_url='', extra_context=None):
        # todo link ProductDeploymentinlines to ProductDeployment entity
        self.inlines = (ProductDeploymentHistoryInline, )  # ComponentInline,
        self.readonly_fields = []
        groupstr = ''
        for gourp in request.user.groups.all():
            groupstr = groupstr+gourp.name.lower()
        if groupstr.find('test') > -1:
            self.readonly_fields = ['name', 'address','telephone', 'email']
        return super(ServiceProviderAdmin, self).change_view(request, object_id)
admin.site.register(ServiceProvider, ServiceProviderAdmin)