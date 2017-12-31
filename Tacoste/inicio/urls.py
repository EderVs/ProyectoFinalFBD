from django.urls import path, include
from . import views


urlpatterns = [
    path('', views.index, name='index'),
    path('sucursal', views.sucursal, name='sucursal'),
]
