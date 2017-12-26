# -*- coding: utf-8 -*-
""" Vistas de inicio """
from django.shortcuts import render
from django.http import HttpResponse

NOMBRE_APP = "inicio"

def index(request):
    template = NOMBRE_APP + "/index.html"
    return render(request, template)
