-- ##########################################################################
-- Nombre            : trigger_puntos.sql.
-- Fecha             : 12 de enero del 2018.
-- Autores           : Flores Martínez Andrés, 
--                     Vázquez Salcedo Eduardo Eder,
--                     Sánchez Pérez Pedro Juan Salvador,
--                     Concha Vázquez Miguel.
-- Compañía          : Computólogos A.C., Facultad de Ciencias UNAM.
-- Cliente           : Taquería Tacoste.
-- ========================================================================
-- Propósito         : Se crea un disparador porque deseamos que cada que se haga 
--                     un pedido, otorguemos sus respectivos puntos (10% de la compra)
--                     al cliente que realizó el pedido.
-- ##########################################################################

-- Necesario por la aplicación web.
create table contener_Django(
    numPedido integer,
    idProducto integer,
    cantidad integer,
    idContener integer PRIMARY KEY
);

-- Ponemos las restricciones.
ALTER TABLE contener_Django ADD CONSTRAINT fk_numPedido_django FOREIGN KEY(numPedido) REFERENCES Pedido(numPedido) ON DELETE CASCADE;
ALTER TABLE contener_Django ADD CONSTRAINT fk_idProducto_django FOREIGN KEY(idProducto) REFERENCES Producto(idProducto) ON DELETE CASCADE;
create sequence cont_seq start with 1; --Creamos una secuencia para el disparador.

create or replace trigger update_puntos_cliente
-- En la tabla contener agregamos los productos y su respectiva cantidad de cada pedido.
-- Por lo cual cada que agreguemos un producto calculamos los puntos que se otorgan y lo sumamos al respectivo cliente.
after insert or update on contener
for each row
declare
	nuevo float; -- El valor donde almacenaremos la cantidad de puntos a incrementar.
    cont_aux integer;
begin
	select total/10 into nuevo 
	from (select precio*:new.cantidad as total -- Calculamos el costo total de producto, y metemos el 10% a nuevo
		  from  producto
		  where idProducto = :new.idProducto);
	update cliente -- Actualizamos el número de puntos del cliente.
	set numPuntos = numPuntos + nuevo
	where taquiClave = (select taquiClave
						from pedido natural join cliente 
						where numPedido = :new.numPedido);
                        --HACK--
    select cont_seq.nextval
    into cont_aux
    from dual; 
    insert into contener_Django(numPedido, idProducto, cantidad, idContener) values (:new.numPedido, :new.idProducto, :new.cantidad, cont_aux);
end;
