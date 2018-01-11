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
-- Propósito         : Se crea un disparador debido a que deseamos que cada 
--                     que se haga un pedido, otorguemos sus respectivos puntos
--                    (10% de la compra) al cliente que realizó el pedido.
-- ##########################################################################

create table contener_aux(
    numPedido integer,
    idProducto integer,
    cantidad integer,
    idContener integer PRIMARY KEY
);

create table contener_Django(
    numPedido integer,
    idProducto integer,
    cantidad integer,
    idContener integer PRIMARY KEY
);

create sequence cont_seq start with 1;
--deseamos que cada que se haga un pedido, otorguemos sus respectivos puntos (10% de la compra) al cliente que realiz³ el pedido
create or replace trigger update_puntos_cliente
--en la tabla contener agregamos los productos y su respectiva cantidad de cada pedido
--por lo cual cada que agreguemos un producto calculamos los puntos que se otorgarn y lo sumamos al respectivo cliente
after insert or update on contener
for each row
declare
	nuevo float; --el valor donde almacenaremos la cantidad de puntos a incrementar
    idcont integer; --var de hack
    cont_aux integer;
begin
	select total/10 into nuevo 
	from (select precio*:new.cantidad as total --calculamos el costo total de producto, y metemos el 10% a nuevo
		  from  producto
		  where idProducto = :new.idProducto);
	update cliente --actualizamos el nÃºmero de puntos del cliente
	set numPuntos = numPuntos + nuevo
	where taquiClave = (select taquiClave
						from pedido natural join cliente 
						where numPedido = :new.numPedido);
                        --HACK--
    select cont_seq.nextval
    into cont_aux
    from dual; 
    select idContener into idCont
    from Contener_aux 
    where idContener = cont_aux;
    insert into contener_Django(numPedido, idProducto, cantidad, idContener) values (:new.numPedido, :new.idProducto, :new.cantidad, idCont);
end;

select *
from pedido natural join cliente 
where numPedido = 46;

select *
	from (select *--calculamos el costo total de producto, y metemos el 10% a nuevo
		  from  producto
		  where idProducto = 40);
