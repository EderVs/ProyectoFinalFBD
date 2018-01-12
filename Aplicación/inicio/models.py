# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Make sure each ForeignKey has `on_delete` set to the desired behavior.
#   * Remove `managed = True` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.
from django.db import models
from django.contrib.auth.models import User

class Cliente(models.Model):
    taquiclave = models.BigIntegerField(primary_key=True)
    email = models.CharField(unique=True, max_length=50)
    telefono = models.CharField(max_length=20)
    nombre = models.CharField(max_length=50)
    apellidopaterno = models.CharField(max_length=50)
    apellidomaterno = models.CharField(max_length=50)
    municipio = models.CharField(max_length=100)
    colonia = models.CharField(max_length=100)
    calle = models.CharField(max_length=100)
    cp = models.ForeignKey('Cpedocliente', models.DO_NOTHING, db_column='cp')
    numinterior = models.BigIntegerField()
    numexterior = models.BigIntegerField()
    fechaprimervista = models.DateField()
    numpuntos = models.BigIntegerField()
    user = models.OneToOneField(#
        User,#
        on_delete=models.CASCADE,#
        null=True,#
        default= None
    )#

    class Meta:
        managed = True#True
        db_table = 'cliente'

    def __str__(self):
        return self.nombre + ' ' + self.apellidopaterno


class Cpedocliente(models.Model):
    cp = models.IntegerField(primary_key=True)
    estado = models.CharField(max_length=100)

    class Meta:
        managed = False
        db_table = 'cpedocliente'

    def __str__(self):
        return str(self.cp)


class Sucursal(models.Model):
    idsucursal = models.BigIntegerField(primary_key=True)
    horaapertura = models.DateTimeField()
    horacierre = models.DateTimeField()
    municipio = models.CharField(max_length=100)
    colonia = models.CharField(max_length=100)
    calle = models.CharField(max_length=100)
    cp = models.ForeignKey('Cpedosucursal', models.DO_NOTHING, db_column='cp')
    numinterior = models.BigIntegerField()
    numexterior = models.BigIntegerField()

    class Meta:
        managed = False
        db_table = 'sucursal'

    def __str__(self):
        return self.calle + ' #' + str(self.numexterior) + ', ' + self.colonia

    def obtener_telefonos(self):
        return Sucursaltelefono.objects.filter(idsucursal=self.idsucursal)


class Cpedosucursal(models.Model):
    cp = models.IntegerField(primary_key=True)
    estado = models.CharField(max_length=100, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'cpedosucursal'

    def __str__(self):
        return str(self.cp)


class Sucursaltelefono(models.Model):
    idsucursal = models.ForeignKey(Sucursal, models.DO_NOTHING, db_column='idsucursal', primary_key=True)
    telefono = models.CharField(max_length=20)

    class Meta:
        managed = False
        db_table = 'sucursaltelefono'

    def __str__(self):
        return str(self.idsucursal) + " " + str(self.telefono)


class Producto(models.Model):
    idproducto = models.BigIntegerField(primary_key=True)
    nombre = models.CharField(unique=True, max_length=200)
    precio = models.FloatField()
    descripcion = models.CharField(max_length=200)

    class Meta:
        managed = False
        db_table = 'producto'

    def __str__(self):
        return self.nombre


class Productoleyenda(models.Model):
    idproducto = models.ForeignKey(Producto, models.DO_NOTHING, db_column='idproducto', primary_key=True)
    leyenda = models.CharField(max_length=50)

    class Meta:
        managed = False
        db_table = 'productoleyenda'
        unique_together = (('idproducto', 'leyenda'),)

    def __str__(self):
        return str(self.idproducto) + " " + str(self.leyenda)


class Categoria(models.Model):
    idproducto = models.ForeignKey('Producto', models.DO_NOTHING, db_column='idproducto', primary_key=True)
    taquegoria = models.CharField(max_length=200)

    class Meta:
        managed = False
        db_table = 'categoria'

    def __str__(self):
        return str(self.idproducto) + " " + str(self.taquegoria)


class Fechapedpromo(models.Model):
    fechapedido = models.DateField(primary_key=True)
    promocion = models.CharField(max_length=50)

    class Meta:
        managed = False
        db_table = 'fechapedpromo'


class Pedido(models.Model):
    numpedido = models.BigIntegerField(primary_key=True)
    idsucursal = models.ForeignKey('Sucursal', models.DO_NOTHING, db_column='idsucursal')
    fechapedido = models.ForeignKey(Fechapedpromo, models.DO_NOTHING, db_column='fechapedido')
    taquiclave = models.ForeignKey(Cliente, models.DO_NOTHING, db_column='taquiclave')
    metodopago = models.CharField(max_length=50)
    preparado = models.BooleanField()
    entregado = models.BooleanField()

    class Meta:
        managed = False
        db_table = 'pedido'

    def __str__(self):
        return str(self.numpedido) + " | " + str(self.idsucursal) + " | " + str(self.taquiclave)


class ContenerDjango(models.Model):
    numpedido = models.ForeignKey('Pedido', models.DO_NOTHING, db_column='numpedido', blank=True, null=True)
    idproducto = models.ForeignKey('Producto', models.DO_NOTHING, db_column='idproducto', blank=True, null=True)
    cantidad = models.BigIntegerField(blank=True, null=True)
    idcontener = models.BigIntegerField(primary_key=True)

    class Meta:
        managed = False
        db_table = 'contener_django'

    def __str__(self):
        return str(self.numpedido) + " | " + str(self.idproducto)
