# -*- coding: utf-8 -*-
""" Vistas de inicio """
from django.shortcuts import render, get_object_or_404, redirect
from django.http import HttpResponse
from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.models import User

from . import utils
from .models import Sucursal, Producto, Pedido, Contener

NOMBRE_APP = "inicio"


def index(request):
    sucursales = Sucursal.objects.all()
    for sucursal in sucursales:
        telefonos = sucursal.obtener_telefonos()
        if telefonos.exists():
            sucursal.telefono = telefonos[0]

    template = NOMBRE_APP + "/index.html"
    context = {
        'sucursales': sucursales,
    }
    return render(request, template, context)


def sucursal(request, sucursal_id, parte_menu):
    sucursal = get_object_or_404(Sucursal, pk=sucursal_id)
    telefonos = sucursal.obtener_telefonos()
    if telefonos.exists():
        sucursal.telefono = telefonos[0]

    # Obtener los productos de la parte de menu
    productos = Producto.objects.filter(
        taquegoria=utils.slug_to_str(parte_menu).title()
    )

    template = NOMBRE_APP + "/sucursal.html"
    context = {
        'sucursal': sucursal,
        'parte_menu': parte_menu,
        'parte_menu_titulo': utils.slug_to_str(parte_menu).title(),
        'productos': productos,
    }
    return render(request, template, context)


def loginCliente(request):
    if request.POST:
        email = request.POST.get('email', '')
        password = request.POST.get('password', '')
        if email != '' and password != '':
            users = User.objects.filter(email=email)
            if users.exists():
                user = authenticate(username=users[0].username, password=password)
                if user is not None:
                    login(request, user)
                    return redirect('index')

    template = NOMBRE_APP + "/login.html"
    return render(request, template)


def logoutCliente(request):
    logout(request)
    return redirect('index')

def sucursal_pedidos(request, sucursal_id):
    sucursal = get_object_or_404(Sucursal, pk=sucursal_id)
    pedidos = Pedido.objects.filter(
        idsucursal=sucursal.idsucursal, preparado=True, entregado=False
    )
    pedidos_format = []
    for pedido in pedidos:
        pedido_format = {}
        conteners = Contener.objects.filter(numpedido=pedido.numpedido)
        productos = []
        for contener in conteners:
            producto_actual = {}
            producto_actual['producto'] = contener.idproducto
            producto_actual['cantidad'] = contener.cantidad
            productos.append(producto_actual)
        pedido_format['pedido'] = pedido
        pedido_format['productos'] = productos
        pedidos_format.append(pedido_format)

    template = NOMBRE_APP + "/pedidos_sucursal.html"
    context = {
        'pedidos': pedidos_format,
    }
    return render(request, template, context)


def pedido_entregado(request, numpedido):
    pedido = get_object_or_404(Pedido, numpedido=numpedido)
    pedido.entregado = True
    pedido.save()
    return redirect('sucursal_pedidos', pedido.idsucursal.idsucursal)
