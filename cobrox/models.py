from django.db import models
from django.contrib.auth.models import User
from uuid import uuid4
from django.conf import settings
from simple_history.models import HistoricalRecords
from django_currentuser.middleware import (
    get_current_user, get_current_authenticated_user)
from django_currentuser.db.models import CurrentUserField
import datetime
import os
ingresado = 0
conciliado = 1
estaoregistroc = (
    (ingresado, 'INGRESADO'),
    (conciliado, 'CONCILIADO'),
)
# Create your models here.


def imagepacexp_directory_path_with_uuid(instance, filename):
    extension = filename.split(".")[1].lower()
    return settings.PROJECT_ROOT + '/static/images/arc_clientes/{}/{}.{}'.format( instance.cliente_id, uuid4(),extension)


def imagecreexp_directory_path_with_uuid(instance, filename):
    extension = filename.split(".")[1].lower()
    return settings.PROJECT_ROOT + '/static/images/arc_clientes/{}/credito/{}/{}.{}'.format(instance.credito.cliente_id, instance.credito_id, uuid4(),extension)


class filial(models.Model):
    nombre = models.CharField(max_length=100, null=False, blank=False)
    user_creation = CurrentUserField(related_name='user_creationcc')
    date_creation = models.DateTimeField(default=datetime.datetime.now)
    user_last_update = CurrentUserField(on_update=True)

    history = HistoricalRecords()


    class Meta:
            ordering = ['nombre']

    def __str__(self):
        return self.nombre


# Create your models here.
class zona(models.Model):
    nombre = models.CharField(max_length=100, null=False, blank=False)
    filial = models.ForeignKey(filial,on_delete=models.DO_NOTHING,blank=False,null=False,related_name='zonas')
    user_creation = CurrentUserField(related_name='zona_user_creationcc')
    date_creation = models.DateTimeField(default=datetime.datetime.now)
    user_last_update = CurrentUserField(on_update=True)

    history = HistoricalRecords()

    class Meta:
            ordering = ['nombre']

    def __str__(self):
        return self.nombre


# Create your models here.
class tipo_cliente(models.Model):
    nombre = models.CharField(max_length=100, null=False, blank=False)
    user_creation = CurrentUserField(related_name='tipoc_user_creationcc')
    date_creation = models.DateTimeField(default=datetime.datetime.now)
    user_last_update = CurrentUserField(on_update=True)

    history = HistoricalRecords()
    class Meta:
            ordering = ['nombre']

    def __str__(self):
        return self.nombre


class cliente(models.Model):
    codigo = models.CharField(max_length=10, null=True, blank=True)
    nombre = models.CharField(max_length=200, null=False, blank=False)
    dui = models.CharField(max_length=15, null=False, blank=False)
    nit = models.CharField(max_length=25, null=False, blank=False)
    direccion = models.TextField(null=False, blank=False)
    telefono = models.CharField(max_length=25, null=False, blank=False)
    celular = models.CharField(max_length=25, null=True, blank=True)
    observacion = models.TextField(null=True, blank=True)
    tipo_cliente = models.ForeignKey(tipo_cliente,on_delete=models.DO_NOTHING,blank=True,null=True,related_name='tipo')
    zona = models.ForeignKey(zona,on_delete=models.DO_NOTHING,blank=False,null=False,related_name='zonas')

    user_creation = CurrentUserField(related_name='cliente_user_creationcc')
    date_creation = models.DateTimeField(default=datetime.datetime.now)
    user_last_update = CurrentUserField(on_update=True)

    history = HistoricalRecords()

    class Meta:
        ordering = ['nombre']

    def __str__(self):
        return self.nombre


class credito(models.Model):
    is_inactive = -1
    is_active = 1
    tipoestadoc = (
        (is_inactive, 'INACTIVE'),
        (is_active, 'ACTIVE'),
    )

    credito = 0
    refinan = 1
    tipocreditoc = (
        (credito, 'CRÉDITO'),
        (refinan, 'REFINANC'),
    )

    vigente = 0
    cancelado = 2
    estadocreditoc = (
        (vigente, 'VIGENTE'),
        (cancelado, 'CANCELADO'),
    )
    cliente = models.ForeignKey(cliente, on_delete=models.DO_NOTHING, blank=False, null=False, related_name='clien')
    codigo = models.CharField(max_length=10, null=True, blank=True)
    montootorgado = models.DecimalField(max_digits=10, decimal_places=2)
    fechaini = models.DateField(blank=False, null=False,help_text='Fecha de Inicio: YYYY-mm-dd')
    fechaven = models.DateField(blank=False, null=False, help_text='Fecha de Vencimiento: YYYY-mm-dd')
    interespct = models.DecimalField(max_digits=6, decimal_places=3, blank=False, null=False)

    qtydiascuota = models.DecimalField(max_digits=10, decimal_places=2,  blank=False, null=False)

    capitalcuota = models.DecimalField(max_digits=10, decimal_places=2,  blank=False, null=False)
    interescuota = models.DecimalField(max_digits=10, decimal_places=2, blank=False, null=False)
    totalcuota = models.DecimalField(max_digits=10, decimal_places=2, blank=False, null=False)

    interestotal = models.DecimalField(max_digits=10, decimal_places=2)
    montoyinterestotal = models.DecimalField(max_digits=10, decimal_places=2)

    cuotaspagadas = models.DecimalField(max_digits=10, decimal_places=2, blank=False, null=False)
    cuotaspendientes = models.DecimalField(max_digits=10, decimal_places=2, blank=False, null=False)
    saldopendiente = models.DecimalField(max_digits=10, decimal_places=2, blank=False, null=False)

    tipocredito = models.PositiveIntegerField(choices=tipocreditoc, null=False, help_text='Seleccione el Tipo de Crédito')
    estadocredito = models.PositiveIntegerField(choices=estadocreditoc, null=False, help_text='Seleccione el Estado del Crédito')
    estadoregistro = models.PositiveIntegerField(choices=estaoregistroc, null=False, blank=False,
                                                 help_text='Seleccione el Estado del Registro', default=0)
    nm_estado = models.IntegerField(choices=tipoestadoc, null=False, blank=False,
                                                 help_text='Activo o Inactivo el Registro', default=1)

    user_creation = CurrentUserField(related_name='credito_user_creationcc')
    date_creation = models.DateTimeField(default=datetime.datetime.now)
    user_last_update = CurrentUserField(on_update=True)

    history = HistoricalRecords()

    class Meta:
        ordering = ['id']

    def __str__(self):
        return str(self.id)


class pago (models.Model):
    recibo = 0
    refinanc = 1
    tipoingresoc = (
        (recibo, 'RECIBO COBRO'),
        (refinanc, 'REFINANCIAMIENTO'),
    )
    monto = models.DecimalField(max_digits=10, decimal_places=2)
    capital = models.DecimalField(max_digits=10, decimal_places=2)
    interes = models.DecimalField(max_digits=10, decimal_places=2)
    cuota = models.DecimalField(max_digits=10, decimal_places=2)
    recibo = models.CharField(max_length=10, null=False, blank=False)
    fecha = models.DateField(blank=False, null=False, help_text='Fecha: YYYY-mm-dd')
    credito = models.ForeignKey(credito, on_delete=models.DO_NOTHING, blank=False, null=False, related_name='credit')
    tipoingreso = models.PositiveIntegerField(choices=tipoingresoc, null=False,
                                              help_text='Seleccione el Tipo de Ingreso')
    estadoregistro = models.PositiveIntegerField(choices=estaoregistroc, null=False, blank=False,
                                              help_text='Seleccione el Estado del Registro',default=0)

    user_creation = CurrentUserField(related_name='pago_user_creationcc')
    date_creation = models.DateTimeField(default=datetime.datetime.now)
    user_last_update = CurrentUserField(on_update=True)

    history = HistoricalRecords()


class creditofinanc (models.Model):
    credito_nvo = models.ForeignKey(credito, on_delete=models.DO_NOTHING, blank=False, null=False, related_name='credito_padre')
    credito_financia = models.ForeignKey(credito, on_delete=models.DO_NOTHING, blank=False, null=False, related_name='credit_financia')
    user_creation = CurrentUserField(related_name='credfin_user_creationcc')
    date_creation = models.DateTimeField(default=datetime.datetime.now)
    user_last_update = CurrentUserField(on_update=True)

    history = HistoricalRecords()


class cliente_archivo(models.Model):
    cliente = models.ForeignKey(cliente,on_delete=models.DO_NOTHING)
    archivo = models.FileField(upload_to=imagepacexp_directory_path_with_uuid)
    nombre = models.CharField(max_length=400, blank=False, null=False,help_text='Descripcion del nombre del archivo')
    fecha = models.DateTimeField(auto_now_add=True)

    user_creation = CurrentUserField(related_name='clientearc_user_creationcc')
    date_creation = models.DateTimeField(default=datetime.datetime.now)
    user_last_update = CurrentUserField(on_update=True)

    history = HistoricalRecords()

    class Meta:
            ordering = ['fecha']

    @property
    def filename(self):
        return os.path.basename(self.archivo.name)


class credito_archivo(models.Model):
    credito = models.ForeignKey(credito,on_delete=models.DO_NOTHING)
    archivo = models.FileField(upload_to=imagecreexp_directory_path_with_uuid,max_length=500)
    nombre = models.CharField(max_length=400, blank=False, null=False,help_text='Descripcion del nombre del archivo')
    fecha = models.DateTimeField(auto_now_add=True)

    user_creation = CurrentUserField(related_name='creditoarc_user_creationcc')
    date_creation = models.DateTimeField(default=datetime.datetime.now)
    user_last_update = CurrentUserField(on_update=True)

    history = HistoricalRecords()

    class Meta:
            ordering = ['fecha']

    @property
    def filename(self):
        return os.path.basename(self.archivo.name)