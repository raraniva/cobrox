from django.shortcuts import render
from django.template import loader
from django.core.mail import send_mail
from django.views.generic import (ListView,DetailView,CreateView,UpdateView,DeleteView)
from django.http import HttpResponseRedirect
from .models import filial,zona,tipo_cliente,cliente,credito
from .forms import FilialAddForm,\
    FilialUpdateForm,ZonaAddForm,ZonaUpdateForm,TipoclienteAddForm,TipoclienteUpdateForm,ClienteAddForm,ClienteUpdateForm,ClienteSearchForm,CreditoAddForm
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
        return context;

    def get_queryset(self):
        return credito.objects.filter(cliente__id = self.kwargs['pk']).order_by('fechaini').reverse()

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

    def get_success_url(self):
        return reverse('cobrox:Credito_clientelist',
                       kwargs={'pk':self.kwargs['pk']}
                       )

    def form_valid(self, form ):
        action = self.request.POST.get('action')
        form = self.form_class(self.request.POST)
        print('aqui');
        if action == 'SAVE':
            with transaction.atomic():
                cred = form.save(commit=False)
                print('aqui');

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
        user_filial = user_rol_filial.objects.get(usuario=self.request.user)
        if user_filial.filial != obj.cliente.zona.filial and not self.request.user.is_staff:
            raise PermissionDenied
        if user_filial.rol.codigo == 'OPE':
            raise PermissionDenied
        return super().dispatch(request, *args, **kwargs)