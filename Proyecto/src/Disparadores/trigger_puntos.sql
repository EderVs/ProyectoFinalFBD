--deseamos que cada que se haga un pedido, otorguemos sus respectivos puntos (10% de la compra) al cliente que realizó el pedido
create or replace trigger update_puntos_cliente
--en la tabla contener agregamos los productos y su respectiva cantidad de cada pedido
--por lo cual cada que agreguemos un producto calculamos los puntos que se otorgarán y lo sumamos al respectivo cliente
after insert or update on contener
for each row
declare
	nuevo float(2); --el valor donde almacenaremos la cantidad de puntos a incrementar
begin
	select total/10 into nuevo 
	from (select precio*:new.cantidad as total --calculamos el costo total de producto, y metemos el 10% a nuevo
		  from  producto
		  where idProducto = :new.idProducto);
	update cliente --actualizamos el número de puntos del cliente
	set numPuntos = numPuntos + nuevo
	where taquiClave = (select taquiClave
						from pedido natural join cliente 
						where numPedido = :new.numPedido);
end;

