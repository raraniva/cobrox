# Generated by Django 3.2.18 on 2023-03-16 11:49

import datetime
from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion
import django_currentuser.db.models.fields
import django_currentuser.middleware
import simple_history.models


class Migration(migrations.Migration):

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
        ('cobrox', '0017_auto_20230316_1147'),
    ]

    operations = [
        migrations.AddField(
            model_name='cliente',
            name='date_creation',
            field=models.DateTimeField(default=datetime.datetime.now),
        ),
        migrations.AddField(
            model_name='cliente',
            name='user_creation',
            field=django_currentuser.db.models.fields.CurrentUserField(default=django_currentuser.middleware.get_current_authenticated_user, null=True, on_delete=django.db.models.deletion.CASCADE, related_name='cliente_user_creationcc', to=settings.AUTH_USER_MODEL),
        ),
        migrations.AddField(
            model_name='cliente',
            name='user_last_update',
            field=django_currentuser.db.models.fields.CurrentUserField(default=django_currentuser.middleware.get_current_authenticated_user, null=True, on_delete=django.db.models.deletion.CASCADE, on_update=True, to=settings.AUTH_USER_MODEL),
        ),
        migrations.AddField(
            model_name='cliente_archivo',
            name='date_creation',
            field=models.DateTimeField(default=datetime.datetime.now),
        ),
        migrations.AddField(
            model_name='cliente_archivo',
            name='user_creation',
            field=django_currentuser.db.models.fields.CurrentUserField(default=django_currentuser.middleware.get_current_authenticated_user, null=True, on_delete=django.db.models.deletion.CASCADE, related_name='clientearc_user_creationcc', to=settings.AUTH_USER_MODEL),
        ),
        migrations.AddField(
            model_name='cliente_archivo',
            name='user_last_update',
            field=django_currentuser.db.models.fields.CurrentUserField(default=django_currentuser.middleware.get_current_authenticated_user, null=True, on_delete=django.db.models.deletion.CASCADE, on_update=True, to=settings.AUTH_USER_MODEL),
        ),
        migrations.AddField(
            model_name='credito',
            name='date_creation',
            field=models.DateTimeField(default=datetime.datetime.now),
        ),
        migrations.AddField(
            model_name='credito',
            name='user_creation',
            field=django_currentuser.db.models.fields.CurrentUserField(default=django_currentuser.middleware.get_current_authenticated_user, null=True, on_delete=django.db.models.deletion.CASCADE, related_name='credito_user_creationcc', to=settings.AUTH_USER_MODEL),
        ),
        migrations.AddField(
            model_name='credito',
            name='user_last_update',
            field=django_currentuser.db.models.fields.CurrentUserField(default=django_currentuser.middleware.get_current_authenticated_user, null=True, on_delete=django.db.models.deletion.CASCADE, on_update=True, to=settings.AUTH_USER_MODEL),
        ),
        migrations.AddField(
            model_name='credito_archivo',
            name='date_creation',
            field=models.DateTimeField(default=datetime.datetime.now),
        ),
        migrations.AddField(
            model_name='credito_archivo',
            name='user_creation',
            field=django_currentuser.db.models.fields.CurrentUserField(default=django_currentuser.middleware.get_current_authenticated_user, null=True, on_delete=django.db.models.deletion.CASCADE, related_name='creditoarc_user_creationcc', to=settings.AUTH_USER_MODEL),
        ),
        migrations.AddField(
            model_name='credito_archivo',
            name='user_last_update',
            field=django_currentuser.db.models.fields.CurrentUserField(default=django_currentuser.middleware.get_current_authenticated_user, null=True, on_delete=django.db.models.deletion.CASCADE, on_update=True, to=settings.AUTH_USER_MODEL),
        ),
        migrations.AddField(
            model_name='creditofinanc',
            name='date_creation',
            field=models.DateTimeField(default=datetime.datetime.now),
        ),
        migrations.AddField(
            model_name='creditofinanc',
            name='user_creation',
            field=django_currentuser.db.models.fields.CurrentUserField(default=django_currentuser.middleware.get_current_authenticated_user, null=True, on_delete=django.db.models.deletion.CASCADE, related_name='credfin_user_creationcc', to=settings.AUTH_USER_MODEL),
        ),
        migrations.AddField(
            model_name='creditofinanc',
            name='user_last_update',
            field=django_currentuser.db.models.fields.CurrentUserField(default=django_currentuser.middleware.get_current_authenticated_user, null=True, on_delete=django.db.models.deletion.CASCADE, on_update=True, to=settings.AUTH_USER_MODEL),
        ),
        migrations.AddField(
            model_name='pago',
            name='date_creation',
            field=models.DateTimeField(default=datetime.datetime.now),
        ),
        migrations.AddField(
            model_name='pago',
            name='user_creation',
            field=django_currentuser.db.models.fields.CurrentUserField(default=django_currentuser.middleware.get_current_authenticated_user, null=True, on_delete=django.db.models.deletion.CASCADE, related_name='pago_user_creationcc', to=settings.AUTH_USER_MODEL),
        ),
        migrations.AddField(
            model_name='pago',
            name='user_last_update',
            field=django_currentuser.db.models.fields.CurrentUserField(default=django_currentuser.middleware.get_current_authenticated_user, null=True, on_delete=django.db.models.deletion.CASCADE, on_update=True, to=settings.AUTH_USER_MODEL),
        ),
        migrations.AddField(
            model_name='tipo_cliente',
            name='date_creation',
            field=models.DateTimeField(default=datetime.datetime.now),
        ),
        migrations.AddField(
            model_name='tipo_cliente',
            name='user_creation',
            field=django_currentuser.db.models.fields.CurrentUserField(default=django_currentuser.middleware.get_current_authenticated_user, null=True, on_delete=django.db.models.deletion.CASCADE, related_name='tipoc_user_creationcc', to=settings.AUTH_USER_MODEL),
        ),
        migrations.AddField(
            model_name='tipo_cliente',
            name='user_last_update',
            field=django_currentuser.db.models.fields.CurrentUserField(default=django_currentuser.middleware.get_current_authenticated_user, null=True, on_delete=django.db.models.deletion.CASCADE, on_update=True, to=settings.AUTH_USER_MODEL),
        ),
        migrations.CreateModel(
            name='Historicaltipo_cliente',
            fields=[
                ('id', models.BigIntegerField(auto_created=True, blank=True, db_index=True, verbose_name='ID')),
                ('nombre', models.CharField(max_length=100)),
                ('date_creation', models.DateTimeField(default=datetime.datetime.now)),
                ('history_id', models.AutoField(primary_key=True, serialize=False)),
                ('history_date', models.DateTimeField()),
                ('history_change_reason', models.CharField(max_length=100, null=True)),
                ('history_type', models.CharField(choices=[('+', 'Created'), ('~', 'Changed'), ('-', 'Deleted')], max_length=1)),
                ('history_user', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, related_name='+', to=settings.AUTH_USER_MODEL)),
                ('user_creation', django_currentuser.db.models.fields.CurrentUserField(blank=True, db_constraint=False, default=django_currentuser.middleware.get_current_authenticated_user, null=True, on_delete=django.db.models.deletion.DO_NOTHING, related_name='+', to=settings.AUTH_USER_MODEL)),
                ('user_last_update', django_currentuser.db.models.fields.CurrentUserField(db_constraint=False, default=django_currentuser.middleware.get_current_authenticated_user, null=True, on_delete=django.db.models.deletion.DO_NOTHING, on_update=True, related_name='+', to=settings.AUTH_USER_MODEL)),
            ],
            options={
                'verbose_name': 'historical tipo_cliente',
                'ordering': ('-history_date', '-history_id'),
                'get_latest_by': 'history_date',
            },
            bases=(simple_history.models.HistoricalChanges, models.Model),
        ),
        migrations.CreateModel(
            name='Historicalpago',
            fields=[
                ('id', models.BigIntegerField(auto_created=True, blank=True, db_index=True, verbose_name='ID')),
                ('monto', models.DecimalField(decimal_places=2, max_digits=10)),
                ('capital', models.DecimalField(decimal_places=2, max_digits=10)),
                ('interes', models.DecimalField(decimal_places=2, max_digits=10)),
                ('cuota', models.DecimalField(decimal_places=2, max_digits=10)),
                ('recibo', models.CharField(max_length=10)),
                ('fecha', models.DateField(help_text='Fecha: YYYY-mm-dd')),
                ('tipoingreso', models.PositiveIntegerField(choices=[(0, 'RECIBO COBRO'), (1, 'REFINANCIAMIENTO')], help_text='Seleccione el Tipo de Ingreso')),
                ('estadoregistro', models.PositiveIntegerField(choices=[(0, 'INGRESADO'), (1, 'CONCILIADO')], default=0, help_text='Seleccione el Estado del Registro')),
                ('date_creation', models.DateTimeField(default=datetime.datetime.now)),
                ('history_id', models.AutoField(primary_key=True, serialize=False)),
                ('history_date', models.DateTimeField()),
                ('history_change_reason', models.CharField(max_length=100, null=True)),
                ('history_type', models.CharField(choices=[('+', 'Created'), ('~', 'Changed'), ('-', 'Deleted')], max_length=1)),
                ('credito', models.ForeignKey(blank=True, db_constraint=False, null=True, on_delete=django.db.models.deletion.DO_NOTHING, related_name='+', to='cobrox.credito')),
                ('history_user', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, related_name='+', to=settings.AUTH_USER_MODEL)),
                ('user_creation', django_currentuser.db.models.fields.CurrentUserField(blank=True, db_constraint=False, default=django_currentuser.middleware.get_current_authenticated_user, null=True, on_delete=django.db.models.deletion.DO_NOTHING, related_name='+', to=settings.AUTH_USER_MODEL)),
                ('user_last_update', django_currentuser.db.models.fields.CurrentUserField(db_constraint=False, default=django_currentuser.middleware.get_current_authenticated_user, null=True, on_delete=django.db.models.deletion.DO_NOTHING, on_update=True, related_name='+', to=settings.AUTH_USER_MODEL)),
            ],
            options={
                'verbose_name': 'historical pago',
                'ordering': ('-history_date', '-history_id'),
                'get_latest_by': 'history_date',
            },
            bases=(simple_history.models.HistoricalChanges, models.Model),
        ),
        migrations.CreateModel(
            name='Historicalcreditofinanc',
            fields=[
                ('id', models.BigIntegerField(auto_created=True, blank=True, db_index=True, verbose_name='ID')),
                ('date_creation', models.DateTimeField(default=datetime.datetime.now)),
                ('history_id', models.AutoField(primary_key=True, serialize=False)),
                ('history_date', models.DateTimeField()),
                ('history_change_reason', models.CharField(max_length=100, null=True)),
                ('history_type', models.CharField(choices=[('+', 'Created'), ('~', 'Changed'), ('-', 'Deleted')], max_length=1)),
                ('credito_financia', models.ForeignKey(blank=True, db_constraint=False, null=True, on_delete=django.db.models.deletion.DO_NOTHING, related_name='+', to='cobrox.credito')),
                ('credito_nvo', models.ForeignKey(blank=True, db_constraint=False, null=True, on_delete=django.db.models.deletion.DO_NOTHING, related_name='+', to='cobrox.credito')),
                ('history_user', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, related_name='+', to=settings.AUTH_USER_MODEL)),
                ('user_creation', django_currentuser.db.models.fields.CurrentUserField(blank=True, db_constraint=False, default=django_currentuser.middleware.get_current_authenticated_user, null=True, on_delete=django.db.models.deletion.DO_NOTHING, related_name='+', to=settings.AUTH_USER_MODEL)),
                ('user_last_update', django_currentuser.db.models.fields.CurrentUserField(db_constraint=False, default=django_currentuser.middleware.get_current_authenticated_user, null=True, on_delete=django.db.models.deletion.DO_NOTHING, on_update=True, related_name='+', to=settings.AUTH_USER_MODEL)),
            ],
            options={
                'verbose_name': 'historical creditofinanc',
                'ordering': ('-history_date', '-history_id'),
                'get_latest_by': 'history_date',
            },
            bases=(simple_history.models.HistoricalChanges, models.Model),
        ),
        migrations.CreateModel(
            name='Historicalcredito_archivo',
            fields=[
                ('id', models.BigIntegerField(auto_created=True, blank=True, db_index=True, verbose_name='ID')),
                ('archivo', models.TextField(max_length=500)),
                ('nombre', models.CharField(help_text='Descripcion del nombre del archivo', max_length=400)),
                ('fecha', models.DateTimeField(blank=True, editable=False)),
                ('date_creation', models.DateTimeField(default=datetime.datetime.now)),
                ('history_id', models.AutoField(primary_key=True, serialize=False)),
                ('history_date', models.DateTimeField()),
                ('history_change_reason', models.CharField(max_length=100, null=True)),
                ('history_type', models.CharField(choices=[('+', 'Created'), ('~', 'Changed'), ('-', 'Deleted')], max_length=1)),
                ('credito', models.ForeignKey(blank=True, db_constraint=False, null=True, on_delete=django.db.models.deletion.DO_NOTHING, related_name='+', to='cobrox.credito')),
                ('history_user', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, related_name='+', to=settings.AUTH_USER_MODEL)),
                ('user_creation', django_currentuser.db.models.fields.CurrentUserField(blank=True, db_constraint=False, default=django_currentuser.middleware.get_current_authenticated_user, null=True, on_delete=django.db.models.deletion.DO_NOTHING, related_name='+', to=settings.AUTH_USER_MODEL)),
                ('user_last_update', django_currentuser.db.models.fields.CurrentUserField(db_constraint=False, default=django_currentuser.middleware.get_current_authenticated_user, null=True, on_delete=django.db.models.deletion.DO_NOTHING, on_update=True, related_name='+', to=settings.AUTH_USER_MODEL)),
            ],
            options={
                'verbose_name': 'historical credito_archivo',
                'ordering': ('-history_date', '-history_id'),
                'get_latest_by': 'history_date',
            },
            bases=(simple_history.models.HistoricalChanges, models.Model),
        ),
        migrations.CreateModel(
            name='Historicalcredito',
            fields=[
                ('id', models.BigIntegerField(auto_created=True, blank=True, db_index=True, verbose_name='ID')),
                ('codigo', models.CharField(blank=True, max_length=10, null=True)),
                ('montootorgado', models.DecimalField(decimal_places=2, max_digits=10)),
                ('fechaini', models.DateField(help_text='Fecha de Inicio: YYYY-mm-dd')),
                ('fechaven', models.DateField(help_text='Fecha de Vencimiento: YYYY-mm-dd')),
                ('interespct', models.DecimalField(decimal_places=3, max_digits=6)),
                ('qtydiascuota', models.DecimalField(decimal_places=2, max_digits=10)),
                ('capitalcuota', models.DecimalField(decimal_places=2, max_digits=10)),
                ('interescuota', models.DecimalField(decimal_places=2, max_digits=10)),
                ('totalcuota', models.DecimalField(decimal_places=2, max_digits=10)),
                ('interestotal', models.DecimalField(decimal_places=2, max_digits=10)),
                ('montoyinterestotal', models.DecimalField(decimal_places=2, max_digits=10)),
                ('cuotaspagadas', models.DecimalField(decimal_places=2, max_digits=10)),
                ('cuotaspendientes', models.DecimalField(decimal_places=2, max_digits=10)),
                ('saldopendiente', models.DecimalField(decimal_places=2, max_digits=10)),
                ('tipocredito', models.PositiveIntegerField(choices=[(0, 'CRÉDITO'), (1, 'REFINANC')], help_text='Seleccione el Tipo de Crédito')),
                ('estadocredito', models.PositiveIntegerField(choices=[(0, 'VIGENTE'), (2, 'CANCELADO')], help_text='Seleccione el Estado del Crédito')),
                ('estadoregistro', models.PositiveIntegerField(choices=[(0, 'INGRESADO'), (1, 'CONCILIADO')], default=0, help_text='Seleccione el Estado del Registro')),
                ('nm_estado', models.IntegerField(choices=[(-1, 'INACTIVE'), (1, 'ACTIVE')], default=1, help_text='Activo o Inactivo el Registro')),
                ('date_creation', models.DateTimeField(default=datetime.datetime.now)),
                ('history_id', models.AutoField(primary_key=True, serialize=False)),
                ('history_date', models.DateTimeField()),
                ('history_change_reason', models.CharField(max_length=100, null=True)),
                ('history_type', models.CharField(choices=[('+', 'Created'), ('~', 'Changed'), ('-', 'Deleted')], max_length=1)),
                ('cliente', models.ForeignKey(blank=True, db_constraint=False, null=True, on_delete=django.db.models.deletion.DO_NOTHING, related_name='+', to='cobrox.cliente')),
                ('history_user', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, related_name='+', to=settings.AUTH_USER_MODEL)),
                ('user_creation', django_currentuser.db.models.fields.CurrentUserField(blank=True, db_constraint=False, default=django_currentuser.middleware.get_current_authenticated_user, null=True, on_delete=django.db.models.deletion.DO_NOTHING, related_name='+', to=settings.AUTH_USER_MODEL)),
                ('user_last_update', django_currentuser.db.models.fields.CurrentUserField(db_constraint=False, default=django_currentuser.middleware.get_current_authenticated_user, null=True, on_delete=django.db.models.deletion.DO_NOTHING, on_update=True, related_name='+', to=settings.AUTH_USER_MODEL)),
            ],
            options={
                'verbose_name': 'historical credito',
                'ordering': ('-history_date', '-history_id'),
                'get_latest_by': 'history_date',
            },
            bases=(simple_history.models.HistoricalChanges, models.Model),
        ),
        migrations.CreateModel(
            name='Historicalcliente_archivo',
            fields=[
                ('id', models.BigIntegerField(auto_created=True, blank=True, db_index=True, verbose_name='ID')),
                ('archivo', models.TextField(max_length=100)),
                ('nombre', models.CharField(help_text='Descripcion del nombre del archivo', max_length=400)),
                ('fecha', models.DateTimeField(blank=True, editable=False)),
                ('date_creation', models.DateTimeField(default=datetime.datetime.now)),
                ('history_id', models.AutoField(primary_key=True, serialize=False)),
                ('history_date', models.DateTimeField()),
                ('history_change_reason', models.CharField(max_length=100, null=True)),
                ('history_type', models.CharField(choices=[('+', 'Created'), ('~', 'Changed'), ('-', 'Deleted')], max_length=1)),
                ('cliente', models.ForeignKey(blank=True, db_constraint=False, null=True, on_delete=django.db.models.deletion.DO_NOTHING, related_name='+', to='cobrox.cliente')),
                ('history_user', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, related_name='+', to=settings.AUTH_USER_MODEL)),
                ('user_creation', django_currentuser.db.models.fields.CurrentUserField(blank=True, db_constraint=False, default=django_currentuser.middleware.get_current_authenticated_user, null=True, on_delete=django.db.models.deletion.DO_NOTHING, related_name='+', to=settings.AUTH_USER_MODEL)),
                ('user_last_update', django_currentuser.db.models.fields.CurrentUserField(db_constraint=False, default=django_currentuser.middleware.get_current_authenticated_user, null=True, on_delete=django.db.models.deletion.DO_NOTHING, on_update=True, related_name='+', to=settings.AUTH_USER_MODEL)),
            ],
            options={
                'verbose_name': 'historical cliente_archivo',
                'ordering': ('-history_date', '-history_id'),
                'get_latest_by': 'history_date',
            },
            bases=(simple_history.models.HistoricalChanges, models.Model),
        ),
        migrations.CreateModel(
            name='Historicalcliente',
            fields=[
                ('id', models.BigIntegerField(auto_created=True, blank=True, db_index=True, verbose_name='ID')),
                ('codigo', models.CharField(blank=True, max_length=10, null=True)),
                ('nombre', models.CharField(max_length=200)),
                ('dui', models.CharField(max_length=15)),
                ('nit', models.CharField(max_length=25)),
                ('direccion', models.TextField()),
                ('telefono', models.CharField(max_length=25)),
                ('celular', models.CharField(blank=True, max_length=25, null=True)),
                ('observacion', models.TextField(blank=True, null=True)),
                ('date_creation', models.DateTimeField(default=datetime.datetime.now)),
                ('history_id', models.AutoField(primary_key=True, serialize=False)),
                ('history_date', models.DateTimeField()),
                ('history_change_reason', models.CharField(max_length=100, null=True)),
                ('history_type', models.CharField(choices=[('+', 'Created'), ('~', 'Changed'), ('-', 'Deleted')], max_length=1)),
                ('history_user', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, related_name='+', to=settings.AUTH_USER_MODEL)),
                ('tipo_cliente', models.ForeignKey(blank=True, db_constraint=False, null=True, on_delete=django.db.models.deletion.DO_NOTHING, related_name='+', to='cobrox.tipo_cliente')),
                ('user_creation', django_currentuser.db.models.fields.CurrentUserField(blank=True, db_constraint=False, default=django_currentuser.middleware.get_current_authenticated_user, null=True, on_delete=django.db.models.deletion.DO_NOTHING, related_name='+', to=settings.AUTH_USER_MODEL)),
                ('user_last_update', django_currentuser.db.models.fields.CurrentUserField(db_constraint=False, default=django_currentuser.middleware.get_current_authenticated_user, null=True, on_delete=django.db.models.deletion.DO_NOTHING, on_update=True, related_name='+', to=settings.AUTH_USER_MODEL)),
                ('zona', models.ForeignKey(blank=True, db_constraint=False, null=True, on_delete=django.db.models.deletion.DO_NOTHING, related_name='+', to='cobrox.zona')),
            ],
            options={
                'verbose_name': 'historical cliente',
                'ordering': ('-history_date', '-history_id'),
                'get_latest_by': 'history_date',
            },
            bases=(simple_history.models.HistoricalChanges, models.Model),
        ),
    ]
