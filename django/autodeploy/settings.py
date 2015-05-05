"""
Django settings for autodeploy project.

For more information on this file, see
https://docs.djangoproject.com/en/1.6/topics/settings/

For the full list of settings and their values, see
https://docs.djangoproject.com/en/1.6/ref/settings/
"""

# Build paths inside the project like this: os.path.join(BASE_DIR, ...)
import os

BASE_DIR = os.path.dirname(os.path.dirname(__file__))


# Quick-start development settings - unsuitable for product
# See https://docs.djangoproject.com/en/1.6/howto/deployment/checklist/

# SECURITY WARNING: keep the secret key used in product secret!
SECRET_KEY = '8*3$ni77+^frk082*k!+3@94!n0w3&x$okm#+j4u8$kul(v^5)'

# SECURITY WARNING: don't run with debug turned on in product!
DEBUG = True

TEMPLATE_DEBUG = True

ALLOWED_HOSTS = []


# Application definition

INSTALLED_APPS = (
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'deployment',
    'product',
    'metadata',
)

MIDDLEWARE_CLASSES = (
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
)

ROOT_URLCONF = 'autodeploy.urls'

WSGI_APPLICATION = 'autodeploy.wsgi.application'


# Database
# https://docs.djangoproject.com/en/1.6/ref/settings/#databases

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': 'database.db',
        'USER': '',
        'PASSWORD': '',
        'HOST': '',
        'PORT': '',
    },
}

# Internationalization
# https://docs.djangoproject.com/en/1.6/topics/i18n/

LANGUAGE_CODE = 'en-us'

TIME_ZONE = 'Asia/Shanghai'

USE_I18N = True

USE_L10N = True

USE_TZ = True


# Static files (CSS, JavaScript, Images)
# https://docs.djangoproject.com/en/1.6/howto/static-files/

STATIC_URL = '/static/'

STATICFILES_DIRS = (
    os.path.join(BASE_DIR, "static"),
    #'/var/www/static/',
)

TEMPLATE_DIRS = (
    os.path.join(BASE_DIR, 'templates'),
)

#============================== Customize constant variable, not modify =========================

# deploy action enum
ACTION_DEPLOY = 'DEPLOY'
ACTION_UPGRADE = 'UPGRADE'
ACTION_CHOICES = (
    (ACTION_DEPLOY, ACTION_DEPLOY),
    (ACTION_UPGRADE, ACTION_UPGRADE),
)

PRODUCT_STATUS_RUNNING = 'Running'
PRODUCT_STATUS_STOPPED = 'Stopped'
PRODUCT_STATUS = (
    (PRODUCT_STATUS_RUNNING, PRODUCT_STATUS_RUNNING),
    (PRODUCT_STATUS_RUNNING, PRODUCT_STATUS_STOPPED),
)

# environment enum
ENVIRONMENT_PRODUCTION = 'production'
ENVIRONMENT_STAGING = 'staging'
ENVIRONMENT_DEVELOPMENT = 'development'
ENVIRONMENT_TESTING = 'testing'

# config item enum
CONFIG_ITEM_TANGO = 'for Tango'
CONFIG_ITEM_COMPONENT = 'for Component'
CONFIG_ITEM_CHOICES = (
    (CONFIG_ITEM_TANGO, CONFIG_ITEM_TANGO),
    (CONFIG_ITEM_COMPONENT, CONFIG_ITEM_COMPONENT),
)

#=============================== configuration for puppet =================================
# todo modify it when publish, puppet conf root, usually '/etc/puppet/' in linux;
PUPPET_ROOT_PATH = '/etc/puppet'
STATICFILES_DIRS = STATICFILES_DIRS + (PUPPET_ROOT_PATH, )

# !!! the second value 'files' must keep consistent with puppet's fileserver.conf
PUPPET_FILES_PATH = os.path.join(PUPPET_ROOT_PATH, 'files')
# puppet manifests path
PUPPET_MANIFEST_PATH = os.path.join(PUPPET_ROOT_PATH, 'manifests')

# the path to store component package, integrate with puppet, usually /etc/puppet/files/component_package
# !!! the second value 'files' must keep consistent with puppet's fileserver.conf
COMPONENT_PACKAGE_UPLOAD_FOLDER = 'standalone_component_package'
COMPONENT_PACKAGE_UPLOAD_PATH = os.path.join(PUPPET_FILES_PATH, COMPONENT_PACKAGE_UPLOAD_FOLDER)

# the path to store product package, integrate with puppet, usually /etc/puppet/files/product_package
PRODUCT_PACKAGE_UPLOAD_FOLDER = 'product_package'
PRODUCT_PACKAGE_UPLOAD_PATH = os.path.join(PUPPET_FILES_PATH, PRODUCT_PACKAGE_UPLOAD_FOLDER)

# the path to store component template file, integrate with puppet
#COMPONENT_CONFIG_TEMPLATE_UPLOAD_PATH = os.path.join(PUPPET_FILES_PATH, 'component_config_template')

# the path to store component deploy & upgrade kit, integrate with puppet,usually /etc/puppet/files/deploy_kit
DEPLOY_KIT_FOLDER = 'deploy_kit'
DEPLOY_KIT_PATH = os.path.join(PUPPET_FILES_PATH, DEPLOY_KIT_FOLDER)

# the path to store deployed component config(instance according template ) , /etc/puppet/files/component_config
COMPONENT_CONFIG_FOLDER = 'component_config'
COMPONENT_CONFIG_PATH = os.path.join(PUPPET_FILES_PATH, COMPONENT_CONFIG_FOLDER)

# the path to store deployed product config(instance according template ) , /etc/puppet/files/product_config
PRODUCT_CONFIG_FOLDER = 'product_config'
PRODUCT_CONFIG_PATH = os.path.join(PUPPET_FILES_PATH, PRODUCT_CONFIG_FOLDER)


#================================== modify setting below when deploy django =======================
# todo modify when install, root url of this django web site,include port
DJANGO_ROOT_URL = 'http://cnemoptestpuppet:8000'

# django deployed for which environment
DEFAULT_ENVIRONMENT = ENVIRONMENT_DEVELOPMENT

# configure ENVIRONMENT_CHOICES automatically, need no modify
ENVIRONMENT_CHOICES = ()
if DEFAULT_ENVIRONMENT == ENVIRONMENT_PRODUCTION or DEFAULT_ENVIRONMENT == ENVIRONMENT_STAGING:
    ENVIRONMENT_CHOICES = ((ENVIRONMENT_PRODUCTION, ENVIRONMENT_PRODUCTION), (ENVIRONMENT_STAGING, ENVIRONMENT_STAGING),)
elif DEFAULT_ENVIRONMENT == ENVIRONMENT_DEVELOPMENT:
    ENVIRONMENT_CHOICES = ((ENVIRONMENT_DEVELOPMENT, ENVIRONMENT_DEVELOPMENT),)
elif DEFAULT_ENVIRONMENT == ENVIRONMENT_TESTING:
    ENVIRONMENT_CHOICES = ((ENVIRONMENT_TESTING, ENVIRONMENT_TESTING),)
