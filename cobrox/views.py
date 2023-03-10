from django.shortcuts import render
from django.template import loader
from django.core.mail import send_mail
from django.views.generic import (ListView,DetailView,CreateView,UpdateView,DeleteView)
from django.http import HttpResponseRedirect
from .models import filial,zona,tipo_cliente
from .forms import FilialAddForm,FilialUpdateForm,ZonaAddForm,ZonaUpdateForm,TipoclienteAddForm,TipoclienteUpdateForm
from datetime import timedelta
from django.views.generic.edit import FormMixin,FormView

from django.contrib.auth.mixins import LoginRequiredMixin, AccessMixin
from django.urls import reverse_lazy,reverse
from django.db.models import Sum, Count
from django.db.models.functions import TruncMonth,TruncDate
from datetime import datetime
from django.utils.timezone import make_aware
from django.contrib.messages.views import SuccessMessageMixin
from django.core.files.base import ContentFile
from django.conf import settings
from django.core.files import File
from django.contrib import messages
from django.db import IntegrityError
from django.http import Http404

from django.core.mail import  EmailMultiAlternatives
from django.template.loader import render_to_string
from django.utils.html import strip_tags
from django.core.files.storage import FileSystemStorage
from django.http import HttpResponse

from django.contrib.auth.mixins import PermissionRequiredMixin
from django.db.models.query_utils import Q
from django.db import transaction
from django.template.defaultfilters import date as _date

from django.http import HttpResponseForbidden
from django.core.exceptions import PermissionDenied, ValidationError
from django.core.exceptions import ObjectDoesNotExist
from django.core.files.images import ImageFile
from django.core.validators import validate_email


import locale

from io import BytesIO
from urllib.request import urlopen



import pytz
import json



import os

class LogoutIfNotSuperUserMixin(AccessMixin):
    def dispatch(self, request, *args, **kwargs):
        if not request.user.is_superuser:
            logout(request)
            return self.handle_no_permission()
        return super(LogoutIfNotSuperUserMixin, self).dispatch(request, *args, **kwargs)


class LogoutIfNotStaffMixin(AccessMixin):
    def dispatch(self, request, *args, **kwargs):
        if not request.user.is_staff and not request.user.is_superuser:
            logout(request)
            return self.handle_no_permission()
        return super(LogoutIfNotStaffMixin, self).dispatch(request, *args, **kwargs)


class Viewindex(LoginRequiredMixin, ListView):
    success_url = reverse_lazy('cobrox/index.html')
    template_name = "cobrox/index.html"

    def get_context_data(self, **kwargs):
        context = super(Viewindex, self).get_context_data(**kwargs)
        return context

    def get_queryset(self):
        pass

    def get(self, request, *args, **kwargs):
        print(self.request.user)
        return super().get(request, *args, **kwargs)


class FilialDelete(SuccessMessageMixin, PermissionRequiredMixin, DeleteView):
    model = filial
    success_url = reverse_lazy('cobrox:FilialList')
    form_valid_message = 'La Filial fue eliminada satisfactoriamente!'
    permission_required = ('is_staff')

    def get(self, request, *args, **kwargs):
        try:
            obj = filial.objects.get(id=self.kwargs[self.pk_url_kwarg])
            obj.delete()
            messages.success(request, "La filial ha sido eliminado satisfactoriamente.")
            my_render = reverse_lazy('cobrox:FilialList')
        except IntegrityError as e:
            messages.error(request, "La filial no puede ser eliminado ya que tiene registros asociados")
            my_render = reverse_lazy('cobrox:FilialList')
        return HttpResponseRedirect(my_render)


class FilialUpdate(SuccessMessageMixin, PermissionRequiredMixin, LoginRequiredMixin, UpdateView):
    model = filial
    form_class = FilialUpdateForm
    success_url = reverse_lazy('cobrox:FilialList')
    template_name = 'cobrox/filial_add_upd.html'
    success_message = 'Informacion del Filial Almacenada Correctamente!!!!'
    permission_required = ('is_staff')

    def form_valid(self, form):
        action = self.request.POST.get('action')
        if action == 'SAVE':
            return super().form_valid(form)
        return HttpResponseBadRequest()


class FilialList(PermissionRequiredMixin, ListView):
    model = filial
    template_name = 'cobrox/filial_list.html'
    permission_required = ('is_staff')

    def get_queryset(self):
        return filial.objects.all()


class FilialAdd(SuccessMessageMixin, PermissionRequiredMixin, CreateView):
    form_class = FilialAddForm
    template_name = 'cobrox/filial_add_upd.html'
    success_url = reverse_lazy('cobrox:FilialList')
    success_message = 'Informacion del Filial Almacenada Correctamente!!!!'
    permission_required = ('is_staff')

    def form_valid(self, form):
        action = self.request.POST.get('action')
        form = self.form_class(self.request.POST)
        if action == 'SAVE':
            return super().form_valid(form)
        return HttpResponseBadRequest()
    
    
class ZonaDelete(PermissionRequiredMixin,DeleteView):
    model = zona
    success_url = reverse_lazy('cobrox:ZonaList')
    form_valid_message = 'La Zona fue eliminada satisfactoriamente!'
    permission_required = ('is_staff')

    def get(self, request, *args, **kwargs):
        try:
            obj = zona.objects.get(id=self.kwargs[self.pk_url_kwarg])
            obj.delete()
            messages.success(request, "La zona ha sido eliminado satisfactoriamente.")
            my_render = reverse_lazy('cobrox:ZonaList')
        except IntegrityError as e:
            messages.error(request, "La zona no puede ser eliminado ya que tiene registros asociados")
            my_render = reverse_lazy('cobrox:ZonaList')
        return HttpResponseRedirect(my_render)

    def dispatch(self, request, *args, **kwargs):
        if not request.user.is_authenticated:
            return self.handle_no_permission()
        try:
            obj = zona.objects.get(id=self.kwargs['pk'])
        except ObjectDoesNotExist:
            raise Http404
        #if obj.medico.id != request.user.usumed.medico_id or request.user.usumed.rol == 0:
        #    raise PermissionDenied
        return super().dispatch(request, *args, **kwargs)


class ZonaUpdate(SuccessMessageMixin, PermissionRequiredMixin, UpdateView):
    model = zona
    form_class = ZonaUpdateForm
    success_url = reverse_lazy('cobrox:ZonaList')
    template_name = 'cobrox/zona_add_upd.html'
    success_message = 'Informacion de la Zona Almacenada Correctamente!!!!'
    permission_required = ('is_staff')

    def form_valid(self, form ):
        action = self.request.POST.get('action')
        if action == 'SAVE':
            return super().form_valid(form)
        return HttpResponseBadRequest()

    def dispatch(self, request, *args, **kwargs):
        if not request.user.is_authenticated:
            return self.handle_no_permission()
        try:
            obj = zona.objects.get(id=self.kwargs['pk'])
        except ObjectDoesNotExist:
            raise Http404
        #if obj.medico.id != request.user.usumed.medico_id or request.user.usumed.rol == 0:
        #    raise PermissionDenied
        return super().dispatch(request, *args, **kwargs)


class ZonaList(PermissionRequiredMixin, ListView):
    model = zona
    template_name = 'cobrox/zona_list.html'
    permission_required = ('is_staff')

    def get_queryset(self):
        return  zona.objects.all()
        #return zona.objects.filter(medico_id = self.request.user.usumed.medico_id).order_by("id")

    #def usumed(self):
    #    return usumed.objects.get(medico=self.request.user.usumed.medico, tipo_usuario=1, rol=1)


class ZonaAdd(SuccessMessageMixin, PermissionRequiredMixin, CreateView):
    form_class = ZonaAddForm
    template_name = 'cobrox/zona_add_upd.html'
    success_url = reverse_lazy('cobrox:ZonaList')
    success_message = 'Informacion de la Zona Almacenada Correctamente!!!!'
    permission_required = ('is_staff')

    def form_valid(self, form ):
        action = self.request.POST.get('action')
        form = self.form_class(self.request.POST)
        if action == 'SAVE':
            return super().form_valid(form)
        return HttpResponseBadRequest()

    def dispatch(self, request, *args, **kwargs):
        if not request.user.is_authenticated:
            return self.handle_no_permission()

        #if request.user.usumed.rol == 0:
        #    raise PermissionDenied
        return super().dispatch(request, *args, **kwargs)


class TipoclienteDelete(SuccessMessageMixin, PermissionRequiredMixin, DeleteView):
    model = tipo_cliente
    success_url = reverse_lazy('cobrox:TipoclienteList')
    form_valid_message = 'La Tipocliente fue eliminada satisfactoriamente!'
    permission_required = ('is_staff')

    def get(self, request, *args, **kwargs):
        try:
            obj = tipo_cliente.objects.get(id=self.kwargs[self.pk_url_kwarg])
            obj.delete()
            messages.success(request, "El tipo_cliente ha sido eliminado satisfactoriamente.")
            my_render = reverse_lazy('cobrox:TipoclienteList')
        except IntegrityError as e:
            messages.error(request, "El tipo_cliente no puede ser eliminado ya que tiene registros asociados")
            my_render = reverse_lazy('cobrox:TipoclienteList')
        return HttpResponseRedirect(my_render)


class TipoclienteUpdate(SuccessMessageMixin, PermissionRequiredMixin, LoginRequiredMixin, UpdateView):
    model = tipo_cliente
    form_class = TipoclienteUpdateForm
    success_url = reverse_lazy('cobrox:TipoclienteList')
    template_name = 'cobrox/tipo_cliente_add_upd.html'
    success_message = 'Informacion del Tipocliente Almacenada Correctamente!!!!'
    permission_required = ('is_staff')

    def form_valid(self, form):
        action = self.request.POST.get('action')
        if action == 'SAVE':
            return super().form_valid(form)
        return HttpResponseBadRequest()


class TipoclienteList(PermissionRequiredMixin, ListView):
    model = tipo_cliente
    template_name = 'cobrox/tipo_cliente_list.html'
    permission_required = ('is_staff')

    def get_queryset(self):
        return tipo_cliente.objects.all()


class TipoclienteAdd(SuccessMessageMixin, PermissionRequiredMixin, CreateView):
    form_class = TipoclienteAddForm
    template_name = 'cobrox/tipo_cliente_add_upd.html'
    success_url = reverse_lazy('cobrox:TipoclienteList')
    success_message = 'Informacion del Tipocliente Almacenada Correctamente!!!!'
    permission_required = ('is_staff')

    def form_valid(self, form):
        action = self.request.POST.get('action')
        form = self.form_class(self.request.POST)
        if action == 'SAVE':
            return super().form_valid(form)
        return HttpResponseBadRequest()
