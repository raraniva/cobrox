# Generated by Django 3.2.18 on 2023-03-09 18:03

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('cobrox', '0010_credito_nm_estado'),
    ]

    operations = [
        migrations.CreateModel(
            name='creditofinanc',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('credito_financia', models.ForeignKey(on_delete=django.db.models.deletion.DO_NOTHING, related_name='credit_financia', to='cobrox.credito')),
                ('credito_nvo', models.ForeignKey(on_delete=django.db.models.deletion.DO_NOTHING, related_name='credito_padre', to='cobrox.credito')),
            ],
        ),
    ]
