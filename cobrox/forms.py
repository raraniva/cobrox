from django import forms
from .models import filial,zona,tipo_cliente


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
