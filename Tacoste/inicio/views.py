# -*- coding: utf-8 -*-
""" Vistas de inicio """
from django.shortcuts import render
from django.http import HttpResponse

from . import utils

NOMBRE_APP = "inicio"

def index(request):
    template = NOMBRE_APP + "/index.html"
    return render(request, template)

def sucursal(request, parte_menu):
    template = NOMBRE_APP + "/sucursal.html"
    context = {
        'parte_menu': parte_menu,
        'parte_menu_titulo': utils.slug_to_str(parte_menu).title(),
    }
    return render(request, template, context)
