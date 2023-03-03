from django import template

import datetime
from django.utils.safestring import mark_safe
from django.conf import settings

from django.core.exceptions import ObjectDoesNotExist
from django.db.models import Avg, Max, Min, Sum
from user.models import user_rol_filial
from cobrox.views import vigenciaestadocredito


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






