from django import template

import datetime
from django.utils.safestring import mark_safe
from django.conf import settings

from django.core.exceptions import ObjectDoesNotExist
from django.db.models import Avg, Max, Min, Sum
from user.models import user_rol_filial
from cobrox.views import vigenciaestadocredito
from cobrox.models import pago,creditofinanc
from django.core.exceptions import ObjectDoesNotExist


register = template.Library()

@register.simple_tag
def get_rol_by_user(user_id):
    try:
        obj = user_rol_filial.objects.get(usuario__id=user_id).rol.nombre
    except ObjectDoesNotExist:
        obj = '-'
    return obj

@register.simple_tag
def revigenciaestadocredito(saldopendiente, fechavenc,estadocredito):
    return vigenciaestadocredito(saldopendiente, fechavenc, estadocredito)

@register.simple_tag
def get_filial_by_user(user_id):
    try:
        obj = user_rol_filial.objects.get(usuario__id=user_id).filial.nombre
    except ObjectDoesNotExist:
        obj = '-'
    return obj


@register.simple_tag
def find_hashtag(consulta):
    if consulta:
        while 1:
            hashcount = consulta.find('#')
            if hashcount>0:
                endhas= consulta.find(' ', hashcount)
                if endhas==-1:
                    endhas = len(consulta)
                reempl=consulta[hashcount:endhas]
                consulta = consulta.replace(reempl, '<span class=\"label label-danger\">' + consulta[hashcount+1:endhas] + '</span>')
            else:
                break
    return  mark_safe(consulta)




@register.simple_tag
def filter_sum(monto1, monto2):
    if monto1 is None:
        monto1 = 0
    if monto2 is None:
        monto2 = 0
    return monto1 + monto2



@register.simple_tag
def mostrar_field_obs(nombre):
    if nombre[0:10]=='customobs_':
        return 1
    else:
        return 0


@register.simple_tag
def edad_anos(fecha_nacimiento, consulta):
    anio=  consulta.fecha.year - fecha_nacimiento.year
    return anio

@register.simple_tag
def dia_semana(dia):
    dow = "XX"
    if dia == 0:
        dow = "Lunes"
    elif dia == 1:
        dow = "Martes"
    elif dia == 2:
        dow = "Miércoles"
    elif dia == 3:
        dow = "Jueves"
    elif dia == 4:
        dow = "Viernes"
    elif dia == 5:
        dow = "Sábado"
    elif dia == 6:
        dow = "Domingo"
    return dow


@register.simple_tag
def refinanc_originado(ocredito):
    try:
        ocredfinanc = creditofinanc.objects.get(credito_financia=ocredito)
    except ObjectDoesNotExist:
        return None
    return ocredfinanc.credito_nvo


@register.simple_tag
def credito_original(orefinanc):
    try:
        ocredfinanc = creditofinanc.objects.get(credito_nvo=orefinanc)
    except ObjectDoesNotExist:
        return None
    return ocredfinanc.credito_financia

@register.simple_tag
def muestra_pagos(pcredito):
    qs = pago.objects.filter(credito=pcredito).order_by("fecha","id")

    devolver = ""
    for entry in qs:

        devolver =devolver+ "<tr>" \
                  "<td>" + entry.fecha.strftime("%Y-%m-%d") +"</td>" \
                  "<td align='right'> $ " + str(round(entry.monto,2)) + "</td>" \
                  "<td align='right'> $ " + str(round(entry.capital,2)) + "</td>" \
                  "<td align='right'> $ " + str(round(entry.interes,2)) + "</td>" \
                  "<td align='right'> " + str(round(entry.cuota,2)) + "</td>" \
                  "<td align='right'>" + entry.recibo + "</td>"
        if entry.tipoingreso == 0:
            devolver =devolver+"<td>RECIBO</td>"
        else:
            devolver = devolver + "<td>REFINANC</td>"
        if entry.estadoregistro == 0:
            devolver =devolver+"<td><a class =\"confirmacion\" href=\"/PagoDelete/"+ str(entry.id)+ "\" ><button type=\"button\" class=\"btn btn-outline btn-danger\"><i class=\"fa fa-times-circle\"></i></button></a></td></tr>"
        else:
            devolver = devolver + "<td></td></tr>"
    return mark_safe(devolver)

@register.simple_tag
def changeZona(zonaid):
    return zonaid

