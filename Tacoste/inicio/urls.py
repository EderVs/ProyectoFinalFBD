from django.urls import path, include
from . import views


urlpatterns = [
    path('', views.index, name='index'),
    path('login', views.loginCliente, name='login'),
    path('logout', views.logoutCliente, name='logout'),
    path('sucursal/<int:sucursal_id>/menu/<slug:parte_menu>', views.sucursal, name='sucursal'),
]
