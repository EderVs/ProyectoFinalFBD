# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Make sure each ForeignKey has `on_delete` set to the desired behavior.
#   * Remove `managed = False` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.
from django.db import models


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
