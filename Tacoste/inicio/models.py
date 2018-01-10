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
    email = models.CharField(unique=True, max_length=50, blank=True, null=True)
    telefono = models.CharField(max_length=20, blank=True, null=True)
    nombre = models.CharField(max_length=50, blank=True, null=True)
    apellidopaterno = models.CharField(max_length=50, blank=True, null=True)
    apellidomaterno = models.CharField(max_length=50, blank=True, null=True)
    municipio = models.CharField(max_length=100, blank=True, null=True)
    colonia = models.CharField(max_length=100, blank=True, null=True)
    calle = models.CharField(max_length=100, blank=True, null=True)
    cp = models.ForeignKey('Cpedosucursal', models.DO_NOTHING, db_column='cp', null=True)
    numinterior = models.BigIntegerField(blank=True, null=True)
    numexterior = models.BigIntegerField(blank=True, null=True)
    fechaprimervista = models.DateField(blank=True, null=True)
    numpuntos = models.BigIntegerField(blank=True, null=True)
    user = models.OneToOneField(
        User,
        on_delete=models.CASCADE,
        null=True,
    )

    class Meta:
        managed = True
        db_table = 'cliente'

    def __str__(self):
        return self.nombre + ' ' + self.apellidopaterno


class Sucursal(models.Model):
    idsucursal = models.BigIntegerField(primary_key=True)
    horaapertura = models.DateTimeField(blank=True, null=True)
    horacierre = models.DateTimeField(blank=True, null=True)
    municipio = models.CharField(max_length=100, blank=True, null=True)
    colonia = models.CharField(max_length=100, blank=True, null=True)
    calle = models.CharField(max_length=100, blank=True, null=True)
    cp = models.ForeignKey('Cpedosucursal', models.DO_NOTHING, db_column='cp', null=True)
    numinterior = models.BigIntegerField(blank=True, null=True)
    numexterior = models.BigIntegerField(blank=True, null=True)

    class Meta:
        managed = True
        db_table = 'sucursal'

    def __str__(self):
        return self.calle + ' #' + str(self.numexterior) + ', ' + self.colonia

    def obtener_telefonos(self):
        return Sucursaltelefono.objects.filter(idsucursal=self.idsucursal)


class Cpedosucursal(models.Model):
    cp = models.IntegerField(primary_key=True)
    estado = models.CharField(max_length=100, blank=True, null=True)

    class Meta:
        managed = True
        db_table = 'cpedosucursal'

    def __str__(self):
        return str(self.cp)


class Sucursaltelefono(models.Model):
    idsucursal = models.ForeignKey(Sucursal, models.DO_NOTHING, db_column='idsucursal', primary_key=True)
    telefono = models.CharField(max_length=20)

    class Meta:
        managed = True
        db_table = 'sucursaltelefono'
        unique_together = (('idsucursal', 'telefono'),)

    def __str__(self):
        return str(self.idsucursal) + " " + str(self.telefono)


class Producto(models.Model):
    idproducto = models.BigIntegerField(primary_key=True)
    puntosotorgar = models.BigIntegerField(blank=True, null=True)
    nombre = models.CharField(max_length=70, blank=True, null=True)
    precio = models.FloatField(blank=True, null=True)
    taquegoria = models.CharField(max_length=50, blank=True, null=True)

    class Meta:
        managed = True
        db_table = 'producto'

    def __str__(self):
        return self.nombre


class Productoleyenda(models.Model):
    idproducto = models.ForeignKey(Producto, models.DO_NOTHING, db_column='idproducto')
    leyenda = models.CharField(max_length=50, blank=True, null=True)

    class Meta:
        managed = True
        db_table = 'productoleyenda'

    def __str__(self):
        return str(self.idproducto) + " " + str(self.leyenda)


class Pedido(models.Model):
    numpedido = models.BigIntegerField(primary_key=True)
    idsucursal = models.ForeignKey('Sucursal', models.DO_NOTHING, db_column='idsucursal')
    fechapedido = models.DateField()
    taquiclave = models.ForeignKey(Cliente, models.DO_NOTHING, db_column='taquiclave')
    metodopago = models.CharField(max_length=50)
    preparado = models.BooleanField(default=False)
    entregado = models.BooleanField(default=False)

    class Meta:
        managed = True
        db_table = 'pedido'

    def __str__(self):
        return str(self.numpedido) + " | " + str(self.idsucursal) + " | " + str(self.taquiclave)


class Contener(models.Model):
    idContener = models.BigIntegerField(primary_key=True)
    numpedido = models.ForeignKey('Pedido', models.DO_NOTHING, db_column='numpedido')
    idproducto = models.ForeignKey('Producto', models.DO_NOTHING, db_column='idproducto')
    cantidad = models.BigIntegerField()

    class Meta:
        managed = True
        db_table = 'contener'
        unique_together = (('numpedido', 'idproducto'),)

    def __str__(self):
        return str(self.numpedido) + " | " + str(self.idproducto)
