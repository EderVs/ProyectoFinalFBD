create or replace trigger categorias
after insert or update of nombre,idProducto on producto
for each row
declare 
        nom varchar2(20);
        salsa_count integer;
begin  
        nom := :new.nombre;
        if nom in ('Nopal asado','Frijoles refritos','Frijoles refritos con chorizo','Don totopo','Don totopo especial','Cebollitas al carbon','Papas a la francesa','Guacamole','Chicharron de queso','Los sopecitos','Entrada') then
            insert into categoria(idProducto,taquegoria) values(:new.idProducto, 'ENTRADAS');
        elsif nom in ('Sopa de fideos','Sopa de hongos','Frijoles charros','Consome','Sopa azteca','Arroz a la mexicana','Arroz con mole o huevo','Pozole rojo o blanco') then
                insert into categoria(idProducto,taquegoria) values(:new.idProducto, 'DEL CAZO');
        elsif nom in ('Sencillo de guisado','Pastor','Bistec, Chuleta, Chorizo o Pollo','Arrachera','Costilla') then
                insert into categoria(idProducto,taquegoria) values(:new.idProducto, 'SOPES Y HUARACHES');
        elsif nom in ('Verdes, Rojas, Enfrijoladas o Con salsa guajillo con mole') then
                insert into categoria(idProducto,taquegoria) values(:new.idProducto, 'ENCHILADAS');
        elsif nom in ('Fundido natural','Choriqueso','Chicharron de queso') then
                insert into categoria(idProducto,taquegoria) values(:new.idProducto, 'QUESOS');
        elsif nom in ('Gringa','Gringa consentida','Gringa vaquera','Gringa loca','Quesadilla tradicional','Quesadilla','Quesadilla especial','Volcanes','Volcanes con carne') then
                insert into categoria(idProducto,taquegoria) values(:new.idProducto, 'GRINGAS, QUECAS Y VOLCANES');        
        elsif nom in ('De pastor','Vegerariano','De bistec','De chuleta o pollo','De arrachera','De costilla') then
                insert into categoria(idProducto,taquegoria) values(:new.idProducto, 'ALAMBRES');
        elsif nom in ('Ensalada','De la granja') then
                insert into categoria(idProducto,taquegoria) values(:new.idProducto, 'ENSALADAS');
        elsif nom in ('El de pastor 2x1','Los de guisado','Bistec','Chuleta','Pechuga de pollo','Pastor de pollo','Chorizo','De Arrachera','De costilla') then
                insert into categoria(idProducto,taquegoria) values(:new.idProducto, 'TACOS');
        elsif nom in ('100% Pastor','100% Carne de res','100% Pechuga de pollo','100% Arrachera') then
                insert into categoria(idProducto,taquegoria) values(:new.idProducto, 'HAMBURGUESAS');
        elsif nom in ('Torta de Pastor','Torta de Bistec','Torta de Milanesa','Torta de Arrachera','Torta de Pollo') then
                insert into categoria(idProducto,taquegoria) values(:new.idProducto, 'TORTAS');
        elsif nom in ('Jarras de agua','Aguas frescas','Refrescos','Jugo de naranja','Naranjada','Cervezas','Micheladas','Cubanas','Cafe americano','Cafe de olla','Cafe capuchino','Chocolate con leche','Te','Cafe con leche','Vaso de leche') then
                insert into categoria(idProducto,taquegoria) values(:new.idProducto, 'BEBIDAS');
        elsif nom in ('Flan','Pastel') then
                insert into categoria(idProducto,taquegoria) values(:new.idProducto, 'POSTRES');
        else
          insert into categoria(idProducto,taquegoria) values(:new.idProducto, 'SALSAS');
    end if;
end;

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
        (select idProducto from (select idProducto from (producto natural join categoria) where taquegoria = 'SALSAS' ) where rownum <salsa_count+1
        MINUS
        select idProducto from (select idProducto from (producto natural join categoria) where taquegoria = 'SALSAS' ) where rownum <salsa_count);
        insert into salsa_aux(idProducto, presentacion, scoville) values (salsaid, :new.presentacion, :new.scoville);
        --aqui recomendamos cosas para las salsas
        select idProducto into productoid from 
        (select idProducto from (select idProducto from (producto natural join categoria) where taquegoria <> 'SALSAS' ) where rownum <salsa_count+1
        MINUS
        select idProducto from (select idProducto from (producto natural join categoria) where taquegoria <> 'SALSAS' ) where rownum <salsa_count);
        insert into recomendar_aux(idProducto,idProductoSalsa) values (productoid, salsaid);
end;