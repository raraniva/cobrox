from django.db import models


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
    observacion = models.TextField(null=True, blank=True)
    tipo_cliente = models.ForeignKey(tipo_cliente,on_delete=models.DO_NOTHING,blank=True,null=True,related_name='tipo')
    zona = models.ForeignKey(zona,on_delete=models.DO_NOTHING,blank=False,null=False,related_name='zonas')

    class Meta:
        ordering = ['nombre']

    def __str__(self):
        return self.nombre
