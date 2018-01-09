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
  * 1. Los quince productos más vendidos en la taquería y su número 
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
  * 2. Las tres salsas más vendidas que además tienen el mayor 
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
  * 3. Listado con el número de pagos efectuados con cada método de pago por sucursal.
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

/**
  * 4. Un listado con la clave, el nombre de la salsa, el número de productos que recomienda y las veces
  * cuyo precio se ha visto actualizado.
*/
SELECT idProducto, nombre, numRecomendaciones as "Número de productos que recomienda", numActua as "Número de actualizaciones en precio"
FROM (SELECT idProductoSalsa, COUNT(idProductoSalsa) as numRecomendaciones--Las salsas y el número de productos que recomiendan.
	 FROM Recomendar 
	 GROUP BY idProductoSalsa) a 
	JOIN
	(SELECT idProducto,(COUNT(idProducto)-1) as numActua --Las salsas y su número de actualizaciones de precio. Sustraemos una unidad porque la primer tupla tiene como precio previo y precio nuevo el mismo valor.
	 FROM Salsa NATURAL JOIN Producto NATURAL JOIN Conservar NATURAL JOIN Historico
	 GROUP BY idProducto) b --Obtenemos el histórico para la salsa.
ON a.idProductoSalsa = b.idProducto
ORDER BY idProducto; --Ordenamos por la clave de las salsas en el orden ascendente por omisión.

/**
  * 5. El precio promedio de los productos de acuerdo
  * a su histórico que contienen algún ingrediente cuya fecha de caducidad
  * corresonde a algún lunes o miércoles. Consideramos a esto último la fecha de caducidad del producto.
*/
SELECT idProducto, nombre, promedio as "Precio promedio", descripcion, fechaCaducidad as fechaCaducidadProducto
FROM (SELECT * 
	  FROM Producto NATURAL JOIN Tener NATURAL JOIN Ingrediente --Los productos que tienen ingredientes que caducan un lunes o miércoles.
      WHERE to_char(fechaCaducidad,'day') in ('lunes','miércoles')) 
      NATURAL JOIN 
     (SELECT idProducto, AVG(precioPrevio) as promedio --El precio promedio de cada producto de acuerdo a las modificaciones del mismo.
      FROM Historico
      GROUP BY idProducto);

/**
  * 6. Ganancia promedio por estado, sucursal y año, rotando los trimestres para 
  * poder tener una mejor visualización.
*/
CREATE VIEW PedidosCosto AS
SELECT numPedido, SUM(precio) AS pedidoCosto --Tenemos que sumar los precios de cada producto.
FROM Pedido NATURAL JOIN CONTENER NATURAL JOIN Producto --En la tabla Producto tenemos el precio de cada producto que constituye el Pedido, así que hacemos joins hasta ella.
GROUP BY numPedido --Agrupamos la suma de acuerdo a cada pedido.
ORDER BY numPedido; --Los ordenamos ascendentemente por el identificador del pedido.

CREATE VIEW GananciaSucursal AS
SELECT idSucursal, SUM(pedidoCosto) as gananciaSucursal --La suma del precio de los pedidos los tenemos en la vista previamente creada.
FROM PedidosCosto NATURAL JOIN Pedido --Nos faltaba la información contenida en la tabla de Pedidos.
GROUP BY idSucursal --Solamente falta agruparlos por cada sucursal, lo que es fácil usando su clave.
ORDER BY idSucursal; --Ordenamos ascendentemente las sucursales por su identificador.

SELECT estado, --Seleccionamos la dirección,
       municipio, 
       colonia, 
       calle, 
       idSucursal, --El identificador de sucursal,
       año,  --y los datos de la fecha.
       to_char(T1,'$999,999.00') AS "Primer trimestre",
       to_char(T2,'$999,999.00') AS "Segundo trimestre",
       to_char(T3,'$999,999.00') AS "Tercer trimestre",
       to_char(T4,'$999,999.00') AS "Cuarto trimestre"
FROM (SELECT estado, municipio, colonia, calle, idSucursal,
             extract(year FROM fechaPedido) año,
             to_char(fechaPedido,'q') trimestre --Queremos los trimestres.
      FROM GananciaSucursal NATURAL JOIN Pedido NATURAL JOIN Sucursal NATURAL JOIN CPEdoSucursal) r --Hacemos un join con los pedidos para tener la fecha de cada uno y tenemos también la sucursal en que se llevó a cabo.
pivot(AVG(gananciaSucursal) for trimestre IN (1 AS "T1",2 AS "T2", 3 AS "T3", 4 AS "T4")) --Rotamos para tener como columnas los trimestres.
ORDER BY estado, municipio, colonia, calle, idSucursal, año; --Agrupamos de acuerdo al nivel de granularidad de detalle.


-- =============================================
-- Consultas acerca de Empleados y Proveedores.
-- =============================================

/**
  * 7. La taquiClave, nombre Completo, número de emergencia, grupo sanguíneo
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
  * 8. Gerentes que supervisen a al menos un TacoRider que haya llevado un pedido que incluyera una torta
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
  * 9. Listado con los veinte ingredientes que tienen menos proveedores, 
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
  * 10. Listado de la cantidad de empleados por cada sucursal, con el identificador de la sucursal,
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

/**
  * 11. Encontrar las cinco sucursales que tienen a los gerentes con menor antigüedad dirigente (no necesariamente)
  * con la menor antigüedad como empleados contratados) y en cada caso enlistar también el número de empleados que tienen a su supervisión 
  * directa.
*/ 
CREATE VIEW JefesSucursal AS
SELECT idSucursal, calle, colonia, municipio, estado, taquiClave, nombre, apellidoPaterno, apellidoMaterno, fechaInicio --Tabla que contiene los dirigentes de cada sucursal.
FROM Empleado NATURAL JOIN Dirigir NATURAL JOIN Sucursal NATURAL JOIN CPEdoSucursal      
GROUP BY idSucursal
ORDER BY idSucursal; --Las ordenamos en orden ascendente las tuplas de acuerdo con el identificador de las sucursales.

CREATE VIEW NumSupervisadosGerente AS
SELECT taquiClaveGerente, COUNT(taquiClaveGerente) AS numSubordinados --Tabla que contiene el número de empleados supervisados por gerente.
FROM Supervisar --Se usa para este motivo la función de agregación de conteo.
GROUP BY (taquiClaveGerente)
ORDER BY taquiClaveGerente; --Los ordenamos en orden ascendente.

SELECT JefeSucursal.*, numSubordinados AS "Número de Supervisados" --Seleccionamos toda la información solicitada.
FROM (SELECT * 
	  FROM JefeSucursal
	  ORDER BY fechaInicio
	  WHERE rownum <= 5) a --Los cinco dirigentes y su información y la de la sucursal que dirigen con menor antigüedad. 
INNER JOIN NumSupervisadosGerente b ON a.taquiClave = b.taquiClaveGerente; --Y mediante el join obtenemos también su número de supervisados.


-- =============================================
-- Consultas acerca de Clientes y Pedidos.
-- =============================================

/**
  * 12. La taquiClave, el nombre completo, dirección de correo electrónico, número de puntos y
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
  * 13. Listado de los clientes que en el año 2008 compraron productos de la 
  * categoría 'QUECAS' y pagaron con 'CRYPTOCURRENCY'. 
*/
SELECT taquiClave, nombre, apellidoPaterno, apellidoMaterno, fechaPedido, metodoPago, idProducto, taquegoria --Seleccionamos lo que nos interesa.
FROM (SELECT taquiClave, idProducto, fechaPedido, metodoPago, taquegoria
      FROM Pedido NATURAL JOIN Contener NATURAL JOIN Producto NATURAL JOIN Categoria
      WHERE metodoPago = 'CRYPTOCURRENCY' --Que hayan pagado con criptomoneda. 
                AND taquegoria = 'QUECAS' --Que el producto sea de la categoría de quesadillas.
                AND EXTRACT(YEAR FROM fechaPedido) = 2008) a INNER JOIN --Y el año de interés.
      Cliente b ON a.taquiClave = b.taquiClave; --Hacemos el join con la tabla Cliente para tener el resto de su información.

/**
  * 14. Los pedidos que fueron realizados en el mes de marzo u octubre del año 2010
  * y que contienen algún producto que pertenece a la categoría de 'Entradas', pero que no
  * tiene ningún producto de la categoría de 'Postres'. Requerimos también los datos importantes
  * del cliente que efectuó el pedido.
*/
SELECT *
(SELECT taquiClave, nombre, apellidoPaterno, apellidoMaterno, email, telefono, numPedido --Los pedidos que tienen algún producto que es entrada.
FROM Cliente NATURAL JOIN Pedido NATURAL JOIN Contener NATURAL JOIN Producto NATURAL JOIN Categoria
WHERE taquegoria = 'ENTRADAS' AND
      EXTRACT(month from fechaPedido) IN (3,10) AND 
      EXTRACT(year from fechaPedido) = 2010)
LEFT OUTER JOIN  --Nos quedamos con los que no tienen
(SELECT taquiClave, nombre, apellidoPaterno, apellidoMaterno, email, telefono, numPedido --Aquellos pedidos con algún producto que es un postre.
FROM Cliente NATURAL JOIN Pedido NATURAL JOIN Contener NATURAL JOIN Producto NATURAL JOIN Categoria
WHERE taquegoria = 'POSTRES' AND
      EXTRACT(month from fechaPedido) IN (3,10) AND 
      EXTRACT(year from fechaPedido) = 2010);

/**
  * 15. Un listado de aquellos clientes que hayan sido asiduos de la taquería por un periodo superior a los tres años,
  * además del precio promedio de sus pedidos.
*/
SELECT taquiClave, nombre, apellidoPaterno, apellidoMaterno, 
       fechaPrimerVisita, CONCAT(TRUNC(MONTHS_BETWEEN(CURRENT_DATE,fechaPrimerVisita)/12),' años') AS "Años como Cliente",
       concat('$', TRUNC(promedioGasto,2)) as "Gasto promedio por Pedido del cliente" --Lo dejamos con dos decimales y agregamos el signo de pesos.
FROM Cliente cl JOIN 
     (SELECT taquiClave, AVG(pedidosCosto) promedioGasto
      FROM Cliente NATURAL JOIN Pedido NATURAL JOIN PedidosCosto --Usamos la vista creada previamente en la sexta consulta.
      GROUP BY taquiClave) gp --Agrupamos para cada taquiClave para tener por cada cliente.
  ON cl.taquiClave = gp.taquiClave 
WHERE CONCAT(TRUNC(MONTHS_BETWEEN(CURRENT_DATE,fechaPrimerVisita)/12) > 3; --Superior a los tres años como cliente.