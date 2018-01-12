-- ##########################################################################
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
-- ##########################################################################

-- =============================================
-- Consultas acerca de Sucursales y Productos.
-- =============================================

/**
  * 1. Los 20 producto más vendido en la taquería y su número de ventas.
*/
SELECT idProducto, nombre, taquegoria, descripcion, ventas as "Número de Ventas"
FROM (SELECT *
	  FROM (SELECT *
            FROM (SELECT SUM(cantidad) AS ventas, idProducto --Vemos la suma de los productos.
                  FROM Contener
                  GROUP BY idProducto
                  ORDER BY Ventas desc) --Los ordenamos descendentemente.
            WHERE ROWNUM < 21) NATURAL JOIN Producto) natural join Categoria; -- Elegimos las primeras veinte tupla y hacemos el join con la tabla Producto.
                                                                              -- Al requerir de igual forma la taquegoría, hacemos join con Categoría.

/**
  * 2. Las cinco salsas más vendidas que además tienen el mayor 
  * picor (nivel 'ALTO' o 'EXTREMO').
*/
SELECT *
FROM(SELECT idProducto, nombreSalsa, Presentacion, scoville, precio, ventas
        FROM (SELECT SUM(cantidad) AS ventas, idProducto --Obtenemos las ventas de cada producto.
                FROM contener
                GROUP BY idProducto) a INNER JOIN (SELECT id, nombre as nombreSalsa, presentacion, scoville, precio --Obtenemos las salsas que son más picantes.
                                                    FROM (SELECT idProducto AS id, presentacion, scoville
                                                    FROM Salsa
                                                    WHERE scoville in ('EXTREMO','ALTO')) a INNER JOIN Producto b ON a.id = b.idProducto) b --Nos quedamos solamente con las salsas de interés al hacer el join y tenemos ahora también su número de ventas.
                                                    ON a.idProducto = b.id
        ORDER BY ventas desc) --Las ordenamos descendentemente acorde al número de ventas.
WHERE ROWNUM < 6; --Seleccionamos solamente las primeras cinco tuplas.

/**
  * 3. Listado con el número de pagos efectuados con cada método de pago por sucursal.
*/
SELECT * 
FROM (SELECT idSucursal, metodoPago, calle, colonia, municipio, Estado
        FROM Pedido NATURAL JOIN sucursal NATURAL JOIN CPEdoSucursal) r --La tabla de los pedidos tiene la información suficiente.
pivot(COUNT(*) for metodoPago in ('EFECTIVO' as Efectivo, --Hacemos el uso de la función relacional de rotación para transformar valores únicos de una columna en varias columnas.
                                    'TARJETA DEBITO' as TarjetaDebito, --Los métodos de Pago aparecerán entonces como las columnas; hacemos el renombre respectivo.
                                    'TARJETA CREDITO' as TarjetaCredito,
                                    'CRYPTOCURRENCY' as Cryptocurrency,
                                    'VALES' as Vales))
ORDER BY idSucursal; --Por omisión se ordenará ascendentemente por el identificador de cada sucursal.

/**
  * 4. El empleado que gana más por cada sucursal.
*/
SELECT idSucursal, nombre, apellidoPaterno, apellidoMaterno, fechaContratacion, concat('$',maxSalario) as "Salario" --Le agregamos el signo de pesos.
FROM Empleado NATURAL JOIN (SELECT idsucursal, max(salario) maxSalario --Tenemos el salario máximo de cada sucursal, así que hacemos el join natural con los empleados.
                            FROM (SELECT salario, idSucursal --Tenemos a los salarios de cada empleado y a la clave de la sucursal donde laboran. 
                                  FROM Empleado
                                  order by salario desc) --Los ordenamos descendentemente de acuerdo al salario.
                            GROUP by idSucursal --Tenemos que agrupar por sucursal de acuerdo a su clave.
                            ORDER by idSucursal) --Los ordenamos en orden ascendente de acuerdo a la llave de las sucursales, que es su id.
WHERE salario = maxSalario --Checamos que el salacio del empleado coincida con el máximo.
ORDER BY idSucursal; --Y ordenamos nuevamente en orden ascendente por la clave de las sucursales.

/**
  * 5. Un listado con los directores de cada Sucursal, además de su fecha de contratación, años como directores
  * y número de empleados que tienen como supervisados a su comando.
*/
SELECT a.*, numSupervisados --Toda la información de la primer suconsulta y el número de supervisados.
FROM (SELECT s.idSucursal, --Seleccionamos al información que nos interesa. Usamos notación punto para no dar lugar a confusiones.
             s.calle, 
             s.colonia,
             estado, 
             e.taquiClave
             e.nombre,
             e.apellidoPaterno,
             e.apellidoMaterno, 
             e.fechaContratacion, 
             CONCAT(TRUNC(MONTHS_BETWEEN(CURRENT_DATE,d.fechaInicio)/12),' años') AS "Años como Director" 
      FROM CPEdoSucursal NATURAL JOIN Sucursal s --Queremos el estado.
                         NATURAL JOIN Dirigir d  --En dirigir tenemos a los directores de las sucursales.
                         JOIN Empleado e ON d.taquiClave = e.taquiClave) a INNER JOIN  --En empleado tenemos el resto de la información de los directores.
     (SELECT taquiClaveGerente, COUNT(taquiClaveGerente) as numSupervisados --Segunda subconsulta para determinar el número de supervisados por gerente.
      FROM Supervisar --Al usar la función de agregación de conteo sobre la tabla de Supervisar y agrupar por la clave de los gerentes tenemos lo que requerimos.
      GROUP BY taquiClaveGerente) b ON a.taquiClave = b.taquiClaveGerente --Un join para empatar la información de las dos subconsultas.
/**
  * 5. Un listado con las tres horas que son más fructíferas para la taquería por sucursal y 
  * cuántos pedidos se registraron en dichos horarios.
*/
SELECT to_char(fecha,'hh24') Hora, COUNT(Hora) as numPedidos
FROM Pedido
GROUP BY Hora 
ORDER BY numPedidos DESC
WHERE ROWNUM <= 3;

/**
  * 6. Cantidad de ventas por categoría por cada una de las sucursales, con la información
  * más pertinente de la dirección de la sucursal.
*/
SELECT a.*, calle, colonia, municipio, estado --Seleccionamos todo lo de la primer subconsulta y los datos de dirección de la sucursal.
FROM (SELECT *
      FROM (SELECT idSucursal, taquegoria
            FROM Sucursal NATURAL JOIN Pedido NATURAL JOIN Categoria) r --Necesitamos hacer joins hasta la tabla de Categoría poruqe ahí tenemos las taquegorías de los productos.
     pivot(COUNT(*) for taquegoria IN ('ENTRADAS' AS Entradas, --Usamos el operador relacional para colocar las categorías como nuevas columnas.
                                       'DEL CAZO' AS "Del cazo", --Hacemos el renombrado de las categorías como aparecerán en las columnas.
                                       'SOPES Y HUARACHES' AS "Sdopes y Huaraches",
                                       'ENCHILADAS' AS Enchiladas,
                                       'QUESOS' AS Quesos,
                                       'GRINGAS' AS Gringas, 
                                       'QUECAS Y VOLCANES' AS "Quecas y Volcanes",
                                       'ALAMBRES' AS Alambres,
                                       'ENSALADAS' AS Ensaladas,
                                       'TACOS' AS Tacos,
                                       'HAMBURGUESAS' AS Hamburguesas,
                                       'TORTAS' AS Tortas,
                                       'BEBIDAS' AS Bebidas,
                                       'POSTRES' AS Postres,
                                       'SALSAS' AS Salsas))
ORDER BY idSucursal) a INNER JOIN sucursal b ON a.idSucursal = b.idSucursal NATURAL JOIN CPEdoSucursal; --Necesitamos hacer este join para considerar el estado de la sucursal.


-- =============================================
-- Consultas acerca de Empleados y Proveedores.
-- =============================================

/**
  * 7. La taquiClave, nombre Completo, número de emergencia, grupo sanguíneo
  * de los TacoRiders que manejan motocicleta y cuya fecha de contratación corresponde
  * al tercer trimestre de alguno de los años comprendidos entre 1970 y el 2010, además de la información del vehículo.   
*/
SELECT *
FROM (SELECT taquiClave, nombre, apellidoPaterno, apellidoMaterno, numEmergencia, tipoSangre --La información de los TacoRiders contratados en el segundo trimestre del 2008.
      FROM TacoRider JOIN Empleado USING (taquiClave)
      WHERE to_char(fechaContratacion,'q') = 3 AND --Elegimos el tercer trimestre
            extract(year from fechaContratacion) between 1970 and 2010) NATURAL JOIN Poseer --Recordando que between es inclusivo, tomamos ese perdiodo. 
                                                         NATURAL JOIN Transporte
WHERE tipo = 'MOTOCICLETA'; --De los que usen moto.

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
  * 9. Listado con los cinco ingredientes que tienen menos proveedores, 
  * su nombre, marca y fecha de caducidad.
*/
SELECT idIngrediente, proveedores, nombre, marca, CantidadExistencia
FROM (SELECT *
        FROM (SELECT idIngrediente, count(RFC) as proveedores
                FROM proveerIng --En la tabla de la provisión de Ingredientes se cuenta la ocurrencia de cada identificador.
                GROUP BY idIngrediente
                ORDER BY proveedores) --En orden ascendente que el de por omisión para que al principio esté el de menor proveedores.
        WHERE ROWNUM < 6) NATURAL JOIN Ingrediente; --Consideramos solamente las primeras cinco tuplas y hacemos join con la tabla Ingrediente para conseguir la demás información.

/**
  * 10. Listado de la cantidad de empleados por cada sucursal, con el identificador de la sucursal,
  * datos de su dirección más importantes.
*/
SELECT a.*, calle, colonia, municipio, estado --Tenemos la información en la tabla de empleados y queremos el estado de las sucursales.
FROM (SELECT *
      FROM (SELECT idSucursal, tipo
            FROM Empleado ) r 
      pivot(COUNT(*) for tipo in ('PARRILLERO' as "número de Parrilleros",  --Usamos la función relacional de rotación para extender valores como nuevas columnas.
                                  'TAQUERO' as "número de Taqueros", --Damos el nombre de los campos a las columnas generadas tras la rotación con el pivote tomado.
                                  'MESERO' as "número de Meseros",
                                  'CAJERO' as "número de Cajeros",
                                  'TORTILLERO' as "número de Tortilleros",
                                  'TACORIDER' as "número de TacoRiders"))
      ORDER BY idSucursal) a INNER JOIN Sucursal b ON a.idSucursal = b.idSucursal NATURAL JOIN CPEdoSucursal; --Queremos también el estado

/**
  * 11. Los diez tacoriders que más pedidos han llevado.
*/ 
SELECT taquiClave, nombre, apellidoPaterno, apellidoMaterno, pedidosLlevados --Seleccionamos los datos básicos del repartidor y el número de pedidos llevados.
FROM Empleado natural join (SELECT taquiclave, count(numPedido) as pedidosLlevados --En esta subconsulta agrupamos por los pedidos registrados por cada taquiclave de TacoRider.
							FROM Llevar --Para este fin nos referimos a la tabla 'Llevar' que contiene esta información.
							GROUP BY taquiclave --Agrupamos por la clave de repartidor-
							ORDER BY pedidosLlevados DESC) --Y los ordenamos de más a menos pedidos (descendentemente).
WHERE rownum <= 10; --Nos quedamos solamente con las tuplas de interés.


-- =============================================
-- Consultas acerca de Clientes y Pedidos.
-- =============================================

/**
  * 12. La taquiClave, el nombre completo, dirección de correo electrónico, número de puntos y
  * número de pedido de los diez clientes que han realizado más pedidos en las distintas 
  * sucursales de la taquería, además de que tienen el mayor número de puntos
*/
SELECT taquiClave, nombre, apellidoPaterno, apellidoMaterno, email, numPuntos, numPedidos as "Número de Pedidos"  
FROM
    (SELECT * 
     FROM (SELECT COUNT(taquiClave) AS Pedidos, taquiClave
           FROM Pedido
           GROUP BY taquiClave
           ORDER BY Pedidos desc) --Los ordenamos descendentemente de acuerdo al número de ocurrencias de la taquiClave en Pedidos.
    WHERE ROWNUM < 11) NATURAL JOIN (SELECT * --Seleccionasmos las primeras diez tuplas y se hace el join natural con la otra consulta.
                                     FROM Cliente
                                     ORDER BY numPuntos desc); --Ordenamos los puntos descendentemente.

/**
  * 13. Clientes que en el año 2008 compro QUECAS y pago con CRYPTOCURRENCY 
*/
SELECT idProducto, fechaPedido, metodoPago, taqueGoria, nombre, apellidoPaterno, apellidoMaterno 
FROM (SELECT taquiClave, idProducto, fechaPedido, metodoPago, taqueGoria
        FROM Pedido NATURAL JOIN Contener NATURAL JOIN Producto NATURAL JOIN Categoria
        WHERE metodoPago = 'CRYPTOCURRENCY' --QUe pagaron con criptomoneda
                AND taqueGoria = 'TORTAS' --De la categoría tortas algún producto en su pedido.
                AND EXTRACT(YEAR FROM fechaPedido) = 1970) a INNER JOIN Cliente b ON a.taquiClave = b.taquiClave;
                
/**
  * 14. Un listado con los clientes que han efectuado pedidos, mismos que han sido preparados, más no entregados.
  * Los pedidos están ahora en tránsito y serán entregados por un TacoRider en bicicleta.
*/
SELECT cl.*, p.numPedido, p.preparado, p.entregado, t.taquiClave as "Clave de repartidor", tr.tipo 
FROM Cliente cl INNER JOIN Pedido p ON cl.taquiClave = p.taquiClave 
                INNER JOIN Llevar l ON p.numPedido = l.numPedido
                INNER JOIN TacoRider t ON l.taquiClave = t.taquiClave
                INNER JOIN Poseer po ON t.taquiClave = po.taquiClave 
                INNER JOIN Transporte tr ON po.idTransporte = tr.idTransporte
WHERE tr.tipo = 'BICICLETA' AND 
      p.preparado = 1 AND
      p.entregado = 0  

/**
  * 15. Un listado de aquellos clientes que hayan sido asiduos de la taquería por un periodo superior a los tres años,
  * además del precio promedio de sus pedidos.
*/
CREATE VIEW PedidosCosto AS --Creamos una vista que nos será de utilidad con el costo por pedido.
SELECT numPedido, SUM(precio*Cantidad) AS pedCost --Tenemos que sumar los precios de cada producto.
FROM Pedido NATURAL JOIN CONTENER NATURAL JOIN Producto --En la tabla Producto tenemos el precio de cada producto que constituye el Pedido, así que hacemos joins hasta ella.
GROUP BY numPedido --Agrupamos la suma de acuerdo a cada pedido.
ORDER BY numPedido; --Los ordenamos ascendentemente por el identificador del pedido.

SELECT gp.taquiClave, nombre, apellidoPaterno, apellidoMaterno, 
       fechaPrimerVista, CONCAT(TRUNC(MONTHS_BETWEEN(CURRENT_DATE,fechaPrimerVista)/12),' años') AS "AñosCliente",
       concat('$', TRUNC(promedioGasto,2)) as "GastoPromedioPedidoCliente" --Lo dejamos con dos decimales y agregamos el signo de pesos.
FROM Cliente cl INNER JOIN 
     (SELECT taquiClave, AVG(pedCost) promedioGasto
      FROM Cliente NATURAL JOIN Pedido NATURAL JOIN PedidosCosto --Usamos la vista creada previamente en la sexta consulta.
      GROUP BY taquiClave) gp --Agrupamos para cada taquiClave para tener por cada cliente.
  ON cl.taquiClave = gp.taquiClave 
WHERE TRUNC(MONTHS_BETWEEN(CURRENT_DATE,fechaPrimerVista)/12) > 3; --Superior a los tres años como cliente.