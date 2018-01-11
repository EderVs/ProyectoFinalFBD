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
-- Propósito         : Se crea un disparador para que la tabla del histórico
--                     de los precios de los productos tenga sentido al ser
--                     actualizados estos mismos.
-- ##########################################################################

-- Creamos una secuencia para la llave de cada tupla del histórico.
create sequence hist_seq start with 1;

-- Creamos el disparador para almacenar la informacion necesaria en el histórico.
create or replace trigger actualiza_historico
after insert or update on producto
for each row
declare
	new_idHistorico integer;
begin
    select hist_seq.nextval --Tenemos el nuevo valor de la secuencia y se lo damos a la variable.
    into new_idHistorico
    from dual; 
    if inserting then --Si hay una inserción de un nuevo producto en la BD:
        insert into historico(idHistorico, idProducto, fechaActualizacion,precioPrevio, precioNuevo)
                       values(new_idHistorico, :new.idProducto, current_date,:new.precio, :new.precio); --Como es la primera vez, el precio previo y nuevo es el mismo.
        insert into conservar(idHistorico, idProducto)  --Hacemos el cambio en la tabla de Conservar.
                       values(new_idHistorico, :new.idProducto);
    elsif updating then --En cambio, si solamente se modifica el precio de un producto:
         insert into historico(idHistorico, idProducto, fechaActualizacion,precioPrevio, precioNuevo) --Hacemos el cambio en la tabla Histórico.
                       values(new_idHistorico, :new.idProducto, current_date,:old.precio, :new.precio); --Tenemos acceso al precio previo y al nuevo.
        insert into conservar(idHistorico, idProducto) --Hacemos el cambio en la tabla de Conservar.
                       values(new_idHistorico, :new.idProducto);
    end if;
end;

--Ejemplos:
/*
INSERT INTO PRODUCTO(IDPRODUCTO, PUNTOSOTORGAR, NOMBRE, PRECIO, TAQUEGORIA) VALUES
(15, 38039, 'Monjectry', 5, 'QUECAS');
select * from historico;
select * from conservar;
*/