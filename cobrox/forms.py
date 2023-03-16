from django import forms
from .models import filial,zona,tipo_cliente,cliente,credito,pago,cliente_archivo,credito_archivo
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
        fields = ['codigo','nombre','dui','nit','direccion','telefono','celular','observacion','tipo_cliente','zona']
        widgets = {
                   'dui': forms.TextInput(attrs={'placeholder': '________-_','data-mask': '99999999-9'}),
                   'telefono': forms.TextInput(attrs={'placeholder': '____-____','data-mask': '9999-9999'}),
                   'celular': forms.TextInput(attrs={'placeholder': '____-____', 'data-mask': '9999-9999'}),
                   'nit': forms.TextInput(attrs={'placeholder': '____-______-___-_', 'data-mask': '9999-999999-999-9'}),
                   'observacion': forms.Textarea(attrs={'placeholder': 'Comentarios','rows': '4'}),
                   'direccion': forms.Textarea(attrs={'rows': '4'}),
                   }
        labels = {
            'dui': 'Digite el DUI:',
            'tel': 'Digite el teléfono:',
            'nit': 'Digite el NIT:',
            'codigo': 'Código Anterior:',
            'telefono': 'Teléfono:',
            'celular': 'No Celular:',
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
        fields = ['codigo', 'nombre', 'dui', 'nit', 'direccion', 'telefono','celular', 'observacion', 'tipo_cliente', 'zona']
        widgets = {
            'dui': forms.TextInput(attrs={'placeholder': '________-_', 'data-mask': '99999999-9'}),
            'telefono': forms.TextInput(attrs={'placeholder': '____-____', 'data-mask': '9999-9999'}),
            'celular': forms.TextInput(attrs={'placeholder': '____-____', 'data-mask': '9999-9999'}),
            'nit': forms.TextInput(attrs={'placeholder': '____-______-___-_', 'data-mask': '9999-999999-999-9'}),
            'observacion': forms.Textarea(attrs={'placeholder': 'Comentarios','rows': '4'}),
            'direccion': forms.Textarea(attrs={'rows': '4'}),
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
            'celular': 'No Celular:',
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


class CreditoSearchForm(forms.Form):
    codigo_id = forms.CharField (required=False)

    def filter_queryset(self, request, queryset):
        if self.cleaned_data['codigo_id']:
            return queryset.filter(Q(id=self.cleaned_data['codigo_id']) | Q(codigo__unaccent__icontains=self.cleaned_data['codigo_id']))
        return queryset


class CreditoAddForm(forms.ModelForm):

    class Meta:
        model = credito
        fields = ['cliente','montootorgado','fechaini','fechaven','interespct','qtydiascuota','capitalcuota','interescuota',
                  'totalcuota','interestotal','montoyinterestotal','cuotaspagadas','cuotaspendientes','saldopendiente','tipocredito','estadocredito']
        widgets = {
            'cliente': forms.HiddenInput(),
            'qtydiascuota': forms.HiddenInput(),
            'capitalcuota': forms.HiddenInput(),
            'interescuota': forms.HiddenInput(),
            'totalcuota': forms.HiddenInput(),
            'cuotaspagadas': forms.HiddenInput(),
            'cuotaspendientes': forms.HiddenInput(),
            'saldopendiente': forms.HiddenInput(),
            'tipocredito': forms.HiddenInput(),
            'estadocredito': forms.HiddenInput(),
            'interestotal': forms.HiddenInput(),
            'montoyinterestotal': forms.HiddenInput(),

                   }
        labels = {
            'montootorgado': 'Digite Monto a Otorgar:',
            'fechaini': 'Digite Fecha de Inicio:',
            'fechafin': 'Digite Fecha de Vencimiento:',
            'interespct': 'Digite Tasa de interés (Ej: 15 , 20):',
        }


class PagoAddForm(forms.ModelForm):

    class Meta:
        model = pago
        fields = ['monto','capital','interes','cuota','recibo','fecha','credito','tipoingreso']
        widgets = {
            'capital': forms.HiddenInput(),
            'interes': forms.HiddenInput(),
            'cuota': forms.HiddenInput(),
            'credito': forms.HiddenInput(),
            'tipoingreso' :forms.HiddenInput(),
                   }
        labels = {
            'monto': 'Digite Monto Recibido:',
            'recibo': 'Digite el # de Recibo:',
            'fecha': 'Seleccione fecha:',
            'tipoingreso': 'Tipo de Ingreso:',
        }


class Archivos_clienteForm(forms.ModelForm):

    class Meta:
        model = cliente_archivo
        fields=['cliente','archivo','nombre']
        widgets = {'cliente': forms.HiddenInput(),
                   'nombre': forms.HiddenInput(),
                    'archivo' : forms.FileInput(attrs={'accept':'.png, .jpg, .jpeg'})}
                   #'file' : forms.FileInput(attrs={'accept':'.png, .jpg, .jpeg'})}


class Archivos_creditoForm(forms.ModelForm):

    class Meta:
        model = credito_archivo
        fields=['credito','archivo','nombre']
        widgets = {'credito': forms.HiddenInput(),
                   'nombre': forms.HiddenInput(),
                    'archivo' : forms.FileInput(attrs={'accept':'.png, .jpg, .jpeg'})}
                   #'file' : forms.FileInput(attrs={'accept':'.png, .jpg, .jpeg'})}