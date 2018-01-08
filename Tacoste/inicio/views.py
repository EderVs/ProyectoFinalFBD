# -*- coding: utf-8 -*-
""" Vistas de inicio """
from django.shortcuts import render, get_object_or_404
from django.http import HttpResponse

from . import utils
from .models import Sucursal, Producto

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
