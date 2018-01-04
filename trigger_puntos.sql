--deseamos que cada que se haga un pedido, otorguemos sus respectivos puntos (10% de la compra) al cliente que realizó el pedido
create or replace trigger update_puntos_cliente
after insert or update on contener
for each row
declare
	nuevo float(2);
begin
	select total/10 into nuevo 
	from (select precio*:new.cantidad as total
		  from  producto
		  where idProducto = :new.idProducto);
	update cliente
	set numPuntos = numPuntos + nuevo
	where taquiClave = (select taquiClave
						from pedido natural join cliente 
						where numPedido = :new.numPedido);
end;