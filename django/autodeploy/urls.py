from django.conf.urls import patterns, include, url

from django.contrib import admin
admin.autodiscover()

urlpatterns = patterns('',
    # Examples:
    # url(r'^$', 'autodeploy.views.home', name='home'),
    # url(r'^blog/', include('blog.urls')),

    url(r'^admin/test/', 'deployment.views.test', name='deploy'),
    url(r'^admin/deploy/$', 'deployment.views.deploy_index', name='deploy'),

    url(r'^admin/', include(admin.site.urls)),
)
