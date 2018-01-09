##########################################################################
-- Nombre            : DML_consultas.sql.
-- Fecha             : 12 de enero del 2018.
-- Autores           : Flores Martínez Andrés, 
--                     Vázquez Salcedo Eduardo Eder,
--                     Sánchez Pérez Pedro Juan Salvador,
--                     Concha Vázquez Miguel.
-- Compañía          : Computólogos A.C., Facultad de Ciencias UNAM.
-- Cliente           : Taquería Tacoste.
-- ========================================================================
-- Propósito         : A través de las sentencias del lenguje de manipulación 
--                     de datos (DML, "Data Manipulation Language") de SQL con
--                     el SMBD Oracle, se efectúan consultas sobre los datos
--                     almacenados para poder extraer información útil sobre
--                     estos que puedan ser de utilidad para la empresa.
##########################################################################

-- =============================================
-- Consultas acerca de Sucursales y Productos.
-- =============================================

/**
  * Los quince productos más vendido en la taquería y su número 
  * respectivo de ventas.
*/
SELECT idProducto,nombre,taquegoria,descripcion,ventas as "Número de Ventas"
FROM (SELECT *
        FROM (SELECT idProducto, SUM(cantidad) AS ventas --Vemos la suma de los productos.
                FROM Contener
                GROUP BY idProducto
                ORDER BY ventas desc) --Los ordenamos descendentemente.
        WHERE ROWNUM < 16) NATURAL JOIN Producto --Elegimos las primeras 15 tuplas y hacemos el join con la tabla Producto.
                           NATURAL JOIN Categoria; --Así como también con la tabla de Categoria para tener la taquegoría con el id del producto.

/**
  * Las tres salsas más vendidas que además tienen el mayor 
  * picor.
*/
SELECT *
FROM(SELECT idProducto, nombreSalsa, presentacion, scoville, precio, ventas
     FROM (SELECT idProducto, SUM(cantidad) AS ventas --Obtenemos las ventas de cada producto.
           FROM Contener
           GROUP BY idProducto) a INNER JOIN  
          (SELECT idProducto,nombre,presentacion,scoville,precio --Obtenemos las salsas que son más picantes.
           FROM Salsa NATURAL JOIN Producto
           WHERE scoville = 'EXTREMO') b --Nos quedamos solamente con las salsas de interés al hacer el join y tenemos ahora también su número de ventas.
     ON a.idProducto = b.idProducto
ORDER BY ventas desc) --Las ordenamos descendentemente acorde al número de ventas.
WHERE ROWNUM < 4; --Seleccionamos solamente las primeras tres tuplas.

/**
  * Listado con el número de pagos efectuados con cada método de pago por sucursal.
*/
SELECT * 
FROM (SELECT idSucursal, metodoPago
        FROM Pedido) r --La tabla de los pedidos tiene la información suficiente.
pivot(COUNT(*) for metodoPago in ('EFECTIVO' as Efectivo, --Hacemos el uso de la función relacional de rotación para transformar valores únicos de una columna en varias columnas.
                                    'TARJETA DEBITO' as TarjetaDebito, --Los métodos de Pago aparecerán entonces como las columnas; hacemos el renombre respectivo.
                                    'TARJETA CREDITO' as TarjetaCredito,
                                    'CRYPTOCURRENCY' as Cryptocurrency,
                                    'VALES' as Vales))
ORDER BY idSucursal; --Por omisión se ordenará ascendentemente por el identificador de cada sucursal.


-- =============================================
-- Consultas acerca de Empleados y Proveedores.
-- =============================================

/**
  * La taquiClave, nombre Completo, número de emergencia, grupo sanguíneo
  * de los TacoRiders que manejan motocicleta y cuya fecha de contratación corresponde
  * al segundo trimestre del año 2008, además de la información del vehículo.   
*/
SELECT *
FROM (SELECT taquiClave, nombre, apellidoPaterno, apellidoMaterno, numEmergencia, tipoSangre --La información de los TacoRiders contratados en el segundo trimestre del 2008.
      FROM TacoRider JOIN Empleado USING (taquiClave)
      WHERE to_char(fechaContratacion,'q') = 2 AND
            extract(year from fechaContratacion) = 2008) NATURAL JOIN Poseer 
                                                         NATURAL JOIN Transporte
WHERE tipo = 'MOTOCICLETA';

/**
  * Gerentes que supervisen a al menos un TacoRider que haya llevado un pedido que incluyera una torta
  * y que la tercera letra del apellido paterno sea 'M'.  
*/
SELECT taquiClave, nombre, apellidoPaterno, apellidoMaterno --Seleccionamos solamente algunos datos de interés.
FROM Empleado a INNER JOIN 
    (SELECT DISTINCT taquiClaveGerente --No queremos repetidos, pues en la tabla de Supervisar puede repetirse el mismo gerente al poder tener varios subordinados.
     FROM Supervisar NATURAL JOIN TacoRider NATURAL JOIN Llevar
     WHERE numPedido in (SELECT numPedido --Seleccionamos los gerentes que supervisan a tacoriders que han llevado pedidos que lo cumplen.
                         FROM Pedido NATURAL JOIN Contener NATURAL JOIN Producto NATURAL JOIN Categoria
                         WHERE taquegoria = 'TORTAS')) b --Vemos los pedidos que contienen algo de la categoría de tortas. 
    ON a.taquiClave = b.taquiClaveGerente --Seleccionamos a los gerentes con el join para tener la demás información de éstos.
WHERE REGEXP_LIKE(apellidoPaterno, '^..m.*'); --Usamos la expresión regular para verificar que comienzce con M el apellido paterno.

/**
  * Listado con los veinte ingredientes que tienen menos proveedores, 
  * su nombre, marca y fecha de caducidad.
*/
SELECT idIngrediente, nombre, marca, fechaCaducidad
FROM (SELECT *
        FROM (SELECT idIngrediente, count(RFC) as numProveedores
                FROM proveerIng --En la tabla de la provisión de Ingredientes se cuenta la ocurrencia de cada identificador.
                GROUP BY idIngrediente
                ORDER BY as numProveedores) --En orden ascendente que el de por omisión para que al principio esté el de menor proveedores.
        WHERE ROWNUM < 21) NATURAL JOIN Ingrediente; --Consideramos solamente las primeras veinte tuplas y hacemos join con la tabla Ingrediente para conseguir la demás información.

/**
  * Listado de la cantidad de empleados por cada sucursal, con el identificador de la sucursal,
  * datos de su dirección más importantes, nombre completo y fecha de inicio de dirección de su gerente.
*/
SELECT idSucursal,calle,colonia,municipio,estado,taquiClave as "Clave del Gerente",nombre,apellidoPaterno,apellidoMaterno, fechaInicio as "Inicio de dirección de la sucursal"
FROM (SELECT idSucursal, tipo, estado
        FROM Empleado NATURAL JOIN CPEdoSucursal) r --Tenemos la información en la tabla de empleados y queremos el estado de las sucursales.
pivot(COUNT(*) for tipo in ('PARRILLERO' as "número de Parrilleros", --Usamos la función relacional de rotación para extender valores como nuevas columnas.
                            'TAQUERO' as "número de Taqueros", --Damos el nombre de los campos a las columnas generadas tras la rotación con el pivote tomado.
                            'MESERO' as "número de Meseros",
                            'CAJERO' as "número de Cajeros",
                            'TORTILLERO' as "número de Tortilleros",
                            'TACORIDER' as "número de TacoRiders"))
JOIN Dirigir USING (idSucursal) JOIN Empleado ON taquiClave --Para tener la información de los gerentes por sucursal.
ORDER BY idSucursal; --Ordenamos ascendentemente de acuerdo con el identificador de las sucursales.


-- =============================================
-- Consultas acerca de Clientes.
-- =============================================

/**
  * La taquiClave, el nombre completo, dirección de correo electrónico, número de puntos y
  * número de pedido de los veinte clientes que han realizado más pedidos en las distintas 
  * sucursales de la taquería.
*/
SELECT taquiClave, nombre, apellidoPaterno, apellidoMaterno, email, numPuntos, numPedidos as "Número de Pedidos"  
FROM
    (SELECT * 
     FROM (SELECT taquiClave, COUNT(taquiClave) AS numPedidos
           FROM Pedido
           GROUP BY taquiClave
           ORDER BY numPedidos desc) --Los ordenamos descendentemente de acuerdo al número de ocurrencias de la taquiClave en Pedidos.
    WHERE ROWNUM < 21) NATURAL JOIN Cliente; --Seleccionasmos las primeras veinte tuplas y se hace el join natural con la taquiClave de Cliente.

/**
  * Listado de los clientes que en el año 2008 compraron productos de la 
  * categoría 'QUECAS' y pagaron con 'CRYPTOCURRENCY'. 
*/
SELECT taquiClave, nombre, apellidoPaterno, apellidoMaterno, fechaPedido, metodoPago, idProducto, taquegoria --Seleccionamos lo que nos interesa.
FROM (SELECT taquiClave, idProducto, fechaPedido, metodoPago, taquegoria
      FROM Pedido NATURAL JOIN Contener NATURAL JOIN Producto NATURAL JOIN Categoria
      WHERE metodoPago = 'CRYPTOCURRENCY' --Que hayan pagado con criptomoneda. 
                AND taquegoria = 'QUECAS' --Que el producto sea de la categoría de quesadillas.
                AND EXTRACT(YEAR FROM fechaPedido) = 2008) a INNER JOIN --Y el año de interés.
      Cliente b ON a.taquiClave = b.taquiClave; --Hacemos el join con la tabla Cliente para tener el resto de su información.