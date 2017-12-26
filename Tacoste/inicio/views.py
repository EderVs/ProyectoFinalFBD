# -*- coding: utf-8 -*-
""" Vistas de inicio """
from django.shortcuts import render
from django.http import HttpResponse


def index(request):
    return HttpResponse("Aqui es donde estará la página de inicio")
