from django.urls import path, include
from . import views


urlpatterns = [
    path('', views.index, name='index'),
    path('login', views.loginCliente, name='login'),
    path('logout', views.logoutCliente, name='logout'),
    path('sucursal/<int:sucursal_id>/menu/<slug:parte_menu>', views.sucursal, name='sucursal'),
    path('sucursal/<int:sucursal_id>/pedidos', views.sucursal_pedidos, name='sucursal_pedidos'),
    path('pedido/<int:numpedido>/entregado', views.pedido_entregado, name='pedido_entregado'),
    path('sucursal/<int:sucursal_id>/pedido/agregar/<int:idproducto>/<str:parte_menu>', views.agregar_producto, name='agregar_producto'),
    path('canasta', views.canasta, name='canasta'),
    path('pedido/preparado', views.pedido_preparado, name='pedido_preparado'),
]
