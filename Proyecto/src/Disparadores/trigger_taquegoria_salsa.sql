CREATE TABLE Salsa_aux(
        idProducto INTEGER NOT NULL,
        presentacion VARCHAR2(70) NOT NULL,
        scoville VARCHAR2(20) NOT NULL
);

create table Recomendar_aux(
    idProducto INTEGER NOT NULL,
    idProductoSalsa INTEGER NOT NULL
);

create sequence salsa_seq start with 1;

create or replace trigger salsa_aux_trigger
after insert or update on salsa
for each row
declare 
        salsa_count integer;
        salsaid integer;
        productoid integer;
begin  
        select salsa_seq.nextval
        into salsa_count
        from dual; 
        select idProducto into salsaid from 
        (select idProducto from (select *  from producto natural join categoria where taqueGoria = 'SALSAS' ) where rownum <salsa_count+1
        MINUS
        select idProducto from (select *  from producto natural join categoria where taqueGoria = 'SALSAS' ) where rownum <salsa_count);
        insert into salsa_aux(idProducto, presentacion, scoville) values (salsaid, :new.presentacion, :new.scoville);
        --aqui recomendamos cosas para las salsas
        select idProducto into productoid from 
        (select idProducto from (select *  from producto natural join categoria where taqueGoria <> 'SALSAS') where rownum <salsa_count+1
        MINUS
        select idProducto from (select *  from producto natural join categoria where taqueGoria <>  'SALSAS') where rownum <salsa_count);
        insert into recomendar(idProducto,idProductoSalsa) values (productoid, salsaid);
end;
