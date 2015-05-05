import os

from django.db import models
from django.core.exceptions import ValidationError
from django.core.files.storage import FileSystemStorage
from autodeploy.settings import DEPLOY_KIT_FOLDER, PUPPET_FILES_PATH, COMPONENT_PACKAGE_UPLOAD_FOLDER, \
    PRODUCT_PACKAGE_UPLOAD_FOLDER, CONFIG_ITEM_CHOICES, CONFIG_ITEM_COMPONENT, DEFAULT_ENVIRONMENT, ENVIRONMENT_PRODUCTION,\
    ENVIRONMENT_STAGING, ENVIRONMENT_DEVELOPMENT, ENVIRONMENT_TESTING, PUPPET_ROOT_PATH, DJANGO_ROOT_URL, STATIC_URL

module = __name__[:__name__.find('.')]

class Product(models.Model):
    name = models.CharField(unique=True, max_length=100, help_text='Product name, 100 characters limit')
    description = models.CharField(max_length=300, blank=True, null=True,
                                   help_text='Product description, 300 characters limit')
    create_date = models.DateTimeField(auto_now_add=True)

    class Meta:
        verbose_name = 'Product'
        verbose_name_plural = 'Products (shared)'

    def __unicode__(self):
        return '%s' % self.name


def get_kit_upload_relative_path(instance):
    return os.path.join(DEPLOY_KIT_FOLDER, instance.name, "%s_%s.zip" % (instance.name, instance.version))


def get_kit_upload_full_path(instance, filename):
    path = os.path.join(PUPPET_FILES_PATH, get_kit_upload_relative_path(instance))
    return path


def validate_package_extension(value):
    filename = str(value)
    if not filename.lower().endswith('.zip'):
        raise ValidationError('all upload package must be zip file!!!')


def validate_version(value):
    if not value:
        return
    for i, ch in enumerate(value):
        if '0' <= ch <= '9' or ch == '.':
            continue
        else:
            raise ValidationError('Version field should only contain digit and dot')


#class OverwriteStorage(FileSystemStorage):
#    def get_available_name(self, name):
#        # If the filename already exists, remove it as if it was a true file system
#        if self.exists(name):
#            os.remove(name)
#        return name


class DeployKit(models.Model):
    name = models.CharField(max_length=100, help_text='make sure same with the .exe filename in this package')
    product = models.ForeignKey(Product, blank=True, null=True,
                                help_text='specify this kit is used to deploy which product')
    version = models.CharField(max_length=50, validators=[validate_version],
                               help_text='this deploy kit\'s version, only digit and dot available')
    package = models.FileField(upload_to=get_kit_upload_full_path, blank=True, null=True, help_text='only zip accepted',
                               validators=[validate_package_extension], storage=FileSystemStorage(PUPPET_FILES_PATH))
    package_url = models.URLField(blank=True, null=True, help_text='package download url')
    package_md5 = models.CharField(blank=True, null=True, max_length=64, help_text='package md5 sum')
    create_date = models.DateTimeField(auto_now_add=True)

    class Meta:
        verbose_name_plural = 'Deploy kits (shared)'
        unique_together = (('name', 'version', 'product'),)

    def __unicode__(self):
        if self.product:
            return '%s_%s for %s' % (self.name, self.version, self.product.name)
        else:
            return '[Kit]%s_%s' % (self.name, self.version)


class Component(models.Model):
    name = models.CharField(max_length=100, help_text='component name, 100 characters limit')
    description = models.CharField(max_length=300, blank=True, null=True,
                                   help_text='component description, 300 characters limit')
    product = models.ForeignKey(Product, blank=True, null=True,
                                help_text='specify this component belong to which product')
    #install_path = models.CharField(max_length=200, blank=True, null=True)
    config_path = models.CharField(max_length=200, default='config/deploy.config',
                                   help_text='component will load configuration file under this relative path, the variables below are also available')
    #is_deploy_kit = models.BooleanField(default=False, help_text='this deploy will be used to deploy this product, only one deploy kit component for one product')
    create_date = models.DateTimeField(auto_now_add=True)

    class Meta:
        verbose_name_plural = 'Components (shared,but not share config template)'
		
    def __unicode__(self):
        if self.product:
            return '[%s]%s for %s' % (self.id, self.name, self.product.name)
        else:
            return '[%s]%s' % (self.id, self.name)

            #def clean(self):
            #    if not self.is_deploy_kit:
            #        return
            #    count = Component.objects.filter(product=self.product, is_deploy_kit=True).count()
            #    if count > 0:
            #        raise ValidationError('this product already have a deploy kit component, please cancel present deploy kit mark before set this one as deploy kit')


def get_product_upload_relative_path(instance):
    return os.path.join(PRODUCT_PACKAGE_UPLOAD_FOLDER, '%s_%s' % (instance.product.name, instance.version),
                        "%s_%s.zip" % (instance.product.name, instance.version))


def get_product_upload_full_path(instance, filename):
    path = os.path.join(PUPPET_FILES_PATH, get_product_upload_relative_path(instance))
    #if os.path.exists(path):
    #    os.remove(path)
    return path


class ProductVersion(models.Model):
    product = models.ForeignKey(Product, help_text='specify this version package belong to which product')
    version = models.CharField(max_length=50, validators=[validate_version], help_text='only digit and dot available')
    package = models.FileField(upload_to=get_product_upload_full_path, blank=True, null=True,
                               help_text='only zip accepted',
                               validators=[validate_package_extension], storage=FileSystemStorage(PUPPET_FILES_PATH))
    package_url = models.URLField(blank=True, null=True, help_text='package download url')
    package_md5 = models.CharField(blank=True, null=True, max_length=64, help_text='package md5 sum')
    deploy_kit = models.ForeignKey(DeployKit, help_text='specify a deploy kit version to deploy or upgrade this product version')
    is_release = models.BooleanField(default=False,
                                     help_text='specify whether it can release in production env, only tester group could set this field')
    publish_date = models.DateTimeField(auto_now_add=True)

    class Meta:
        verbose_name = 'Product Version'
        verbose_name_plural = 'Product Versions (shared)'
        unique_together = (('product', 'version'),)

    def __unicode__(self):
        return '%s[%s]' % (self.product.name, self.version)


def get_component_upload_relative_path(instance):
    """return relative path of component package"""
    if instance.product_version is None:
        return os.path.join(COMPONENT_PACKAGE_UPLOAD_FOLDER, instance.component.name,
                            "%s.zip" % instance.component.name)
    else:
        return os.path.join(PRODUCT_PACKAGE_UPLOAD_FOLDER,
                            '%s_%s' % (instance.product_version.product.name, instance.product_version.version),
                            "%s_%s.zip" % (instance.component.name, instance.product_version.version))


def get_component_upload_full_path(instance, filename):
    path = os.path.join(PUPPET_FILES_PATH, get_component_upload_relative_path(instance))
    if os.path.exists(path):
        os.remove(path)
    return path


class ComponentPackage(models.Model):
    component = models.ForeignKey(Component, help_text='specify this component package belong to which component')
    product_version = models.ForeignKey(ProductVersion,
                                        help_text='specify this component package belong to which product version')
    package = models.FileField(upload_to=get_component_upload_full_path, blank=True, null=True,
                               help_text='only zip accepted',
                               validators=[validate_package_extension], storage=FileSystemStorage(PUPPET_FILES_PATH))
    package_url = models.URLField(blank=True, null=True, help_text='package download url')
    package_md5 = models.CharField(blank=True, null=True, max_length=64, help_text='package md5 sum')
    deploy_kit = models.ForeignKey(DeployKit)   # not shown ,assign value automatically
    create_date = models.DateTimeField(auto_now_add=True)

    class Meta:
        verbose_name = 'Component Package'
        verbose_name_plural = 'Component Packages (shared)'
        unique_together = (('product_version', 'component'),)

    def __unicode__(self):
        return '%s#%s' % (self.component.name, self.product_version)


# Config item key-value pair in component config template
class ConfigTemplateItem(models.Model):
    component = models.ForeignKey(Component)
    key_name = models.CharField(max_length=100)
    defult_value = models.CharField(max_length=300, blank=True, null=True)
    type = models.CharField(max_length=50, choices=CONFIG_ITEM_CHOICES, default=CONFIG_ITEM_COMPONENT)
    description = models.CharField(max_length=100, blank=True, null=True)

    class Meta:
        verbose_name = 'Config Template Item'
        verbose_name_plural = 'Config Template Items'
        unique_together = (('component', 'key_name', 'type'),)
        if DEFAULT_ENVIRONMENT == ENVIRONMENT_PRODUCTION or DEFAULT_ENVIRONMENT == ENVIRONMENT_STAGING:
            db_table = '%s_%s_%s' % (ENVIRONMENT_PRODUCTION, module, 'configitem')
        else:
            db_table = '%s_%s_%s' % (DEFAULT_ENVIRONMENT, module, 'configitem')

    def __unicode__(self):
        return '[%s:config]%s' % (self.component.name, self.key_name)

