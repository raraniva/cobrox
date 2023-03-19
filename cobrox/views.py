from django.shortcuts import render,redirect
from django.template import loader
from django.core.mail import send_mail
from django.views.generic import (ListView,DetailView,CreateView,UpdateView,DeleteView)
from django.http import HttpResponseRedirect
from .models import filial,zona,tipo_cliente,cliente,credito,pago,creditofinanc,cliente_archivo,credito_archivo
from .forms import FilialAddForm,\
    FilialUpdateForm,ZonaAddForm,ZonaUpdateForm,TipoclienteAddForm,\
    TipoclienteUpdateForm,ClienteAddForm,ClienteUpdateForm,ClienteSearchForm,CreditoAddForm,PagoAddForm,CreditoSearchForm,\
    Archivos_clienteForm,Archivos_creditoForm,ConsultaDesembolsoSearchForm,ConsultaPagoSearchForm
from datetime import timedelta
from django.views.generic.edit import FormMixin,FormView
from user.models import user_rol_filial
from django.contrib.auth.mixins import LoginRequiredMixin, AccessMixin
from django.urls import reverse_lazy,reverse
from django.db.models import Sum, Count
from django.db.models.functions import TruncMonth,TruncDate
from datetime import datetime
from datetime import date
from django.utils.timezone import make_aware
from django.contrib.messages.views import SuccessMessageMixin
from django.core.files.base import ContentFile
from django.conf import settings
from django.core.files import File
from django.contrib import messages
from django.db import IntegrityError
from django.http import Http404
from decimal import Decimal
from django.contrib.auth.mixins import UserPassesTestMixin
from django.template.loader import get_template
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
import operator
from django.contrib.auth.decorators import user_passes_test

import locale
import csv

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

        return super().get(request, *args, **kwargs)


class FilialDelete(SuccessMessageMixin, UserPassesTestMixin, DeleteView):
    model = filial
    success_url = reverse_lazy('cobrox:FilialList')
    form_valid_message = 'La Filial fue eliminada satisfactoriamente!'

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

    def test_func(self):
        return self.request.user.is_staff


class FilialUpdate(SuccessMessageMixin, UserPassesTestMixin, LoginRequiredMixin, UpdateView):
    model = filial
    form_class = FilialUpdateForm
    success_url = reverse_lazy('cobrox:FilialList')
    template_name = 'cobrox/filial_add_upd.html'
    success_message = 'Informacion del Filial Almacenada Correctamente!!!!'

    def form_valid(self, form):
        action = self.request.POST.get('action')
        if action == 'SAVE':
            return super().form_valid(form)
        return HttpResponseBadRequest()

    def test_func(self):
        return self.request.user.is_staff


class FilialList(UserPassesTestMixin, ListView):
    model = filial
    template_name = 'cobrox/filial_list.html'
    permission_required = ('user.is_staff')

    def get_queryset(self):
        return filial.objects.all()

    def test_func(self):
        return self.request.user.is_staff


class FilialAdd(SuccessMessageMixin, UserPassesTestMixin, CreateView):
    form_class = FilialAddForm
    template_name = 'cobrox/filial_add_upd.html'
    success_url = reverse_lazy('cobrox:FilialList')
    success_message = 'Informacion del Filial Almacenada Correctamente!!!!'

    def form_valid(self, form):
        action = self.request.POST.get('action')
        form = self.form_class(self.request.POST)
        if action == 'SAVE':
            return super().form_valid(form)
        return HttpResponseBadRequest()
    
    def test_func(self):
        return self.request.user.is_staff


class ZonaDelete(UserPassesTestMixin,DeleteView):
    model = zona
    success_url = reverse_lazy('cobrox:ZonaList')
    form_valid_message = 'La Zona fue eliminada satisfactoriamente!'

    def test_func(self):
        return self.request.user.is_staff

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


class ZonaUpdate(SuccessMessageMixin, UserPassesTestMixin, UpdateView):
    model = zona
    form_class = ZonaUpdateForm
    success_url = reverse_lazy('cobrox:ZonaList')
    template_name = 'cobrox/zona_add_upd.html'
    success_message = 'Informacion de la Zona Almacenada Correctamente!!!!'

    def test_func(self):
        return self.request.user.is_staff

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


class ZonaList(UserPassesTestMixin, ListView):
    model = zona
    template_name = 'cobrox/zona_list.html'
    permission_required = ('is_staff')

    def get_queryset(self):
        return  zona.objects.all()
        #return zona.objects.filter(medico_id = self.request.user.usumed.medico_id).order_by("id")

    #def usumed(self):
    #    return usumed.objects.get(medico=self.request.user.usumed.medico, tipo_usuario=1, rol=1)

    def test_func(self):
        return self.request.user.is_staff


class ZonaAdd(SuccessMessageMixin, UserPassesTestMixin, CreateView):
    form_class = ZonaAddForm
    template_name = 'cobrox/zona_add_upd.html'
    success_url = reverse_lazy('cobrox:ZonaList')
    success_message = 'Informacion de la Zona Almacenada Correctamente!!!!'


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

    def test_func(self):
        return self.request.user.is_staff


class TipoclienteDelete(SuccessMessageMixin, UserPassesTestMixin, DeleteView):
    model = tipo_cliente
    success_url = reverse_lazy('cobrox:TipoclienteList')
    form_valid_message = 'La Tipocliente fue eliminada satisfactoriamente!'


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

    def test_func(self):
        return self.request.user.is_staff


class TipoclienteUpdate(SuccessMessageMixin, UserPassesTestMixin, LoginRequiredMixin, UpdateView):
    model = tipo_cliente
    form_class = TipoclienteUpdateForm
    success_url = reverse_lazy('cobrox:TipoclienteList')
    template_name = 'cobrox/tipo_cliente_add_upd.html'
    success_message = 'Informacion del Tipocliente Almacenada Correctamente!!!!'


    def form_valid(self, form):
        action = self.request.POST.get('action')
        if action == 'SAVE':
            return super().form_valid(form)
        return HttpResponseBadRequest()

    def test_func(self):
        return self.request.user.is_staff


class TipoclienteList(UserPassesTestMixin, ListView):
    model = tipo_cliente
    template_name = 'cobrox/tipo_cliente_list.html'


    def get_queryset(self):
        return tipo_cliente.objects.all()

    def test_func(self):
        return self.request.user.is_staff


class TipoclienteAdd(SuccessMessageMixin, UserPassesTestMixin, CreateView):
    form_class = TipoclienteAddForm
    template_name = 'cobrox/tipo_cliente_add_upd.html'
    success_url = reverse_lazy('cobrox:TipoclienteList')
    success_message = 'Informacion del Tipocliente Almacenada Correctamente!!!!'


    def form_valid(self, form):
        action = self.request.POST.get('action')
        form = self.form_class(self.request.POST)
        if action == 'SAVE':
            return super().form_valid(form)
        return HttpResponseBadRequest()

    def test_func(self):
        return self.request.user.is_staff


class ClienteDelete(LoginRequiredMixin,DeleteView):
    model = cliente
    success_url = reverse_lazy('cobrox:ClienteList')
    form_valid_message = 'El cliente fue eliminado satisfactoriamente!'

    def get(self, request, *args, **kwargs):
        try:
            obj = cliente.objects.get(id=self.kwargs[self.pk_url_kwarg])
            obj.delete()
            messages.success(request, "El cliente ha sido eliminado satisfactoriamente.")
            my_render = reverse_lazy('cobrox:ClienteList')
        except IntegrityError as e:
            messages.error(request, "La cliente no puede ser eliminado ya que tiene registros asociados")
            my_render = reverse_lazy('cobrox:ClienteList')
        return HttpResponseRedirect(my_render)

    def dispatch(self, request, *args, **kwargs):
        if not request.user.is_authenticated:
            return self.handle_no_permission()
        try:
            obj = cliente.objects.get(id=self.kwargs['pk'])
        except ObjectDoesNotExist:
            raise Http404
        user_filial = user_rol_filial.objects.get(usuario=self.request.user)
        if user_filial.filial != obj.zona.filial and not self.request.user.is_staff:
            raise PermissionDenied
        if user_filial.rol.codigo=='OPE':
            raise PermissionDenied
        return super().dispatch(request, *args, **kwargs)


class ClienteUpdate(SuccessMessageMixin, LoginRequiredMixin, UpdateView):
    model = cliente
    form_class = ClienteUpdateForm
    success_url = reverse_lazy('cobrox:ClienteList')
    template_name = 'cobrox/cliente_add_upd.html'
    success_message = 'Informacion de Cliente Almacenada Correctamente!!!!'

    def form_valid(self, form ):
        action = self.request.POST.get('action')
        if action == 'SAVE':
            return super().form_valid(form)
        return HttpResponseBadRequest()

    def dispatch(self, request, *args, **kwargs):
        if not request.user.is_authenticated:
            return self.handle_no_permission()
        try:
            obj = cliente.objects.get(id=self.kwargs['pk'])
        except ObjectDoesNotExist:
            raise Http404
        user_filial = user_rol_filial.objects.get(usuario=self.request.user)
        if user_filial.filial != obj.zona.filial and not self.request.user.is_staff:
            raise PermissionDenied
        if user_filial.rol.codigo=='OPE':
            raise PermissionDenied
        return super().dispatch(request, *args, **kwargs)

    def get_form_kwargs(self):
        kwargs = super(ClienteUpdate, self).get_form_kwargs()
        kwargs['request'] = self.request
        kwargs['cliente'] = cliente.objects.get(id=self.kwargs['pk'])
        return kwargs


class ClienteList(LoginRequiredMixin, FormMixin,ListView):
    paginate_by = getattr(settings, 'NUM_RECS_BY_PAG', None)
    form_class = ClienteSearchForm
    template_name = 'cobrox/cliente_list.html'
    ajax_template_name = 'cobrox/cliente_list_results.html'

    def get_initial(self):
        return {
            'apellidos': '',
        }

    def user_rol_filial(self):
        return user_rol_filial.objects.get(usuario=self.request.user)

    def get_queryset(self):
        if self.request.user.is_staff:
            qry = cliente.objects.all().order_by("nombre","id")
        else:
            obj = user_rol_filial.objects.get(usuario=self.request.user)
            qry = cliente.objects.filter(zona__filial=obj.filial).order_by("nombre", "id")
        return qry

    def get_template_names(self):
        if self.request.is_ajax():
            return [self.ajax_template_name]
        return [self.template_name]

    def get_form_kwargs(self):
        return {
            'initial': self.get_initial(),
            'prefix': self.get_prefix(),
            'data': self.request.GET or None
        }

    def get(self, request, *args, **kwargs):
        self.object_list = self.get_queryset()
        form = self.get_form(self.get_form_class())
        if form.is_valid():
            self.object_list = form.filter_queryset(request, self.object_list)
        context = self.get_context_data(form=form, object_list=self.object_list)
        return self.render_to_response(context)

    def paginate_queryset(self, queryset, page_size):
        try:
            return super(ClienteList, self).paginate_queryset(queryset, page_size)
        except Http404:
            self.kwargs['page'] = 'last'
            return super(ClienteList, self).paginate_queryset(queryset, page_size)


class ClienteAdd(SuccessMessageMixin, LoginRequiredMixin, CreateView):
    form_class = ClienteAddForm
    template_name = 'cobrox/cliente_add_upd.html'
    success_url = reverse_lazy('cobrox:ClienteList')
    success_message = 'Informacion de Cliente Almacenada Correctamente!!!!'

    def get_success_url(self):
        return reverse('cobrox:Archivos_clienteAdd',
                       kwargs={'pk':self.object.id}
                       )

    def form_valid(self, form ):
        action = self.request.POST.get('action')
        form = self.form_class(self.request.POST)
        if action == 'SAVE':
            return super().form_valid(form)
        return HttpResponseBadRequest()

    def dispatch(self, request, *args, **kwargs):
        if not request.user.is_authenticated:
            return self.handle_no_permission()
        user_filial = user_rol_filial.objects.get(usuario=self.request.user)
        if user_filial.rol.codigo=='OPE':
            raise PermissionDenied
        return super().dispatch(request, *args, **kwargs)

    def get_form_kwargs(self):
        kwargs = super(ClienteAdd, self).get_form_kwargs()
        kwargs['request'] = self.request
        return kwargs


class Credito_clientelist(LoginRequiredMixin, ListView):
    model = credito
    template_name = 'cobrox/credito_cliente_list.html'
    context_object_name = 'credito'

    def get_context_data(self, **kwargs):
        context = super(Credito_clientelist, self).get_context_data(**kwargs)
        context['cliente_archivos'] = cliente_archivo.objects.filter(cliente__id=self.kwargs['pk'])
        return context;

    def get_queryset(self):
        return credito.objects.filter(cliente__id = self.kwargs['pk']).filter(nm_estado = 1).order_by('id').reverse()

    def cliente(self):
        return cliente.objects.get(pk = self.kwargs['pk'])

    def dispatch(self, request, *args, **kwargs):
        if not request.user.is_authenticated:
            return self.handle_no_permission()
        try:
            obj = cliente.objects.get(id=self.kwargs['pk'])
        except ObjectDoesNotExist:
            raise Http404
        user_filial = user_rol_filial.objects.get(usuario=self.request.user)
        if user_filial.filial != obj.zona.filial and not self.request.user.is_staff:
            raise PermissionDenied
        if user_filial.rol.codigo == 'OPE':
            raise PermissionDenied
        return super().dispatch(request, *args, **kwargs)


class CreditoAdd(SuccessMessageMixin, LoginRequiredMixin, CreateView):
    form_class = CreditoAddForm
    template_name = 'cobrox/credito_add_upd.html'
    success_message = 'Información de Crédito Almacenado Correctamente!!!!'

    def get_context_data(self, **kwargs):
        context = super(CreditoAdd, self).get_context_data(**kwargs)
        context['tip'] = 1
        context['izq'] = 0
        context['medio'] = 8

        return context;

    def get_success_url(self):
        return reverse('cobrox:SuccessCreditoPage',
                       kwargs={'pk':self.object.id}
                       )

    def form_valid(self, form ):
        action = self.request.POST.get('action')
        form = self.form_class(self.request.POST)

        if action == 'SAVE':
            with transaction.atomic():
                cred = form.save(commit=False)

                qtydiascuota, capitalcuota, interescuota, totalcuota, interestotal, otorinterestotal = calculo(
                    form.cleaned_data['montootorgado'], form.cleaned_data['fechaini'].strftime('%Y-%m-%d'), form.cleaned_data['fechaven'].strftime('%Y-%m-%d'), form.cleaned_data['interespct'])
                cred.qtydiascuota = qtydiascuota
                cred.capitalcuota = capitalcuota
                cred.interescuota = interescuota
                cred.totalcuota = totalcuota
                cred.interestotal = interestotal
                cred.montoyinterestotal = otorinterestotal
                cred.cuotaspagadas = 0
                cred.cuotaspendientes =qtydiascuota
                cred.saldopendiente = otorinterestotal
                cred.save()
            return super().form_valid(form)
        return HttpResponseBadRequest()

    def cliente(self):
        return cliente.objects.get(pk=self.kwargs['pk'])

    def dispatch(self, request, *args, **kwargs):
        if not request.user.is_authenticated:
            return self.handle_no_permission()
        user_filial = user_rol_filial.objects.get(usuario=self.request.user)
        if user_filial.rol.codigo=='OPE':
            raise PermissionDenied
        return super().dispatch(request, *args, **kwargs)

    def get_initial(self):
        return {
            'cliente':cliente.objects.get(pk=self.kwargs['pk']) ,
            'tipocredito':0,
            'estadocredito':0,
            'qtydiascuota':0,
            'capitalcuota':0,
            'interescuota':0,
            'totalcuota':0,
            'interestotal':0,
            'montoyinterestotal':0,
            'cuotaspagadas':0,
            'cuotaspendientes':0,
            'saldopendiente':0,
        }


def calculo(monto, fechaini, fechavenc, interespct):

    qtydiascuota = (datetime.strptime(fechavenc, "%Y-%m-%d") - datetime.strptime(fechaini, "%Y-%m-%d")).days
    capitalcuota = round(Decimal(monto)/qtydiascuota,2)
    interescuota = round((Decimal(monto)* (Decimal(interespct)/100))/qtydiascuota,2)
    totalcuota = round(capitalcuota+interescuota,2)
    interestotal = round(interescuota*qtydiascuota,2)
    otorinterestotal = round(Decimal(monto) + interestotal,2)
    return qtydiascuota, capitalcuota,  interescuota, totalcuota,interestotal,otorinterestotal


def calculopago(monto, capitalcuota, interescuota, cuota):
    cuotas_pag = round(Decimal(monto)/cuota,2)
    cuotak = round(cuotas_pag*capitalcuota,2)
    cuotai = round(cuotas_pag*interescuota,2)

    return cuotas_pag, cuotak,  cuotai


def actualizacredito(credito,cuotaspag,monto):
    credito.cuotaspagadas = round(credito.cuotaspagadas + cuotaspag,2);
    credito.cuotaspendientes = round(credito.cuotaspendientes - cuotaspag,2);
    credito.saldopendiente = round(credito.saldopendiente - monto,2);
    if credito.saldopendiente < 0.01 :
        credito.estadocredito=2;
    credito.save()




def vigenciaestadocredito(saldopendiente, fechavenc,estadocredito):
    hoy = date.today()
    if hoy > fechavenc and saldopendiente>0 and estadocredito==0:
        return 1
    else:
        return estadocredito


def load_calculo_pago(request):
    montootorgado = request.GET.get('montootorgado')
    fechaini = request.GET.get('fechaini')
    fechaven = request.GET.get('fechaven')
    interespct = request.GET.get('interespct')
    error = 0
    if montootorgado == '' or montootorgado is None:
        error = 1
        mensaje ="Debe registrar el monto a otorgar"
    elif Decimal(montootorgado) <= 0:
        error = 1
        mensaje = "El monto a otorgar debe ser un valor mayor que 0"
    elif interespct == '' or interespct is None:
        error = 1
        mensaje ="Debe ingresar el porcentaje de interés, Ej: 10 , 15 , 20.."
    elif Decimal(interespct) <= 0:
        error = 1
        mensaje = "El porcentaje de interés debe ser un valor mayor que 0, Ej: 10, 15 , 20.."
    elif fechaini == '' or fechaini is None:
        error = 1
        mensaje = "Debe ingresar fecha de inicio"
    elif fechaven == '' or fechaven is None:
        error = 1
        mensaje = "Debe ingresar fecha de vencimiento"
    elif fechaini >= fechaven:
        error = 1
        mensaje ="La Fecha de Vencimiento debe ser mayor que la Fecha de Inicio "

    else:
        qtydiascuota, capitalcuota,  interescuota, totalcuota,interestotal,otorinterestotal = calculo(montootorgado, fechaini, fechaven, interespct)
        return render(request, 'cobrox/credito_calculo_cuota.html', {   'error':error,
                                                                        'montootorgado':montootorgado,
                                                                        'fechaini':fechaini,
                                                                        'fechaven':fechaven,
                                                                        'interespct': interespct,
                                                                        'qtydiascuota': qtydiascuota,
                                                                        'capitalcuota': capitalcuota,
                                                                        'interescuota': interescuota,
                                                                        'totalcuota': totalcuota,
                                                                        'interestotal': interestotal,
                                                                        'otorinterestotal': otorinterestotal
                                                                        })
    return render(request, 'cobrox/credito_calculo_cuota.html', {'error':error,
                                                                 'mensaje':mensaje
                                                                 })


class CreditoDelete(SuccessMessageMixin, LoginRequiredMixin, DeleteView):
    model = credito
    success_url = reverse_lazy('cobrox:FilialList')

    def get(self, request, *args, **kwargs):
        try:
            obj = credito.objects.get(id=self.kwargs['pk'])
            clien = obj.cliente
            obj.delete()
            messages.success(request, "El crédito ha sido eliminado satisfactoriamente.")
            my_render = reverse('cobrox:Credito_clientelist',
                           kwargs={'pk': clien.id}
                           )
        except IntegrityError as e:
            messages.error(request, "El crédito no puede ser eliminado ya que tiene registros asociados")
            my_render = reverse('cobrox:Credito_clientelist',
                                kwargs={'pk': clien.id}
                                )
        return HttpResponseRedirect(my_render)

    def dispatch(self, request, *args, **kwargs):
        if not request.user.is_authenticated:
            return self.handle_no_permission()
        try:
            obj = credito.objects.get(id=self.kwargs['pk'])
        except ObjectDoesNotExist:
            raise Http404
        if obj.estadoregistro == 1:
            raise PermissionDenied
        user_filial = user_rol_filial.objects.get(usuario=self.request.user)
        if user_filial.filial != obj.cliente.zona.filial and not self.request.user.is_staff:
            raise PermissionDenied
        if user_filial.rol.codigo == 'OPE':
            raise PermissionDenied
        return super().dispatch(request, *args, **kwargs)


class PagoAdd(SuccessMessageMixin, LoginRequiredMixin, CreateView):
    form_class = PagoAddForm
    template_name = 'cobrox/pago_add_upd.html'
    success_message = 'Información del Pago Almacenado Correctamente!!!!'

    def get_success_url(self):
        obj=credito.objects.get(pk=self.kwargs['pk'])
        return reverse('cobrox:EstadoCuenta',
                       kwargs={'pk':obj.id}
                       )

    def form_valid(self, form ):
        action = self.request.POST.get('action')
        form = self.form_class(self.request.POST)
        if action == 'SAVE':
            pag = form.save(commit=False)
            with transaction.atomic():

                obj = credito.objects.get(id=self.kwargs['pk'])
                cuotas_pag, cuotak, cuotai = calculopago(form.cleaned_data['monto'],
                                                         obj.capitalcuota, obj.interescuota, obj.totalcuota)
                actualizacredito(obj, cuotas_pag, form.cleaned_data['monto'])
                pag.capital= cuotak
                pag.interes= cuotai
                pag.cuota= cuotas_pag
                pag.save()
                return super().form_valid(form)
        return HttpResponseBadRequest()

    def cliente(self):
        return credito.objects.get(pk=self.kwargs['pk']).cliente

    def credito(self):
        return credito.objects.get(pk=self.kwargs['pk'])

    def dispatch(self, request, *args, **kwargs):
        if not request.user.is_authenticated:
            return self.handle_no_permission()
        user_filial = user_rol_filial.objects.get(usuario=self.request.user)
        if user_filial.rol.codigo=='OPE':
            raise PermissionDenied
        try:
            obj = credito.objects.get(id=self.kwargs['pk'])
        except ObjectDoesNotExist:
            raise Http404

        if obj.nm_estado != 1 or obj.estadocredito != 0:
            raise PermissionDenied
        if user_filial.filial != obj.cliente.zona.filial and not self.request.user.is_staff:
            raise PermissionDenied
        return super().dispatch(request, *args, **kwargs)

    def get_initial(self):
        return {
            'credito': credito.objects.get(pk=self.kwargs['pk']),
            'capital': 0,
            'interes': 0,
            'cuota': 0,
            'tipoingreso':0
        }


def load_calculo_distribucion_pago(request):
    monto = request.GET.get('monto')
    creditoid = request.GET.get('credito')
    fecha = request.GET.get('fecha')
    recibo = request.GET.get('recibo')
    tipoingreso = request.GET.get('tipoingreso')


    error = 0
    obj = credito.objects.get(id=creditoid)
    if monto == '' or monto is None:
        error = 1
        mensaje ="Debe registrar el monto a pagar"
    elif Decimal(monto) <= 0:
        error = 1
        mensaje = "El monto a pagar debe ser un valor mayor que 0"
    elif tipoingreso == '' or tipoingreso is None:
        error = 1
        mensaje ="Debe seleccion el Tipo de ingreso "
    elif recibo == '' or recibo is None:
        error = 1
        mensaje ="Debe registrar el recibo "
    elif fecha == '' or fecha is None:
        error = 1
        mensaje ="Debe registrar la fecha de pago "
    elif datetime.strptime(fecha, "%Y-%m-%d").date() < obj.fechaini:
        error = 1
        mensaje ="La Fecha de Pago debe ser mayor que la Fecha de Inicio "
    else:

        cuotas_pag, cuotak,  cuotai = calculopago(monto, obj.capitalcuota, obj.interescuota, obj.totalcuota)
        return render(request, 'cobrox/pago_calculo.html', {'error':error,
                                    'cuotas_pag':cuotas_pag,
                                    'cuotak':cuotak,
                                    'cuotai':cuotai,
                                    })
    return render(request, 'cobrox/pago_calculo.html', {'error':error,
                                                                 'mensaje':mensaje
                                                               })


class PagoDelete(SuccessMessageMixin, LoginRequiredMixin, DeleteView):
    model = pago

    def get(self, request, *args, **kwargs):
        try:
            with transaction.atomic():
                obj = pago.objects.get(id=self.kwargs['pk'])
                actualizacredito(obj.credito, obj.cuota*-1, obj.monto*-1)
                obj.delete()
                messages.success(request, "El pago ha sido eliminado satisfactoriamente.")
                my_render = reverse('cobrox:Credito_clientelist',
                               kwargs={'pk': obj.credito.cliente.id}
                               )
        except IntegrityError as e:
            messages.error(request, "El pago no puede ser eliminado ya que tiene registros asociados")
            my_render = reverse('cobrox:Credito_clientelist',
                                kwargs={'pk': obj.credito.cliente.id}
                                )
        return HttpResponseRedirect(my_render)

    def dispatch(self, request, *args, **kwargs):
        if not request.user.is_authenticated:
            return self.handle_no_permission()
        try:
            obj = pago.objects.get(id=self.kwargs['pk'])

        except ObjectDoesNotExist:
            raise Http404
        if obj.estadoregistro == 1:
            raise PermissionDenied
        user_filial = user_rol_filial.objects.get(usuario=self.request.user)
        if user_filial.filial != obj.credito.cliente.zona.filial and not self.request.user.is_staff:
            raise PermissionDenied
        if user_filial.rol.codigo == 'OPE':
            raise PermissionDenied
        return super().dispatch(request, *args, **kwargs)


class TransaccionesOpen(LoginRequiredMixin, ListView):
    template_name = "cobrox/registros_ingresados.html"

    def get_context_data(self, **kwargs):
        context = super(TransaccionesOpen, self).get_context_data(**kwargs)

        user_filial = user_rol_filial.objects.get(usuario=self.request.user)
        context['pagos'] = pago.objects.filter(estadoregistro=0).filter(credito__cliente__zona__filial=user_filial.filial).order_by("id")
        context['pagos_sum'] = pago.objects.filter(estadoregistro=0).filter(credito__cliente__zona__filial=user_filial.filial).values('tipoingreso').annotate(sum_monto=Sum('monto')).order_by('tipoingreso')
        context['pagos_count'] = pago.objects.filter(estadoregistro=0).filter(credito__cliente__zona__filial=user_filial.filial).values('tipoingreso').annotate(count_monto=Count('monto')).order_by('tipoingreso')
        context['creditos'] = credito.objects.filter(estadoregistro=0).filter(cliente__zona__filial=user_filial.filial).order_by("id")
        context['creditos_sum'] = credito.objects.filter(estadoregistro=0).filter(cliente__zona__filial=user_filial.filial).values('tipocredito').annotate(sum_monto=Sum('montootorgado')).order_by('tipocredito')
        context['creditos_count'] = credito.objects.filter(estadoregistro=0).filter(cliente__zona__filial=user_filial.filial).values('tipocredito').annotate(
            count_monto=Count('montootorgado')).order_by('tipocredito')

        return context

    def get_queryset(self):
        pass


class CerrarRegistros(LoginRequiredMixin,DetailView):

    def get(self, request, *args, **kwargs):
        user_filial = user_rol_filial.objects.get(usuario=self.request.user)

        pagosc = pago.objects.filter(estadoregistro=0).filter(credito__cliente__zona__filial=user_filial.filial).count()
        creditosc =credito.objects.filter(estadoregistro=0).filter(cliente__zona__filial=user_filial.filial).count()

        if pagosc == 0 and creditosc == 0:
            messages.warning(request, "No existen registros a cerrar")
        else:
            with transaction.atomic():
                pago.objects.filter(estadoregistro=0).filter(credito__cliente__zona__filial=user_filial.filial).update(estadoregistro=1)
                credito.objects.filter(estadoregistro=0).filter(cliente__zona__filial=user_filial.filial).update(estadoregistro=1)
            messages.success(request, "Los registros han sido cerrados satisfactoriamente")
        my_render = reverse_lazy('cobrox:index')
        return HttpResponseRedirect(my_render)

    def dispatch(self, request, *args, **kwargs):
        if not request.user.is_authenticated:
            return self.handle_no_permission()
        user_filial = user_rol_filial.objects.get(usuario=self.request.user)
        if user_filial.rol.codigo == 'OPE':
            raise PermissionDenied
        return super().dispatch(request, *args, **kwargs)


class CreditoList(LoginRequiredMixin, FormMixin,ListView):
    paginate_by = getattr(settings, 'NUM_RECS_BY_PAG', None)
    form_class = CreditoSearchForm
    template_name = 'cobrox/credito_list.html'
    ajax_template_name = 'cobrox/credito_list_results.html'

    def get_initial(self):
        return {
            'codigo_id': '',
        }

    def est(self):
        return self.kwargs['act']

    def user_rol_filial(self):
        return user_rol_filial.objects.get(usuario=self.request.user)

    def get_queryset(self):

        if self.request.user.is_staff:
            qry = credito.objects.filter(nm_estado = self.kwargs['act']).order_by("id")
        else:
            obj = user_rol_filial.objects.get(usuario=self.request.user)
            qry = credito.objects.filter(cliente__zona__filial=obj.filial).filter(nm_estado = self.kwargs['act']).order_by("id")
        return qry

    def get_template_names(self):
        if self.request.is_ajax():
            return [self.ajax_template_name]
        return [self.template_name]

    def get_form_kwargs(self):
        return {
            'initial': self.get_initial(),
            'prefix': self.get_prefix(),
            'data': self.request.GET or None
        }

    def get(self, request, *args, **kwargs):
        self.object_list = self.get_queryset()
        form = self.get_form(self.get_form_class())
        if form.is_valid():
            self.object_list = form.filter_queryset(request, self.object_list)
        context = self.get_context_data(form=form, object_list=self.object_list)
        return self.render_to_response(context)

    def paginate_queryset(self, queryset, page_size):
        try:
            return super(CreditoList, self).paginate_queryset(queryset, page_size)
        except Http404:
            self.kwargs['page'] = 'last'
            return super(CreditoList, self).paginate_queryset(queryset, page_size)


class Estado_cuentalist(LoginRequiredMixin, ListView):
    model = pago
    template_name = 'cobrox/estado_cuenta.html'
    context_object_name = 'credito'

    def get_context_data(self, **kwargs):
        context = super(Estado_cuentalist, self).get_context_data(**kwargs)
        return context;

    def get_queryset(self):
        return pago.objects.filter(credito__id = self.kwargs['pk']).order_by('id')

    def cliente(self):
        ocredito = credito.objects.get(id = self.kwargs['pk'])
        ocliente = ocredito.cliente
        return ocliente

    def credito(self):
        ocredito = credito.objects.get(id = self.kwargs['pk'])

        return ocredito

    def dispatch(self, request, *args, **kwargs):
        if not request.user.is_authenticated:
            return self.handle_no_permission()
        try:
            ocredito = credito.objects.get(id=self.kwargs['pk'])

            obj = ocredito.cliente
        except ObjectDoesNotExist:
            raise Http404
        user_filial = user_rol_filial.objects.get(usuario=self.request.user)
        if user_filial.filial != obj.zona.filial and not self.request.user.is_staff:
            raise PermissionDenied
        if user_filial.rol.codigo == 'OPE':
            raise PermissionDenied
        return super().dispatch(request, *args, **kwargs)


class CambiarEstadoCredito(LoginRequiredMixin,DetailView):

    def get(self, request, *args, **kwargs):
        user_filial = user_rol_filial.objects.get(usuario=self.request.user)
        ocredito = credito.objects.get(id=self.kwargs['pk'])

        if ocredito.nm_estado == 1:
            ocredito.nm_estado=-1;
            mensaje_s="El crédito ha sido INACTIVADO satisfactoriamente"
        else:
            ocredito.nm_estado = 1;
            mensaje_s = "El crédito ha sido ACTIVADO satisfactoriamente"
        ocredito.save()

        messages.success(request,mensaje_s)
        my_render = reverse('cobrox:CreditoList',
                kwargs={'act': ocredito.nm_estado}
                )

        #my_render = reverse_lazy('cobrox:CreditoList')
        return HttpResponseRedirect(my_render)

    def dispatch(self, request, *args, **kwargs):
        if not request.user.is_authenticated:
            return self.handle_no_permission()
        try:
            ocredito = credito.objects.get(id=self.kwargs['pk'])
            obj = ocredito.cliente
        except ObjectDoesNotExist:
            raise Http404
        user_filial = user_rol_filial.objects.get(usuario=self.request.user)
        if user_filial.filial != obj.zona.filial and not self.request.user.is_staff:
            raise PermissionDenied
        if user_filial.rol.codigo == 'OPE':
            raise PermissionDenied
        return super().dispatch(request, *args, **kwargs)


class SuccessCreditoPage(LoginRequiredMixin,ListView):
    template_name = 'cobrox/success_credito.html'

    def get_queryset(self):
        pass

    def cliente(self):
        ocr= credito.objects.get(id=self.kwargs['pk'])
        return ocr.cliente


    def credito(self):
        return credito.objects.get(id=self.kwargs['pk'])

    def dispatch(self, request, *args, **kwargs):
        if not request.user.is_authenticated:
            return self.handle_no_permission()
        try:
            ocredito = credito.objects.get(id=self.kwargs['pk'])
            obj = ocredito.cliente
        except ObjectDoesNotExist:
            raise Http404
        user_filial = user_rol_filial.objects.get(usuario=self.request.user)
        if user_filial.filial != obj.zona.filial and not self.request.user.is_staff:
            raise PermissionDenied
        if user_filial.rol.codigo == 'OPE':
            raise PermissionDenied
        return super().dispatch(request, *args, **kwargs)


class FinanciamientoAdd(SuccessMessageMixin, LoginRequiredMixin, CreateView):
    form_class = CreditoAddForm
    template_name = 'cobrox/credito_add_upd.html'
    success_message = 'Información de Refinanciamiento Almacenado Correctamente!!!!'

    def get_success_url(self):
        return reverse('cobrox:SuccessCreditoPage',
                       kwargs={'pk':self.object.id}
                       )

    def get_context_data(self, **kwargs):
        context = super(FinanciamientoAdd, self).get_context_data(**kwargs)
        context['tip'] = 0
        context['izq'] = 12
        context['medio'] = 8

        return context;

    def form_valid(self, form ):
        action = self.request.POST.get('action')
        form = self.form_class(self.request.POST)

        if action == 'SAVE':
            with transaction.atomic():
                cred = form.save(commit=False)
                ocredito = credito.objects.get(pk=self.kwargs['pk'])

                qtydiascuota, capitalcuota, interescuota, totalcuota, interestotal, otorinterestotal = calculo(
                    form.cleaned_data['montootorgado'], form.cleaned_data['fechaini'].strftime('%Y-%m-%d'), form.cleaned_data['fechaven'].strftime('%Y-%m-%d'), form.cleaned_data['interespct'])
                cred.qtydiascuota = qtydiascuota
                cred.capitalcuota = capitalcuota
                cred.interescuota = interescuota
                cred.totalcuota = totalcuota
                cred.interestotal = interestotal
                cred.montoyinterestotal = otorinterestotal
                cred.cuotaspagadas = 0
                cred.cuotaspendientes =qtydiascuota
                cred.saldopendiente = otorinterestotal
                cred.save()


                ocreditofinanc = creditofinanc(credito_nvo=cred, credito_financia=ocredito)
                ocreditofinanc.save()

                cuotas_pag, cuotak, cuotai = calculopago(form.cleaned_data['montootorgado'],
                                                         ocredito.capitalcuota, ocredito.interescuota, ocredito.totalcuota)

                actualizacredito(ocredito, cuotas_pag, form.cleaned_data['montootorgado'])
                opag= pago(fecha=form.cleaned_data['fechaini'],recibo='REFINAN', credito=ocredito,
                           monto= form.cleaned_data['montootorgado'], capital=cuotak,interes=cuotai,cuota=cuotas_pag,tipoingreso=1)
                opag.save()

            return super().form_valid(form)
        return HttpResponseBadRequest()

    def cliente(self):
        ocredito = credito.objects.get(pk=self.kwargs['pk'])
        return ocredito.cliente

    def credito(self):
        ocredito = credito.objects.get(pk=self.kwargs['pk'])
        return ocredito

    def dispatch(self, request, *args, **kwargs):
        if not request.user.is_authenticated:
            return self.handle_no_permission()
        user_filial = user_rol_filial.objects.get(usuario=self.request.user)
        if user_filial.rol.codigo=='OPE':
            raise PermissionDenied
        return super().dispatch(request, *args, **kwargs)

    def get_initial(self):
        ocredito=credito.objects.get(pk=self.kwargs['pk'])


        return {
            'montootorgado':ocredito.saldopendiente,
            'cliente':ocredito.cliente ,
            'tipocredito':1,
            'estadocredito':0,
            'qtydiascuota':0,
            'capitalcuota':0,
            'interescuota':0,
            'totalcuota':0,
            'interestotal':0,
            'montoyinterestotal':0,
            'cuotaspagadas':0,
            'cuotaspendientes':0,
            'saldopendiente':0,
        }


class Archivos_clienteAdd(SuccessMessageMixin,LoginRequiredMixin,CreateView):
    form_class = Archivos_clienteForm
    template_name = 'cobrox/clientearchivo_add.html'
    success_message = "El archivo fué cargado satisfactoriamente"

    def get_context_data(self, **kwargs):
        context = super(Archivos_clienteAdd, self).get_context_data(**kwargs)
        context['cliente_archivos'] = cliente_archivo.objects.filter(cliente__id=self.kwargs['pk'])
        return context;

    def get_success_url(self):
        foo = reverse('cobrox:Archivos_clienteAdd', kwargs={'pk': self.kwargs['pk']})
        return foo

    def cliente(self):
        return cliente.objects.get(pk=self.kwargs['pk'])

    def get_initial(self):
        return {
            'nombre': self.request.user.id,
            'cliente': cliente.objects.get(pk = self.kwargs['pk'])

        }

    def form_valid(self, form ):
        action = self.request.POST.get('action')
        if action == 'SAVE':
            if form.is_valid():
                cliente_archivoo = form.save(commit=False)
                nombre = form.cleaned_data['archivo'].name
                cliente_archivoo.nombre = nombre
                cliente_archivoo.save()
            else:
                print('Invalid')
            return super().form_valid(form)

    def dispatch(self, request, *args, **kwargs):
        if not request.user.is_authenticated:
            return self.handle_no_permission()
        try:
            obj = cliente.objects.get(id=self.kwargs['pk'])
        except ObjectDoesNotExist:
            raise Http404
        user_filial = user_rol_filial.objects.get(usuario=self.request.user)
        if user_filial.filial != obj.zona.filial and not self.request.user.is_staff:
            raise PermissionDenied
        if user_filial.rol.codigo == 'OPE':
            raise PermissionDenied
        return super().dispatch(request, *args, **kwargs)


class ClienteArchivoDelete(SuccessMessageMixin, LoginRequiredMixin, DeleteView):

    def get(self, request, *args, **kwargs):
        try:
            obj = cliente_archivo.objects.get(id=self.kwargs['pk'])
            clien = obj.cliente
            obj.delete()
            messages.success(request, "El archivo ha sido eliminado satisfactoriamente.")


            my_render = reverse('cobrox:Archivos_clienteAdd',
                           kwargs={'pk': clien.id}
                           )
        except IntegrityError as e:
            messages.error(request, "El archivo no puede ser eliminado ya que tiene registros asociados")
            my_render = reverse('cobrox:Archivos_clienteAdd',
                                kwargs={'pk': clien.id}
                                )
        return HttpResponseRedirect(my_render)

    def dispatch(self, request, *args, **kwargs):
        if not request.user.is_authenticated:
            return self.handle_no_permission()
        try:
            obj = cliente_archivo.objects.get(id=self.kwargs['pk'])
        except ObjectDoesNotExist:
            raise Http404

        user_filial = user_rol_filial.objects.get(usuario=self.request.user)
        if user_filial.filial != obj.cliente.zona.filial and not self.request.user.is_staff:
            raise PermissionDenied
        if user_filial.rol.codigo == 'OPE':
            raise PermissionDenied
        return super().dispatch(request, *args, **kwargs)


class Archivos_creditoAdd(SuccessMessageMixin, LoginRequiredMixin, CreateView):
    form_class = Archivos_creditoForm
    template_name = 'cobrox/creditoarchivo_add.html'
    success_message = "El archivo fué cargado satisfactoriamente"

    def get_context_data(self, **kwargs):
        context = super(Archivos_creditoAdd, self).get_context_data(**kwargs)
        context['credito_archivos'] = credito_archivo.objects.filter(credito__id=self.kwargs['pk'])
        return context;

    def get_success_url(self):
        foo = reverse('cobrox:Archivos_creditoAdd', kwargs={'pk': self.kwargs['pk']})
        return foo

    def credito(self):
        return credito.objects.get(pk=self.kwargs['pk'])

    def get_initial(self):
        return {
            'nombre': self.request.user.id,
            'credito': credito.objects.get(pk=self.kwargs['pk'])

        }

    def form_valid(self, form):
        action = self.request.POST.get('action')
        if action == 'SAVE':
            if form.is_valid():
                credito_archivoo = form.save(commit=False)
                nombre = form.cleaned_data['archivo'].name
                credito_archivoo.nombre = nombre
                credito_archivoo.save()
            else:
                print('Invalid')
            return super().form_valid(form)

    def dispatch(self, request, *args, **kwargs):
        if not request.user.is_authenticated:
            return self.handle_no_permission()
        try:
            obj = credito.objects.get(id=self.kwargs['pk'])
        except ObjectDoesNotExist:
            raise Http404
        user_filial = user_rol_filial.objects.get(usuario=self.request.user)
        if user_filial.filial != obj.cliente.zona.filial and not self.request.user.is_staff:
            raise PermissionDenied
        if user_filial.rol.codigo == 'OPE':
            raise PermissionDenied
        return super().dispatch(request, *args, **kwargs)


class CreditoArchivoDelete(SuccessMessageMixin, LoginRequiredMixin, DeleteView):

    def get(self, request, *args, **kwargs):
        try:
            obj = credito_archivo.objects.get(id=self.kwargs['pk'])
            cred = obj.credito
            obj.delete()
            messages.success(request, "El archivo ha sido eliminado satisfactoriamente.")

            my_render = reverse('cobrox:Archivos_creditoAdd',
                                kwargs={'pk': cred.id}
                                )
        except IntegrityError as e:
            messages.error(request, "El archivo no puede ser eliminado ya que tiene registros asociados")
            my_render = reverse('cobrox:Archivos_creditoAdd',
                                kwargs={'pk': cred.id}
                                )
        return HttpResponseRedirect(my_render)

    def dispatch(self, request, *args, **kwargs):
        if not request.user.is_authenticated:
            return self.handle_no_permission()
        try:
            obj = credito_archivo.objects.get(id=self.kwargs['pk'])
        except ObjectDoesNotExist:
            raise Http404

        user_filial = user_rol_filial.objects.get(usuario=self.request.user)
        if user_filial.filial != obj.credito.cliente.zona.filial and not self.request.user.is_staff:
            raise PermissionDenied
        if user_filial.rol.codigo == 'OPE':
            raise PermissionDenied
        return super().dispatch(request, *args, **kwargs)


class ReporteCobros(LoginRequiredMixin, ListView):

    template_name = "cobrox/reporte_cobro.html"

    def get_context_data(self, **kwargs):
        context = super(ReporteCobros, self).get_context_data(**kwargs)
        return context

    def get_queryset(self):
        if self.request.user.is_staff:
            qry = credito.objects.filter(nm_estado=1).filter(estadocredito=0).filter(estadoregistro=1).order_by("cliente__zona__nombre","fechaven","cliente__nombre",)
        else:
            obj = user_rol_filial.objects.get(usuario=self.request.user)
            qry = qry = credito.objects.filter(zona__filial=obj.filial).filter(nm_estado=1).filter(estadocredito=0).filter(estadoregistro=1).order_by("cliente__zona__nombre","fechaven","cliente__nombre",)
        return qry

    def get(self, request, *args, **kwargs):
        #self.object = self.get_object(queryset=self.get_queryset())
        #return self.render_to_response(self.get_context_data(object=self.object))

        return super().get(request, *args, **kwargs)


class DesembolsoList(LoginRequiredMixin, FormMixin,ListView):

    form_class = ConsultaDesembolsoSearchForm
    template_name = 'cobrox/desembolso_list.html'
    ajax_template_name = 'cobrox/desembolso_list_results.html'

    def get_initial(self):
        return {
            'codigo_id': '',
        }

    def user_rol_filial(self):
        return user_rol_filial.objects.get(usuario=self.request.user)

    def get_queryset(self):

        if self.request.user.is_staff:
            qry = credito.objects.filter(nm_estado = 1).order_by("id")
        else:
            obj = user_rol_filial.objects.get(usuario=self.request.user)
            qry = credito.objects.filter(cliente__zona__filial=obj.filial).filter(nm_estado = 1).order_by("id")
        return qry

    def get_template_names(self):
        if self.request.is_ajax():
            return [self.ajax_template_name]
        return [self.template_name]

    def get_form_kwargs(self):
        return {
            'initial': self.get_initial(),
            'prefix': self.get_prefix(),
            'data': self.request.GET or None
        }

    def get(self, request, *args, **kwargs):
        self.object_list = self.get_queryset()
        form = self.get_form(self.get_form_class())
        if form.is_valid():
            self.object_list = form.filter_queryset(request, self.object_list)
            if form.cleaned_data['export_field']:
                return create_csv( self.object_list,'desembolsos')
        context = self.get_context_data(form=form, object_list=self.object_list)
        return self.render_to_response(context)


class PagoList(LoginRequiredMixin, FormMixin,ListView):

    form_class = ConsultaPagoSearchForm
    template_name = 'cobrox/pago_list.html'
    ajax_template_name = 'cobrox/pago_list_results.html'

    def get_initial(self):
        return {
            'codigo_id': '',
        }

    def form_valid(self, form):
        action = self.request.POST.get('action')
        if action == 'SAVE':

            return super().form_valid(form)
        #return HttpResponseBadRequest()

    def user_rol_filial(self):
        return user_rol_filial.objects.get(usuario=self.request.user)

    def get_queryset(self):

        if self.request.user.is_staff:
            qry = pago.objects.filter(credito__nm_estado = 1).order_by("id")
        else:
            obj = user_rol_filial.objects.get(usuario=self.request.user)
            qry = pago.objects.filter(credito__cliente__zona__filial=obj.filial).filter(credito__nm_estado = 1).order_by("id")
        return qry

    def get_template_names(self):
        if self.request.is_ajax():
            return [self.ajax_template_name]
        return [self.template_name]

    def get_form_kwargs(self):
        return {
            'initial': self.get_initial(),
            'prefix': self.get_prefix(),
            'data': self.request.GET or None
        }

    def get(self, request, *args, **kwargs):
        self.object_list = self.get_queryset()
        form = self.get_form(self.get_form_class())
        if form.is_valid():
            self.object_list = form.filter_queryset(request, self.object_list)
            if form.cleaned_data['export_field']:
                return create_csv( self.object_list,'pagos')
        context = self.get_context_data(form=form, object_list=self.object_list)
        return self.render_to_response(context)


def create_csv(queryset,filename):

    response = HttpResponse(
        content_type='text/csv',
        headers={'Content-Disposition': 'attachment; filename="'+ filename + '.csv"'},
    )

    writer = csv.writer(response)
    writer.writerow([field.name for field in queryset.model._meta.fields])

    for obj in queryset:
        row = []
        for field in obj._meta.fields:
            value = getattr(obj, field.name)
            row.append(value)
        writer.writerow(row)

    return response