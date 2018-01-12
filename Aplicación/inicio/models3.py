# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Make sure each ForeignKey has `on_delete` set to the desired behavior.
#   * Remove `managed = False` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.
from django.db import models


class Categoria(models.Model):
    idproducto = models.ForeignKey('Producto', models.DO_NOTHING, db_column='idproducto', primary_key=True)
    taquegoria = models.CharField(max_length=200)

    class Meta:
        managed = False
        db_table = 'categoria'


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

    class Meta:
        managed = False
        db_table = 'cliente'


class Conservar(models.Model):
    idproducto = models.ForeignKey('Producto', models.DO_NOTHING, db_column='idproducto', primary_key=True)
    idhistorico = models.ForeignKey('Historico', models.DO_NOTHING, db_column='idhistorico')

    class Meta:
        managed = False
        db_table = 'conservar'
        unique_together = (('idproducto', 'idhistorico'),)


class Contener(models.Model):
    numpedido = models.ForeignKey('Pedido', models.DO_NOTHING, db_column='numpedido', primary_key=True)
    idproducto = models.ForeignKey('Producto', models.DO_NOTHING, db_column='idproducto')
    cantidad = models.BigIntegerField()

    class Meta:
        managed = False
        db_table = 'contener'
        unique_together = (('numpedido', 'idproducto', 'cantidad'),)


class ContenerDjango(models.Model):
    numpedido = models.ForeignKey('Pedido', models.DO_NOTHING, db_column='numpedido', blank=True, null=True)
    idproducto = models.ForeignKey('Producto', models.DO_NOTHING, db_column='idproducto', blank=True, null=True)
    cantidad = models.BigIntegerField(blank=True, null=True)
    idcontener = models.BigIntegerField(primary_key=True)

    class Meta:
        managed = False
        db_table = 'contener_django'


class Cpedocliente(models.Model):
    cp = models.IntegerField(primary_key=True)
    estado = models.CharField(max_length=100)

    class Meta:
        managed = False
        db_table = 'cpedocliente'


class Cpedoempleado(models.Model):
    cp = models.IntegerField(primary_key=True)
    estado = models.CharField(max_length=100)

    class Meta:
        managed = False
        db_table = 'cpedoempleado'


class Cpedoproveedor(models.Model):
    cp = models.IntegerField(primary_key=True)
    estado = models.CharField(max_length=100)

    class Meta:
        managed = False
        db_table = 'cpedoproveedor'


class Cpedosucursal(models.Model):
    cp = models.IntegerField(primary_key=True)
    estado = models.CharField(max_length=100)

    class Meta:
        managed = False
        db_table = 'cpedosucursal'


class Curpfnacemp(models.Model):
    curp = models.CharField(primary_key=True, max_length=18)
    fechanac = models.DateField()

    class Meta:
        managed = False
        db_table = 'curpfnacemp'


class Dirigir(models.Model):
    idsucursal = models.ForeignKey('Sucursal', models.DO_NOTHING, db_column='idsucursal', primary_key=True)
    taquiclave = models.ForeignKey('Empleado', models.DO_NOTHING, db_column='taquiclave')
    fechainicio = models.DateField()

    class Meta:
        managed = False
        db_table = 'dirigir'
        unique_together = (('idsucursal', 'taquiclave'),)


class Empleado(models.Model):
    taquiclave = models.BigIntegerField(primary_key=True)
    idsucursal = models.ForeignKey('Sucursal', models.DO_NOTHING, db_column='idsucursal')
    salario = models.FloatField()
    email = models.CharField(unique=True, max_length=50)
    telefono = models.CharField(max_length=20)
    nombre = models.CharField(max_length=50)
    apellidopaterno = models.CharField(max_length=50)
    apellidomaterno = models.CharField(max_length=50)
    municipio = models.CharField(max_length=100)
    colonia = models.CharField(max_length=100)
    calle = models.CharField(max_length=100)
    cp = models.ForeignKey(Cpedoempleado, models.DO_NOTHING, db_column='cp')
    numinterior = models.BigIntegerField()
    numexterior = models.BigIntegerField()
    curp = models.ForeignKey(Curpfnacemp, models.DO_NOTHING, db_column='curp')
    rfc = models.CharField(max_length=13)
    tipo = models.CharField(max_length=40)
    tiposangre = models.CharField(max_length=5)
    numemergencia = models.CharField(max_length=20)
    fechacontratacion = models.DateField()

    class Meta:
        managed = False
        db_table = 'empleado'


class Fechapedpromo(models.Model):
    fechapedido = models.DateField(primary_key=True)
    promocion = models.CharField(max_length=50)

    class Meta:
        managed = False
        db_table = 'fechapedpromo'


class Historico(models.Model):
    idhistorico = models.BigIntegerField(primary_key=True)
    idproducto = models.ForeignKey('Producto', models.DO_NOTHING, db_column='idproducto')
    fechaactualizacion = models.DateField()
    precioprevio = models.FloatField()
    precionuevo = models.FloatField()

    class Meta:
        managed = False
        db_table = 'historico'


class Ingrediente(models.Model):
    idingrediente = models.BigIntegerField(primary_key=True)
    nombre = models.CharField(max_length=50)
    marca = models.CharField(max_length=60)
    cantidadexistencia = models.FloatField()
    fechacaducidad = models.DateField()

    class Meta:
        managed = False
        db_table = 'ingrediente'


class Licencia(models.Model):
    taquiclave = models.ForeignKey('Tacorider', models.DO_NOTHING, db_column='taquiclave', primary_key=True)
    codigo = models.CharField(max_length=30)

    class Meta:
        managed = False
        db_table = 'licencia'


class Llevar(models.Model):
    taquiclave = models.ForeignKey('Tacorider', models.DO_NOTHING, db_column='taquiclave', primary_key=True)
    numpedido = models.ForeignKey('Pedido', models.DO_NOTHING, db_column='numpedido')

    class Meta:
        managed = False
        db_table = 'llevar'
        unique_together = (('taquiclave', 'numpedido'),)


class Mobiliario(models.Model):
    idmueble = models.BigIntegerField(primary_key=True)
    tipo = models.CharField(max_length=30)

    class Meta:
        managed = False
        db_table = 'mobiliario'


class Pedido(models.Model):
    numpedido = models.BigIntegerField(primary_key=True)
    idsucursal = models.ForeignKey('Sucursal', models.DO_NOTHING, db_column='idsucursal')
    fechapedido = models.DateField()
    taquiclave = models.ForeignKey(Cliente, models.DO_NOTHING, db_column='taquiclave')
    metodopago = models.CharField(max_length=50)
    preparado = models.BooleanField()
    entregado = models.BooleanField()

    class Meta:
        managed = False
        db_table = 'pedido'


class Poseer(models.Model):
    taquiclave = models.ForeignKey('Tacorider', models.DO_NOTHING, db_column='taquiclave', primary_key=True)
    idtransporte = models.ForeignKey('Transporte', models.DO_NOTHING, db_column='idtransporte')

    class Meta:
        managed = False
        db_table = 'poseer'
        unique_together = (('taquiclave', 'idtransporte'),)


class Producto(models.Model):
    idproducto = models.BigIntegerField(primary_key=True)
    nombre = models.CharField(unique=True, max_length=200)
    precio = models.FloatField()
    descripcion = models.CharField(max_length=200)

    class Meta:
        managed = False
        db_table = 'producto'


class Productoleyenda(models.Model):
    idproducto = models.ForeignKey(Producto, models.DO_NOTHING, db_column='idproducto', primary_key=True)
    leyenda = models.CharField(max_length=50)

    class Meta:
        managed = False
        db_table = 'productoleyenda'
        unique_together = (('idproducto', 'leyenda'),)


class Proveedor(models.Model):
    rfc = models.CharField(primary_key=True, max_length=13)
    razonsocial = models.CharField(unique=True, max_length=100)
    iniciorelacion = models.DateField()
    email = models.CharField(unique=True, max_length=50)
    telefono = models.CharField(max_length=20)
    municipio = models.CharField(max_length=100)
    colonia = models.CharField(max_length=100)
    calle = models.CharField(max_length=100)
    cp = models.ForeignKey(Cpedoproveedor, models.DO_NOTHING, db_column='cp')
    numinterior = models.BigIntegerField()
    numexterior = models.BigIntegerField()

    class Meta:
        managed = False
        db_table = 'proveedor'


class Proveering(models.Model):
    rfc = models.ForeignKey(Proveedor, models.DO_NOTHING, db_column='rfc', primary_key=True)
    idingrediente = models.ForeignKey(Ingrediente, models.DO_NOTHING, db_column='idingrediente')
    precio = models.FloatField()

    class Meta:
        managed = False
        db_table = 'proveering'
        unique_together = (('rfc', 'idingrediente'),)


class Proveermob(models.Model):
    rfc = models.ForeignKey(Proveedor, models.DO_NOTHING, db_column='rfc', primary_key=True)
    idmueble = models.ForeignKey(Mobiliario, models.DO_NOTHING, db_column='idmueble')
    precio = models.FloatField()

    class Meta:
        managed = False
        db_table = 'proveermob'
        unique_together = (('rfc', 'idmueble'),)


class Recomendar(models.Model):
    idproducto = models.BigIntegerField()
    idproductosalsa = models.BigIntegerField()

    class Meta:
        managed = False
        db_table = 'recomendar'


class Salsa(models.Model):
    idproducto = models.BigIntegerField()
    presentacion = models.CharField(max_length=70)
    scoville = models.CharField(max_length=20)

    class Meta:
        managed = False
        db_table = 'salsa'


class Sucursal(models.Model):
    idsucursal = models.BigIntegerField(primary_key=True)
    horaapertura = models.DateTimeField()
    horacierre = models.DateTimeField()
    municipio = models.CharField(max_length=100)
    colonia = models.CharField(max_length=100)
    calle = models.CharField(max_length=100)
    cp = models.ForeignKey(Cpedosucursal, models.DO_NOTHING, db_column='cp')
    numinterior = models.BigIntegerField()
    numexterior = models.BigIntegerField()

    class Meta:
        managed = False
        db_table = 'sucursal'


class Sucursaltelefono(models.Model):
    idsucursal = models.ForeignKey(Sucursal, models.DO_NOTHING, db_column='idsucursal')
    telefono = models.CharField(primary_key=True, max_length=20)

    class Meta:
        managed = False
        db_table = 'sucursaltelefono'


class Supervisar(models.Model):
    taquiclavegerente = models.ForeignKey(Empleado, models.DO_NOTHING, db_column='taquiclavegerente', primary_key=True)
    taquiclavesupervisado = models.ForeignKey(Empleado, models.DO_NOTHING, db_column='taquiclavesupervisado')

    class Meta:
        managed = False
        db_table = 'supervisar'
        unique_together = (('taquiclavegerente', 'taquiclavesupervisado'),)


class Tacorider(models.Model):
    taquiclave = models.ForeignKey(Empleado, models.DO_NOTHING, db_column='taquiclave', primary_key=True)
    estadisponible = models.BooleanField()

    class Meta:
        managed = False
        db_table = 'tacorider'


class Tener(models.Model):
    idproducto = models.ForeignKey(Producto, models.DO_NOTHING, db_column='idproducto', primary_key=True)
    idingrediente = models.BigIntegerField()
    cantidad = models.FloatField()

    class Meta:
        managed = False
        db_table = 'tener'
        unique_together = (('idproducto', 'idingrediente'),)


class Transporte(models.Model):
    idtransporte = models.BigIntegerField(primary_key=True)
    tipo = models.CharField(max_length=50)
    marca = models.CharField(max_length=55)
    modelo = models.CharField(max_length=70)

    class Meta:
        managed = False
        db_table = 'transporte'
