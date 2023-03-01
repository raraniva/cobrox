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
    ] + static(settings.MEDIA_URL)
