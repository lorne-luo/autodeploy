
# Create your views here.
from models import *
from django.shortcuts import get_object_or_404, render_to_response, render, redirect
from django.http import HttpResponse
from django.contrib.auth.decorators import login_required
from django.contrib.auth import logout as auth_logout, REDIRECT_FIELD_NAME
from django.contrib.admin.forms import AdminAuthenticationForm
from django.utils.translation import ugettext as _
from django.template.response import SimpleTemplateResponse, TemplateResponse
from django.contrib.admin.views.decorators import staff_member_required
from django.contrib import admin
from django.forms.models import modelformset_factory
from product.models import *
from product.admin import ComponentAdmin
from django.forms.formsets import formset_factory
from django.forms import ModelForm


class ComponentForm(ModelForm):
    #name = forms.CharField(max_length=100)
    class Meta:
        model = Component


def test(request):

    ComponentFormSet = modelformset_factory(Component)
    #AuthorFormSet = modelformset_factory(Author, formset=BaseAuthorFormSet)
    #AuthorFormSet(queryset=Author.objects.none())
    #AuthorFormSet = modelformset_factory(Author, fields=('name', 'title'))

    DeployNewSPFormSet = modelformset_factory(ProductDeploymentHistory)

    if request.method == 'POST':
        formset = DeployNewSPFormSet(request.POST, request.FILES)
        if formset.is_valid():
            formset.save()
            # do something.
    else:
        formset = DeployNewSPFormSet()

    inline_admin_formsets = []
    inline_admin_formsets.append(ComponentFormSet())

    return render_to_response("admin/deploymentlog_change_form2.html", {
        "formset": formset,
    })


def deploy_index(request):
    if request.user.is_authenticated():
        # unauthenticated
        #return HttpResponse(request.user.username)
        return show_deploy_form(request)
    else:
        # anonymous
        from django.contrib.auth.views import login
        context = {
            'title': _('Log in'),
            'app_path': request.get_full_path(),
            REDIRECT_FIELD_NAME: request.get_full_path(),
        }
        context.update({})

        defaults = {
            'extra_context': context,
            'current_app': None,
            'authentication_form': AdminAuthenticationForm,
            'template_name': 'admin/login.html',
        }
        return login(request, **defaults)
        #return render_to_response('login.html', {'app_path':'/login'})


def show_deploy_form(request, form_url='', extra_context=None):
    ComponentFormSet = modelformset_factory(Component)
    formset = ComponentFormSet()

    for form in formset:
        print(form.as_table())
    return render_to_response('deploy_form.html', {'formset': formset,
                                                   'item_template': 'admin/change_list.html'})


