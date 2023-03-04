from django.urls import path
from . import views
from django.conf import settings
from django.conf.urls.static import static
from django.views.generic import TemplateView

app_name = 'cobrox'
urlpatterns = [
    path('',
         views.Viewindex.as_view(),
         name='index2'
    ),
    path('index.html',
         views.Viewindex.as_view(),
         name='index'
        ),
    path('filial',
       views.FilialList.as_view(),
       name='FilialList'
       ),
    path('filialAdd',
       views.FilialAdd.as_view(),
       name='FilialAdd'
       ),
    path('filialUpdate/<int:pk>',
       views.FilialUpdate.as_view(),
       name='FilialUpdate'
       ),
    path('FilialDelete/<int:pk>',
       views.FilialDelete.as_view(),
       name='FilialDelete'
       ),
    path('zona',
       views.ZonaList.as_view(),
       name='ZonaList'
       ),
    path('zonaAdd',
       views.ZonaAdd.as_view(),
       name='ZonaAdd'
       ),
    path('zonaUpdate/<int:pk>',
       views.ZonaUpdate.as_view(),
       name='ZonaUpdate'
       ),
    path('zonaDelete/<int:pk>',
       views.ZonaDelete.as_view(),
       name='ZonaDelete'
       ),
    path('tipocliente',
       views.TipoclienteList.as_view(),
       name='TipoclienteList'
       ),
    path('tipoclienteAdd',
       views.TipoclienteAdd.as_view(),
       name='TipoclienteAdd'
       ),
    path('tipoclienteUpdate/<int:pk>',
       views.TipoclienteUpdate.as_view(),
       name='TipoclienteUpdate'
       ),
    path('tipoclienteDelete/<int:pk>',
       views.TipoclienteDelete.as_view(),
       name='TipoclienteDelete'
       ),
    path('cliente',
       views.ClienteList.as_view(),
       name='ClienteList'
       ),
    path('clientelAdd',
       views.ClienteAdd.as_view(),
       name='ClienteAdd'
       ),
    path('clienteUpdate/<int:pk>',
       views.ClienteUpdate.as_view(),
       name='ClienteUpdate'
       ),
    path('ClienteDelete/<int:pk>',
       views.ClienteDelete.as_view(),
       name='ClienteDelete'
       ),
    path('Credito_clientelist/<int:pk>',
       views.Credito_clientelist.as_view(),
       name='Credito_clientelist'
       ),
    path('CreditoAdd/<int:pk>',
       views.CreditoAdd.as_view(),
       name='CreditoAdd'
       ),
    path('CreditoDelete/<int:pk>',
       views.CreditoDelete.as_view(),
       name='CreditoDelete'
       ),
    path('PagoAdd/<int:pk>',
       views.PagoAdd.as_view(),
       name='PagoAdd'
       ),
    path('PagoDelete/<int:pk>',
       views.PagoDelete.as_view(),
       name='PagoDelete'
       ),
    path('ajax/load-calculo_pago/', views.load_calculo_pago, name='ajax_load_calculo_pago'),
    path('ajax/load-calculo_distribucion_pago/', views.load_calculo_distribucion_pago, name='ajax_load_calculo_distribucion_pago'),
    ] + static(settings.MEDIA_URL)
