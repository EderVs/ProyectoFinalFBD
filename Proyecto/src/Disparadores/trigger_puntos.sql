-- ##########################################################################
-- Nombre            : trigger_histórico.sql.
-- Fecha             : 12 de enero del 2018.
-- Autores           : Flores Martínez Andrés, 
--                     Vázquez Salcedo Eduardo Eder,
--                     Sánchez Pérez Pedro Juan Salvador,
--                     Concha Vázquez Miguel.
-- Compañía          : Computólogos A.C., Facultad de Ciencias UNAM.
-- Cliente           : Taquería Tacoste.
-- ========================================================================
-- Propósito         : Se crea un disparador debido a que deseamos que cada 
--                     que se haga un pedido, otorguemos sus respectivos puntos
--                    (10% de la compra) al cliente que realizó el pedido.
-- ##########################################################################

create or replace trigger update_puntos_cliente
-- En la tabla contener agregamos los productos y su respectiva cantidad de cada pedido,
-- por lo cual cada que agreguemos un producto calculamos los puntos que se otorgarán y lo sumamos al respectivo cliente.
after insert or update on contener
for each row
declare
	nuevo float(2); -- El valor donde almacenaremos la cantidad de puntos a incrementar.
begin
	select cast(total as float)/cast(10 as float) into nuevo
	from (select precio*:new.cantidad as total -- Calculamos el costo total de producto, y metemos el 10% a nuevo.
		  from  producto
		  where idProducto = :new.idProducto);
	update cliente -- Actualizamos el número de puntos del cliente.
	set numPuntos = numPuntos + nuevo
	where taquiClave = (select taquiClave
						from pedido natural join cliente 
						where numPedido = :new.numPedido);
end;