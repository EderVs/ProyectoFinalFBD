-- ##########################################################################
-- Nombre            : trigger_taquegoria_salsa.sql.
-- Fecha             : 12 de enero del 2018.
-- Autores           : Flores Martínez Andrés, 
--                     Vázquez Salcedo Eduardo Eder,
--                     Sánchez Pérez Pedro Juan Salvador,
--                     Concha Vázquez Miguel.
-- Compañía          : Computólogos A.C., Facultad de Ciencias UNAM.
-- Cliente           : Taquería Tacoste.
-- ========================================================================
-- Propósito         : Se crea un disparador porque deseamos colocar cada
--                     producto en su categoría adecuada de acuerdo con el 
--                     menú de la Taquería Tacoste.
-- ##########################################################################

CREATE TABLE Salsa_aux( --Tabla auxiliar para las salsas que más tarde renombramos.
        idProducto INTEGER NOT NULL,
        presentacion VARCHAR2(70) NOT NULL,
        scoville VARCHAR2(20) NOT NULL
);

create table Recomendar_aux( --Tabla auxiliar para las recomendaciones que más tarde renombramos.
    idProducto INTEGER NOT NULL,
    idProductoSalsa INTEGER NOT NULL
);

create sequence salsa_seq start with 1; -- Creamos una secuencia para el disparador.

create or replace trigger salsa_aux_trigger
after insert or update on salsa
for each row
declare 
        salsa_count integer;
        salsaid integer;
        productoid integer;
begin  
        select salsa_seq.nextval --Tomamos el siguiente valor de la secuencia y se lo damos al contador de salsa.
        into salsa_count
        from dual; 
        select idProducto into salsaid from 
        (select idProducto from (select *  from producto natural join categoria where taqueGoria = 'SALSAS' ) where rownum <salsa_count+1 -- Truco para seleccionar la n-ésima tupla.
        MINUS
        select idProducto from (select *  from producto natural join categoria where taqueGoria = 'SALSAS' ) where rownum <salsa_count);
        insert into salsa_aux(idProducto, presentacion, scoville) values (salsaid, :new.presentacion, :new.scoville);
        -- Aquí recomendamos cosas que realmente sean productos por parte de las salsas.
        select idProducto into productoid from 
        (select idProducto from (select *  from producto natural join categoria where taqueGoria <> 'SALSAS') where rownum <salsa_count+1 -- Truco para seleccionar la n-ésima tupla.
        MINUS
        select idProducto from (select *  from producto natural join categoria where taqueGoria <>  'SALSAS') where rownum <salsa_count);
        insert into recomendar_aux(idProducto,idProductoSalsa) values (productoid, salsaid);
end;