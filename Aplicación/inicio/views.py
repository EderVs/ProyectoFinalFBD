# -*- coding: utf-8 -*-
""" Vistas de inicio """
import random

from django.shortcuts import render, get_object_or_404, redirect
from django.http import HttpResponse
from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.models import User

from . import utils
from .models import Sucursal, Producto, Pedido, ContenerDjango, Categoria, Cliente, Fechapedpromo

NOMBRE_APP = "inicio"


def index(request):
    sucursales = Sucursal.objects.all()
    for sucursal in sucursales:
        telefonos = sucursal.obtener_telefonos()
        if telefonos.exists():
            sucursal.telefono = telefonos[0]

    if(request.user.id != None):
        cliente = Cliente.objects.get(user = request.user)
        pedidos = Pedido.objects.filter(
            taquiclave=cliente.taquiclave, preparado=False, entregado=False
        )
        hay_pedido = pedidos.exists()
    else:
        hay_pedido = False

    template = NOMBRE_APP + "/index.html"
    context = {
        'sucursales': sucursales,
        'hay_pedido': hay_pedido,
    }
    return render(request, template, context)


def sucursal(request, sucursal_id, parte_menu):
    sucursal = get_object_or_404(Sucursal, pk=sucursal_id)
    telefonos = sucursal.obtener_telefonos()
    if telefonos.exists():
        sucursal.telefono = telefonos[0]
    
    if parte_menu == 'gringas-quecas-y-volcanes':
        parte_menu = 'gringas,-quecas-y-volcanes'
    # Obtener los productos de la parte de menu
    categorias = Categoria.objects.filter(
        taquegoria=utils.slug_to_str(parte_menu).upper()
    )
    
    productos = []
    for categoria in categorias:
        categoria.idproducto.descripcion = random.choice([
            'Bueno',
            'Riquísimo',
            'Te arrepentirás si no lo pruebas',
            'Caído del cielo',
            'Para compartir',
            'De lo más pedido',
            'De lo más recomendado',
            'Para los peques'
        ])
        productos.append(categoria.idproducto)

    if parte_menu == 'gringas,-quecas-y-volcanes':
        parte_menu = 'gringas-quecas-y-volcanes'


    if(request.user.id != None):
        cliente = Cliente.objects.get(user = request.user)
        pedidos = Pedido.objects.filter(
            taquiclave=cliente.taquiclave, preparado=False, entregado=False
        )
        hay_pedido = pedidos.exists()
    else:
        hay_pedido = False

    template = NOMBRE_APP + "/sucursal.html"
    context = {
        'sucursal': sucursal,
        'parte_menu': parte_menu,
        'parte_menu_titulo': utils.slug_to_str(parte_menu).title(),
        'productos': productos,
        'hay_pedido': hay_pedido,
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
        conteners = ContenerDjango.objects.filter(numpedido=pedido.numpedido)
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


def agregar_producto(request, sucursal_id, idproducto, parte_menu):
    producto = get_object_or_404(Producto, idproducto=idproducto)
    cliente = Cliente.objects.get(user = request.user)
    pedidos = Pedido.objects.filter(
        taquiclave=cliente.taquiclave, preparado=False, entregado=False
    )
    sucursal = get_object_or_404(Sucursal, idsucursal=sucursal_id)
    # Se tiene que crear una Fechapedpromo con la promo NINGUNA
    fechapedpromo = Fechapedpromo.objects.filter(promocion='NINGUNA').first()
    ultimo_pedido = Pedido.objects.all().order_by('numpedido').last()
    if not pedidos.exists():
        if ultimo_pedido == None:
            ultimo_pedido_id = 0
        else:
            ultimo_pedido_id = ultimo_pedido.numpedido

        pedido = Pedido(
            numpedido=ultimo_pedido_id+1, 
            idsucursal=sucursal,
            fechapedido=fechapedpromo,
            taquiclave=cliente,
            metodopago='EFECTIVO',
            preparado=False,
            entregado=False
        )
        pedido.save()
    else:
        pedido = pedidos.first()

    conteners_all = ContenerDjango.objects.all().order_by('idcontener')
    if conteners_all.exists():
        ultimo_idcontener = conteners_all.last().idcontener
    else:
        ultimo_idcontener = 0

    conteners = ContenerDjango.objects.filter(numpedido=pedido, idproducto=producto)
    if conteners.exists():
        contener = conteners.first()
        contener.cantidad = contener.cantidad + 1
    else:
        contener = ContenerDjango(numpedido=pedido, idproducto=producto, cantidad=1, idcontener=ultimo_idcontener+1)
 
    contener.save()

    return redirect('sucursal', sucursal_id, parte_menu)


def canasta(request):
    cliente = Cliente.objects.get(user = request.user)
    pedidos = Pedido.objects.filter(
        taquiclave=cliente.taquiclave, preparado=False, entregado=False
    )
    productos = []
    if pedidos.exists():
        pedido = pedidos.first()
        conteners = ContenerDjango.objects.filter(numpedido=pedido.numpedido)
        for contener in conteners:
            producto_actual = {}
            producto_actual['producto'] = contener.idproducto
            producto_actual['cantidad'] = contener.cantidad
            productos.append(producto_actual)

    template = NOMBRE_APP + "/canasta.html"
    context = {
        'productos': productos,
    }
    return render(request, template, context)


def pedido_preparado(request):
    cliente = Cliente.objects.get(user = request.user)
    pedido = get_object_or_404(Pedido, taquiclave=cliente.taquiclave, preparado=False, entregado=False)
    pedido.preparado = True
    pedido.save()
    return redirect('index')
