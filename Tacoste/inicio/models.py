# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Make sure each ForeignKey has `on_delete` set to the desired behavior.
#   * Remove `managed = False` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.
from django.db import models


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
    cp = models.IntegerField(blank=True, null=True)
    numinterior = models.BigIntegerField(blank=True, null=True)
    numexterior = models.BigIntegerField(blank=True, null=True)
    fechaprimervista = models.DateField(blank=True, null=True)
    numpuntos = models.BigIntegerField(blank=True, null=True)

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
    numpedido = models.ForeignKey('Pedido', models.DO_NOTHING, db_column='numpedido')
    idproducto = models.ForeignKey('Producto', models.DO_NOTHING, db_column='idproducto')
    cantidad = models.BigIntegerField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'contener'
        unique_together = (('numpedido', 'idproducto'),)


class Cpedocliente(models.Model):
    cp = models.IntegerField(primary_key=True)
    estado = models.CharField(max_length=100, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'cpedocliente'


class Cpedoempleado(models.Model):
    cp = models.IntegerField(primary_key=True)
    estado = models.CharField(max_length=100, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'cpedoempleado'


class Cpedoproveedor(models.Model):
    cp = models.IntegerField(primary_key=True)
    estado = models.CharField(max_length=100, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'cpedoproveedor'


class Cpedosucursal(models.Model):
    cp = models.IntegerField(primary_key=True)
    estado = models.CharField(max_length=100, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'cpedosucursal'


class Curpfnacemp(models.Model):
    curp = models.BigIntegerField(primary_key=True)
    fechanac = models.DateField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'curpfnacemp'


class Dirigir(models.Model):
    idsucursal = models.ForeignKey('Sucursal', models.DO_NOTHING, db_column='idsucursal')
    taquiclave = models.ForeignKey('Empleado', models.DO_NOTHING, db_column='taquiclave')
    fechainicio = models.DateField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'dirigir'
        unique_together = (('idsucursal', 'taquiclave'),)


class Empleado(models.Model):
    taquiclave = models.BigIntegerField(primary_key=True)
    idsucursal = models.ForeignKey('Sucursal', models.DO_NOTHING, db_column='idsucursal', blank=True, null=True)
    salario = models.FloatField(blank=True, null=True)
    email = models.CharField(unique=True, max_length=50, blank=True, null=True)
    telefono = models.CharField(max_length=20, blank=True, null=True)
    nombre = models.CharField(max_length=50, blank=True, null=True)
    apellidopaterno = models.CharField(max_length=50, blank=True, null=True)
    apellidomaterno = models.CharField(max_length=50, blank=True, null=True)
    municipio = models.CharField(max_length=100, blank=True, null=True)
    colonia = models.CharField(max_length=100, blank=True, null=True)
    calle = models.CharField(max_length=100, blank=True, null=True)
    cp = models.IntegerField(blank=True, null=True)
    numinterior = models.BigIntegerField(blank=True, null=True)
    numexterior = models.BigIntegerField(blank=True, null=True)
    curp = models.BigIntegerField(blank=True, null=True)
    rfc = models.CharField(max_length=13, blank=True, null=True)
    tipo = models.CharField(max_length=40, blank=True, null=True)
    tiposangre = models.CharField(max_length=5, blank=True, null=True)
    numemergencia = models.CharField(max_length=20, blank=True, null=True)
    fechacontratacion = models.DateField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'empleado'


class Fechapedpromo(models.Model):
    fechapedido = models.DateField(primary_key=True)
    promocion = models.CharField(max_length=50)

    class Meta:
        managed = False
        db_table = 'fechapedpromo'
        unique_together = (('fechapedido', 'promocion'),)


class Historico(models.Model):
    idhistorico = models.BigIntegerField(primary_key=True)
    idproducto = models.ForeignKey('Producto', models.DO_NOTHING, db_column='idproducto', blank=True, null=True)
    fechaactualizacion = models.DateField(blank=True, null=True)
    precionuevo = models.FloatField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'historico'


class Ingrediente(models.Model):
    idingrediente = models.BigIntegerField(primary_key=True)
    nombre = models.CharField(max_length=50, blank=True, null=True)
    marca = models.CharField(max_length=60, blank=True, null=True)
    cantidadexistencia = models.FloatField(blank=True, null=True)
    fechacaducidad = models.DateField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'ingrediente'


class Licencia(models.Model):
    taquiclave = models.ForeignKey('Tacorider', models.DO_NOTHING, db_column='taquiclave', primary_key=True)
    codigo = models.CharField(max_length=30, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'licencia'


class Llevar(models.Model):
    taquiclave = models.ForeignKey('Tacorider', models.DO_NOTHING, db_column='taquiclave')
    numpedido = models.ForeignKey('Pedido', models.DO_NOTHING, db_column='numpedido')

    class Meta:
        managed = False
        db_table = 'llevar'
        unique_together = (('taquiclave', 'numpedido'),)


class Mobiliario(models.Model):
    idmueble = models.BigIntegerField(primary_key=True)
    tipo = models.CharField(max_length=30, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'mobiliario'


class Pedido(models.Model):
    numpedido = models.BigIntegerField(primary_key=True)
    idsucursal = models.ForeignKey('Sucursal', models.DO_NOTHING, db_column='idsucursal', blank=True, null=True)
    fechapedido = models.DateField(blank=True, null=True)
    taquiclave = models.ForeignKey(Cliente, models.DO_NOTHING, db_column='taquiclave', blank=True, null=True)
    metodopago = models.CharField(max_length=50, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'pedido'


class Poseer(models.Model):
    taquiclave = models.ForeignKey('Tacorider', models.DO_NOTHING, db_column='taquiclave')
    idtransporte = models.ForeignKey('Transporte', models.DO_NOTHING, db_column='idtransporte')

    class Meta:
        managed = False
        db_table = 'poseer'
        unique_together = (('taquiclave', 'idtransporte'),)


class Prodhist(models.Model):
    idproducto = models.ForeignKey('Producto', models.DO_NOTHING, db_column='idproducto')
    precioprevio = models.FloatField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'prodhist'


class Producto(models.Model):
    idproducto = models.BigIntegerField(primary_key=True)
    puntosotorgar = models.BigIntegerField(blank=True, null=True)
    nombre = models.CharField(max_length=70, blank=True, null=True)
    precio = models.FloatField(blank=True, null=True)
    taquegoria = models.CharField(max_length=50, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'producto'


class Productoleyenda(models.Model):
    idproducto = models.ForeignKey(Producto, models.DO_NOTHING, db_column='idproducto')
    leyenda = models.CharField(max_length=50, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'productoleyenda'


class Proveedor(models.Model):
    rfc = models.CharField(primary_key=True, max_length=13)
    razonsocial = models.CharField(unique=True, max_length=100, blank=True, null=True)
    iniciorelacion = models.DateField(blank=True, null=True)
    email = models.CharField(unique=True, max_length=50, blank=True, null=True)
    telefono = models.CharField(max_length=20, blank=True, null=True)
    municipio = models.CharField(max_length=100, blank=True, null=True)
    colonia = models.CharField(max_length=100, blank=True, null=True)
    calle = models.CharField(max_length=100, blank=True, null=True)
    cp = models.IntegerField(blank=True, null=True)
    numinterior = models.BigIntegerField(blank=True, null=True)
    numexterior = models.BigIntegerField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'proveedor'


class Proveering(models.Model):
    rfc = models.ForeignKey(Proveedor, models.DO_NOTHING, db_column='rfc')
    idingrediente = models.ForeignKey(Ingrediente, models.DO_NOTHING, db_column='idingrediente')
    precio = models.FloatField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'proveering'
        unique_together = (('rfc', 'idingrediente'),)


class Proveermob(models.Model):
    rfc = models.ForeignKey(Proveedor, models.DO_NOTHING, db_column='rfc')
    idmueble = models.ForeignKey(Mobiliario, models.DO_NOTHING, db_column='idmueble')
    precio = models.FloatField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'proveermob'
        unique_together = (('rfc', 'idmueble'),)


class Recomendar(models.Model):
    idproducto = models.ForeignKey(Producto, models.DO_NOTHING, db_column='idproducto')
    idproductosalsa = models.ForeignKey('Salsa', models.DO_NOTHING, db_column='idproductosalsa')

    class Meta:
        managed = False
        db_table = 'recomendar'
        unique_together = (('idproducto', 'idproductosalsa'),)


class Salsa(models.Model):
    idproducto = models.ForeignKey(Producto, models.DO_NOTHING, db_column='idproducto', primary_key=True)
    nombre = models.CharField(max_length=50, blank=True, null=True)
    presentacion = models.CharField(max_length=70, blank=True, null=True)
    scoville = models.CharField(max_length=20, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'salsa'


class Sucursal(models.Model):
    idsucursal = models.BigIntegerField(primary_key=True)
    horaapertura = models.DateTimeField(blank=True, null=True)
    horacierre = models.DateTimeField(blank=True, null=True)
    municipio = models.CharField(max_length=100, blank=True, null=True)
    colonia = models.CharField(max_length=100, blank=True, null=True)
    calle = models.CharField(max_length=100, blank=True, null=True)
    cp = models.IntegerField(blank=True, null=True)
    numinterior = models.BigIntegerField(blank=True, null=True)
    numexterior = models.BigIntegerField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'sucursal'


class Sucursaltelefono(models.Model):
    idsucursal = models.ForeignKey(Sucursal, models.DO_NOTHING, db_column='idsucursal', primary_key=True)
    telefono = models.CharField(max_length=20)

    class Meta:
        managed = False
        db_table = 'sucursaltelefono'
        unique_together = (('idsucursal', 'telefono'),)


class Supervisar(models.Model):
    taquiclavegerente = models.ForeignKey(
        Empleado, models.DO_NOTHING, db_column='taquiclavegerente', related_name='+'
    )
    taquiclavesupervisado = models.ForeignKey(Empleado, models.DO_NOTHING, db_column='taquiclavesupervisado')

    class Meta:
        managed = False
        db_table = 'supervisar'
        unique_together = (('taquiclavegerente', 'taquiclavesupervisado'),)

class Tacorider(models.Model):
    taquiclave = models.ForeignKey(Empleado, models.DO_NOTHING, db_column='taquiclave', primary_key=True)
    estadisponible = models.NullBooleanField()

    class Meta:
        managed = False
        db_table = 'tacorider'


class Tener(models.Model):
    idproducto = models.ForeignKey(Producto, models.DO_NOTHING, db_column='idproducto')
    idingrediente = models.ForeignKey(Ingrediente, models.DO_NOTHING, db_column='idingrediente')
    cantidad = models.FloatField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'tener'
        unique_together = (('idproducto', 'idingrediente'),)


class Transporte(models.Model):
    idtransporte = models.BigIntegerField(primary_key=True)
    tipo = models.CharField(max_length=50, blank=True, null=True)
    marca = models.CharField(max_length=55, blank=True, null=True)
    modelo = models.CharField(max_length=70, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'transporte'
