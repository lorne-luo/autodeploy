from django.contrib.auth.models import User
from django.db import models
import os
from metadata.models import ServiceProvider, Environment, Server
from product.models import Product, ProductVersion, Component, ComponentPackage, ConfigTemplateItem, DeployKit
from autodeploy.settings import ACTION_CHOICES, ACTION_DEPLOY, ACTION_UPGRADE, PRODUCT_STATUS, PRODUCT_STATUS_STOPPED,\
    DEFAULT_ENVIRONMENT, ENVIRONMENT_PRODUCTION, ENVIRONMENT_STAGING, ENVIRONMENT_DEVELOPMENT, CONFIG_ITEM_CHOICES,CONFIG_ITEM_COMPONENT

module = __name__[:__name__.find('.')]


class ProductDeployment(models.Model):
    product = models.ForeignKey(Product, help_text='which product will be deployed&upgraded')
    service_provider = models.ForeignKey(ServiceProvider, help_text='product will be deployed&upgrade for which SP')
    environment = models.ForeignKey(Environment, help_text='make this deployment on which envrionment\'s servers')
    current_product_version = models.ForeignKey(ProductVersion, help_text='if newly deploy, select deploying version here')
    operator = models.ForeignKey(User, blank=True, null=True)
    create_date = models.DateTimeField(auto_now_add=True, editable=True)

    class Meta:
        verbose_name = 'Product Deploy & Upgrade'
        verbose_name_plural = verbose_name
        #unique_together = (('service_provider', 'environment', 'product'),)
        if DEFAULT_ENVIRONMENT == ENVIRONMENT_PRODUCTION or DEFAULT_ENVIRONMENT == ENVIRONMENT_STAGING:
            db_table = '%s_%s_%s' % (ENVIRONMENT_PRODUCTION, module, 'productdeployment')
        else:
            db_table = '%s_%s_%s' % (DEFAULT_ENVIRONMENT, module, 'productdeployment')

    def __unicode__(self):
        return "[%s]%s_%s" % (self.id, self.service_provider, self.current_product_version)


class ProductDeploymentHistory(models.Model):
    product_version = models.ForeignKey(ProductVersion)
    service_provider = models.ForeignKey(ServiceProvider)
    action = models.CharField(max_length=10, choices=ACTION_CHOICES, default=ACTION_DEPLOY)
    environment = models.ForeignKey(Environment, blank=True, null=True)
    puppet_config_file = models.FileField(upload_to='/', max_length=200, blank=True, null=True,
                                     help_text='puppet config file for this deployment')
    puppet_config_content = models.TextField(help_text='puppet config content for this deployment')
    product_deployment = models.ForeignKey(ProductDeployment,
                                           help_text='this deploy&upgrade history is for which product deployment')
    #former_upgrade_id = models.BigIntegerField(blank=True, null=True)
    operator = models.ForeignKey(User, blank=True, null=True)
    create_date = models.DateTimeField(auto_now_add=True, editable=True)

    class Meta:
        verbose_name = 'Product Deploy & Upgrade History'
        verbose_name_plural = verbose_name
        if DEFAULT_ENVIRONMENT == ENVIRONMENT_PRODUCTION or DEFAULT_ENVIRONMENT == ENVIRONMENT_STAGING:
            db_table = '%s_%s_%s' % (ENVIRONMENT_PRODUCTION, module, 'productdeploymenthistory')
        else:
            db_table = '%s_%s_%s' % (DEFAULT_ENVIRONMENT, module, 'productdeploymenthistory')

    def __unicode__(self):
        return "%s#%s_%s" % (self.id, self.service_provider, self.product_version)

    def puppet_config_link(self):
        if self.puppet_config_file:
            from autodeploy.settings import PUPPET_ROOT_PATH
            url = '/static%s' % str(self.puppet_config_file).replace(PUPPET_ROOT_PATH, '').replace('\\', '/')
            return "<a href='%s'>%s</a>" % (url, os.path.basename(str(self.puppet_config_file)))
        else:
            return "No puppet config"
    puppet_config_link.allow_tags = True

    def save(self, *args, **kwargs):
        # Call the "real" save() method.
        super(ProductDeploymentHistory, self).save(*args, **kwargs)


class ComponentDeploymentHistory(models.Model):
    component_package = models.ForeignKey(ComponentPackage)
    service_provider = models.ForeignKey(ServiceProvider, blank=True, null=True)
    action = models.CharField(max_length=10, choices=ACTION_CHOICES, default=ACTION_DEPLOY)
    environment = models.ForeignKey(Environment, blank=True, null=True)
    #product_version = models.ForeignKey(ProductVersion, related_name='component_deployment_product',
    #                                       blank=True, null=True, on_delete=models.DO_NOTHING)
    server = models.ManyToManyField(Server)
    deploykit_config_file = models.FileField(upload_to='/', max_length=200, blank=True, null=True,)
    #deploykit_config_content = models.TextField(help_text='deploy config content for this deployment')
    component_config_file = models.FileField(upload_to='/', max_length=200, blank=True, null=True)
    #component_config_content = models.TextField(help_text='component config content for this deployment')
    product_deployment_history = models.ForeignKey(ProductDeploymentHistory, blank=True, null=True)
    product_deployment = models.ForeignKey(ProductDeployment,
                                           help_text='component deploy&upgrade history is for which product deployment')
    former_upgrade_id = models.BigIntegerField(blank=True, null=True, default=0)
    operator = models.ForeignKey(User, blank=True, null=True)
    create_date = models.DateTimeField('deploy date', auto_now_add=True, editable=True)

    class Meta:
        verbose_name = 'Component Deploy & Upgrade History'
        verbose_name_plural = verbose_name
        if DEFAULT_ENVIRONMENT == ENVIRONMENT_PRODUCTION or DEFAULT_ENVIRONMENT == ENVIRONMENT_STAGING:
            db_table = '%s_%s_%s' % (ENVIRONMENT_PRODUCTION, module, 'componentdeploymenthistory')
        else:
            db_table = '%s_%s_%s' % (DEFAULT_ENVIRONMENT, module, 'componentdeploymenthistory')

    def __unicode__(self):
        return "%s>%s" % (self.service_provider, self.component_package)


# ConfigItem history record for deploy & upgrade history
class ConfigItem(models.Model):
    product_deployment = models.ForeignKey(ProductDeploymentHistory, blank=True, null=True)
    component_deploy = models.ForeignKey(ComponentDeploymentHistory, blank=True, null=True)
    component_package = models.ForeignKey(ComponentPackage)
    config_template_item = models.ForeignKey(ConfigTemplateItem, blank=True, null=True)
    key_name = models.CharField(max_length=100)
    value = models.CharField(max_length=300, blank=True, null=True)
    type = models.CharField(max_length=20, choices=CONFIG_ITEM_CHOICES, default=CONFIG_ITEM_COMPONENT)

    class Meta:
        verbose_name = 'Deploy & Upgrade Config Item History'
        verbose_name_plural = verbose_name
        if DEFAULT_ENVIRONMENT == ENVIRONMENT_PRODUCTION or DEFAULT_ENVIRONMENT == ENVIRONMENT_STAGING:
            db_table = '%s_%s_%s' % (ENVIRONMENT_PRODUCTION, module, 'configitem')
        else:
            db_table = '%s_%s_%s' % (DEFAULT_ENVIRONMENT, module, 'configitem')

    def __unicode__(self):
        return "%s's conf:%s" % (self.component_package, self.key_name)
