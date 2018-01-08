# -*- coding: utf-8 -*-
""" Vistas de inicio """
from django.shortcuts import render
from django.http import HttpResponse

from . import utils
from .models import Sucursal

NOMBRE_APP = "inicio"

def index(request):
    sucursales = Sucursal.objects.all()
    template = NOMBRE_APP + "/index.html"
    context = {
        'sucursales': sucursales,
    }
    return render(request, template, context)

def sucursal(request, parte_menu):
    template = NOMBRE_APP + "/sucursal.html"
    context = {
        'parte_menu': parte_menu,
        'parte_menu_titulo': utils.slug_to_str(parte_menu).title(),
    }
    return render(request, template, context)
