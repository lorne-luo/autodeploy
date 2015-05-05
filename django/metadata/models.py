from django.db import models
from autodeploy.settings import ENVIRONMENT_CHOICES, DEFAULT_ENVIRONMENT, ENVIRONMENT_PRODUCTION, \
    ENVIRONMENT_STAGING, ENVIRONMENT_DEVELOPMENT

module = __name__[:__name__.find('.')]


class ServiceProvider(models.Model):
    name = models.CharField(max_length=100, help_text='ServiceProvider\'s name, 100 characters limit')
    address = models.CharField(max_length=100, blank=True, null=True)
    telephone = models.CharField(max_length=20, blank=True, null=True)
    email = models.EmailField(max_length=40, blank=True, null=True)
    last_modified_date = models.DateTimeField(auto_now=True)
    create_date = models.DateTimeField(auto_now_add=True, editable=True)

    class Meta:
        verbose_name = "Service Provider"
        verbose_name_plural = "Service Provider"
        if DEFAULT_ENVIRONMENT == ENVIRONMENT_PRODUCTION or DEFAULT_ENVIRONMENT == ENVIRONMENT_STAGING:
            db_table = '%s_%s_%s' % (ENVIRONMENT_PRODUCTION, module, 'serviceprovider')
        else:
            db_table = '%s_%s_%s' % (DEFAULT_ENVIRONMENT, module, 'serviceprovider')

    def __unicode__(self):
        return "[SP%s]%s" % (self.id, self.name.replace(' ', '-'))


class Environment(models.Model):
    name = models.CharField(primary_key=True, max_length=20, choices=ENVIRONMENT_CHOICES, default=DEFAULT_ENVIRONMENT)

    class Meta:
        if DEFAULT_ENVIRONMENT == ENVIRONMENT_PRODUCTION or DEFAULT_ENVIRONMENT == ENVIRONMENT_STAGING:
            db_table = '%s_%s_%s' % (ENVIRONMENT_PRODUCTION, module, 'environment')
        else:
            db_table = '%s_%s_%s' % (DEFAULT_ENVIRONMENT, module, 'environment')

    def __unicode__(self):
        return self.name


class Server(models.Model):
    name = models.CharField(unique=True, max_length=50, help_text='exact hostname of this server')
    internal_ip = models.GenericIPAddressField(blank=True, null=True)
    external_ip = models.GenericIPAddressField(blank=True, null=True)
    #environment = models.CharField(max_length=1, choices=ENVIRONMENT_CHOICES, default=DEFAULT_ENVIRONMENT)
    environment = models.ForeignKey(Environment, blank=True, null=True,
                                    help_text='specify this server belong to which environment')
    description = models.CharField(max_length=200, blank=True, null=True)

    class Meta:
        if DEFAULT_ENVIRONMENT == ENVIRONMENT_PRODUCTION or DEFAULT_ENVIRONMENT == ENVIRONMENT_STAGING:
            db_table = '%s_%s_%s' % (ENVIRONMENT_PRODUCTION, module, 'server')
        else:
            db_table = '%s_%s_%s' % (DEFAULT_ENVIRONMENT, module, 'server')

    def __unicode__(self):
        return "%s" % self.name


