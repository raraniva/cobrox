# Generated by Django 3.2.18 on 2023-03-04 15:28

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('cobrox', '0008_rename_pagos_pago'),
    ]

    operations = [
        migrations.AddField(
            model_name='credito',
            name='estadoregistro',
            field=models.PositiveIntegerField(choices=[(0, 'INGRESADO'), (1, 'CONCILIADO')], default=0, help_text='Seleccione el Estado del Registro'),
        ),
        migrations.AddField(
            model_name='pago',
            name='estadoregistro',
            field=models.PositiveIntegerField(choices=[(0, 'INGRESADO'), (1, 'CONCILIADO')], default=0, help_text='Seleccione el Estado del Registro'),
        ),
    ]
