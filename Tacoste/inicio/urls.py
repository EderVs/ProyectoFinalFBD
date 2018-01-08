from django.urls import path, include
from . import views


urlpatterns = [
    path('', views.index, name='index'),
    path('sucursal/<int:sucursal_id>/menu/<slug:parte_menu>', views.sucursal, name='sucursal'),
]
