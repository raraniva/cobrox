from django.db import models

ingresado = 0
conciliado = 1
estaoregistroc = (
    (ingresado, 'INGRESADO'),
    (conciliado, 'CONCILIADO'),
)
# Create your models here.
class filial(models.Model):
    nombre = models.CharField(max_length=100, null=False, blank=False)

    class Meta:
            ordering = ['nombre']

    def __str__(self):
        return self.nombre


# Create your models here.
class zona(models.Model):
    nombre = models.CharField(max_length=100, null=False, blank=False)
    filial = models.ForeignKey(filial,on_delete=models.DO_NOTHING,blank=False,null=False,related_name='zonas')

    class Meta:
            ordering = ['nombre']

    def __str__(self):
        return self.nombre


# Create your models here.
class tipo_cliente(models.Model):
    nombre = models.CharField(max_length=100, null=False, blank=False)

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

    class Meta:
        ordering = ['nombre']

    def __str__(self):
        return self.nombre


class credito(models.Model):
    credito = 0
    refinan = 1
    tipocreditoc = (
        (credito, 'CRÉDITO'),
        (refinan, 'REFINANCIAMIENTO'),
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

    class Meta:
        ordering = ['id']

    def __str__(self):
        return self.cliente


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