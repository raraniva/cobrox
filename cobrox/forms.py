from django import forms
from .models import filial,zona,tipo_cliente,cliente
from django.db.models import Q
from user.models import user_rol_filial

class FilialAddForm(forms.ModelForm):

    class Meta:
        model = filial
        fields = ['nombre']


class FilialUpdateForm(forms.ModelForm):

    class Meta:
        model = filial
        fields = ['nombre']


class ZonaAddForm(forms.ModelForm):

    class Meta:
        model = zona
        fields = ['nombre','filial']


class ZonaUpdateForm(forms.ModelForm):

    class Meta:
        model = zona
        fields = ['nombre','filial']


class TipoclienteAddForm(forms.ModelForm):

    class Meta:
        model = tipo_cliente
        fields = ['nombre']


class TipoclienteUpdateForm(forms.ModelForm):

    class Meta:
        model = tipo_cliente
        fields = ['nombre']


class ClienteAddForm(forms.ModelForm):

    class Meta:
        model = cliente
        fields = ['codigo','nombre','dui','nit','direccion','telefono','observacion','tipo_cliente','zona']
        widgets = {
                   'dui': forms.TextInput(attrs={'placeholder': '________-_','data-mask': '99999999-9'}),
                   'telefono': forms.TextInput(attrs={'placeholder': '____-____','data-mask': '9999-9999'}),
                   'nit': forms.TextInput(attrs={'placeholder': '____-______-___-_', 'data-mask': '9999-999999-999-9'}),
                   'observacion': forms.Textarea(attrs={'placeholder': 'Comentarios'}),
                   }
        labels = {
            'dui': 'Digite el DUI:',
            'tel': 'Digite el teléfono:',
            'nit': 'Digite el NIT:',
            'codigo': 'Código Anterior:',
            'telefono': 'Teléfono:',
            'observacion': 'Observación:',
            'direccion': 'Dirección:',
            'nombre': 'Nombre Completo:',
            'tipo_cliente': 'Tipo de Cliente:',

        }

    def __init__(self, *args, **kwargs):
        self.request = kwargs.pop('request', None)
        super(ClienteAddForm, self).__init__(*args, **kwargs)
        if self.request:
            if self.request.user.is_staff:
                qry = zona.objects.all().order_by("nombre","id")
            else:
                obj = user_rol_filial.objects.get(usuario=self.request.user)
                qry = zona.objects.filter(filial=obj.filial).order_by("nombre", "id")

            self.fields['zona'].queryset = qry


class ClienteUpdateForm(forms.ModelForm):
    class Meta:
        model = cliente
        fields = ['codigo', 'nombre', 'dui', 'nit', 'direccion', 'telefono', 'observacion', 'tipo_cliente', 'zona']
        widgets = {
            'dui': forms.TextInput(attrs={'placeholder': '________-_', 'data-mask': '99999999-9'}),
            'telefono': forms.TextInput(attrs={'placeholder': '____-____', 'data-mask': '9999-9999'}),
            'nit': forms.TextInput(attrs={'placeholder': '____-______-___-_', 'data-mask': '9999-999999-999-9'}),
            'observacion': forms.Textarea(attrs={'placeholder': 'Comentarios'}),
        }
        labels = {
            'dui': 'Digite el DUI:',
            'tel': 'Digite el teléfono:',
            'nit': 'Digite el NIT:',
            'codigo': 'Código Anterior:',
            'telefono': 'Teléfono:',
            'observacion': 'Observación:',
            'direccion': 'Dirección:',
            'nombre': 'Nombre Completo:',
            'tipo_cliente': 'Tipo de Cliente:',

        }

    def __init__(self, *args, **kwargs):
        self.request = kwargs.pop('request', None)
        self.cliente = kwargs.pop('cliente', None)
        super(ClienteUpdateForm, self).__init__(*args, **kwargs)
        if self.request:
            if self.request.user.is_staff:
                qry = zona.objects.all().order_by("nombre", "id")
            else:
                obj = user_rol_filial.objects.get(usuario=self.request.user)
                qry = zona.objects.filter(filial=obj.filial).order_by("nombre", "id")

            self.fields['zona'].queryset = qry

        self.fields['zona'].initial = cliente.objects.get(id=self.cliente.id).zona


class ClienteSearchForm(forms.Form):
    apellidos = forms.CharField (required=False)

    def filter_queryset(self, request, queryset):
        if self.cleaned_data['apellidos']:
            return queryset.filter(Q(codigo__unaccent__icontains=self.cleaned_data['apellidos']) | Q(nombre__unaccent__icontains=self.cleaned_data['apellidos']) | Q(nombre__unaccent__icontains=self.cleaned_data['apellidos']))
        return queryset