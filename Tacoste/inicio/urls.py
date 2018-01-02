from django.urls import path, include
from . import views


urlpatterns = [
    path('', views.index, name='index'),
    path('sucursal/menu/<slug:parte_menu>', views.sucursal, name='sucursal'),
]
