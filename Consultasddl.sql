/*El producto más vendido en la taquería y su número de ventas.*/
SELECT Nombre, TaqueGoria, idProducto, Ventas
FROM (SELECT *
        FROM (SELECT SUM(cantidad) AS Ventas, idProducto --Vemos la suma de los productos.
                FROM Contener
                GROUP BY idProducto
                ORDER BY Ventas desc) --Los ordenamos descendentemente.
        WHERE ROWNUM = 1) NATURAL JOIN Producto; --Elegimos la primer tupla y hacemos el join con la tabla Producto.
        
/*La Salsa mas picosa y que aparte es la mas vendida*/
SELECT *
FROM(SELECT idProducto, nombreSalsa, Presentacion, scoville, precio, ventas
        FROM (SELECT SUM(cantidad) AS ventas, idProducto
                FROM contener
                GROUP BY idProducto) a INNER JOIN (SELECT id, nombreSalsa, presentacion, scoville, precio
                                                    FROM (SELECT idProducto AS id, nombre AS nombreSalsa, presentacion, scoville
                                                    FROM Salsa
                                                    WHERE scoville = 'EXTREMO') a INNER JOIN Producto b ON a.id = b.idProducto) b
                                                    ON a.idProducto = b.id
        ORDER BY ventas desc)
WHERE ROWNUM = 1;
        
/*El Cliente que ha echo mas pedidos en Tacost*/
SELECT * 
FROM
    (SELECT * 
     FROM (SELECT COUNT(taquiClave) AS Pedidos, taquiClave
           FROM Pedido
           GROUP BY taquiClave
           ORDER BY Pedidos desc)
    WHERE ROWNUM = 1) NATURAL JOIN Cliente;

/*TacoRiders que son O+ y que manejen en bicicleta*/
SELECT *
FROM (SELECT *
        FROM TacoRider NATURAL JOIN Poseer NATURAL JOIN Transporte
        WHERE tipo = 'BICICLETA') a INNER JOIN Empleado b ON a.taquiClave = b.taquiClave
WHERE tipoSangre = 'O+';

/*Gerentes que supervisen a al menos un TacoRider que haya llevado un pedido que incluyera una torta
  y que la tercera letra del appelido paterno sea M*/
SELECT taquiClave, nombre, apellidoPaterno
FROM Empleado a INNER JOIN (SELECT DISTINCT taquiClaveGerente
                            FROM Supervisar NATURAL JOIN TacoRider NATURAL JOIN Llevar
                            WHERE numPedido in (SELECT numPedido
                                                FROM Pedido NATURAL JOIN Contener NATURAL JOIN Producto
                                                WHERE taqueGoria = 'TORTAS')) b ON a.taquiClave = b.taquiClaveGerente
WHERE REGEXP_LIKE(apellidoPaterno, '^..m.*');

/*Clientes que en el año 2008 compro QUECAS y pago con CRYPTOCURRENCY */
SELECT idProducto, fechaPedido, metodoPago, taqueGoria, nombre, apellidoPaterno, apellidoMaterno 
FROM (SELECT taquiClave, idProducto, fechaPedido, metodoPago, taqueGoria
        FROM Pedido NATURAL JOIN Contener NATURAL JOIN Producto
        WHERE metodoPago = 'CRYPTOCURRENCY' 
                AND taqueGoria = 'QUECAS'
                AND EXTRACT(YEAR FROM fechaPedido) = 2008) a INNER JOIN Cliente b ON a.taquiClave = b.taquiClave;
                
/*El numero de pagos de cada tipo por sucursal.
  Ej: sucursal_1 : 3 pagos con Debito, 2 con Credito, 4 con Kriptocoins*/
SELECT *
FROM (SELECT idSucursal, metodoPago
        FROM Pedido) r
pivot(COUNT(*) for metodoPago in ('EFECTIVO' as Efectivo,
                                    'TARJETA DEBITO' as TarjetaDebito,
                                    'TARJETA CREDITO' as TarjetaCredito,
                                    'CRYPTOCURRENCY' as Cryptocurrency,
                                    'VALES' as Vales))
ORDER BY idSucursal;

/*Ingrediente que tiene menos proveedores*/
SELECT *
FROM (SELECT *
        FROM (SELECT idIngrediente, count(RFC) as proveedores
                FROM proveerIng
                GROUP BY idIngrediente
                ORDER BY proveedores)
        WHERE ROWNUM = 1) NATURAL JOIN Ingrediente;
        
/*Cantidad de cada tipo de empleado por sucursal*/
SELECT *
FROM (SELECT idSucursal, tipo
        FROM Empleado) r
pivot(COUNT(*) for tipo in ('PARRILLERO' as Parrillero,
                            'TAQUERO' as Taquero,
                            'MESERO' as Mesero,
                            'CAJERO' as Cajero,
                            'TORTILLERO' as Tortillero,
                            'TACORIDER' as TacoRider))
ORDER BY idSucursal;

/**/


