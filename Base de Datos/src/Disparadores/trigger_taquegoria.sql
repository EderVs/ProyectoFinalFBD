create or replace trigger categorias
after insert or update of nombre,idProducto on producto
for each row
declare 
        nom varchar2(100);
        salsa_count integer;
begin  
        nom := :new.nombre;
        if nom in ('Nopal asado','Frijoles refritos','Frijoles refritos con chorizo','Don totopo','Don totopo especial','Cebollitas al carbon','Papas a la francesa','Guacamole','Chicharron de queso','Los sopecitos','Entrada') then
            insert into categoria(idProducto,taqueGoria) values(:new.idProducto, 'ENTRADAS');
        elsif nom in ('Sopa de fideos','Sopa de hongos','Frijoles charros','Consome','Sopa azteca','Arroz a la mexicana','Arroz con mole o huevo','Pozole rojo o blanco') then
                insert into categoria(idProducto,taqueGoria) values(:new.idProducto, 'DEL CAZO');
        elsif nom in ('Sencillo de guisado','Pastor','Bistec, Chuleta, Chorizo o Pollo','Arrachera','Costilla') then
                insert into categoria(idProducto,taqueGoria) values(:new.idProducto, 'SOPES Y HUARACHES');
        elsif nom in ('Verdes, Rojas, Enfrijoladas o Con salsa guajillo con mole') then
                insert into categoria(idProducto,taqueGoria) values(:new.idProducto, 'ENCHILADAS');
        elsif nom in ('Fundido natural','Choriqueso','Chicharron') then
                insert into categoria(idProducto,taqueGoria) values(:new.idProducto, 'QUESOS');
        elsif nom in ('Gringa','Gringa consentida','Gringa vaquera','Gringa loca','Quesadilla tradicional','Quesadilla','Quesadilla especial','Volcanes','Volcanes con carne') then
                insert into categoria(idProducto,taqueGoria) values(:new.idProducto, 'GRINGAS, QUECAS Y VOLCANES');        
        elsif nom in ('De pastor','Vegerariano','De bistec','De chuleta o pollo','De arrachera','De costilla') then
                insert into categoria(idProducto,taqueGoria) values(:new.idProducto, 'ALAMBRES');
        elsif nom in ('Ensalada','De la granja') then
                insert into categoria(idProducto,taqueGoria) values(:new.idProducto, 'ENSALADAS');
        elsif nom in ('El de pastor 2x1','Los de guisado','Bistec','Chuleta','Pechuga de pollo','Pastor de pollo','Chorizo','De Arrachera','De costilla') then
                insert into categoria(idProducto,taqueGoria) values(:new.idProducto, 'TACOS');
        elsif nom in ('100% Pastor','100% Carne de res','100% Pechuga de pollo','100% Arrachera') then
                insert into categoria(idProducto,taqueGoria) values(:new.idProducto, 'HAMBURGUESAS');
        elsif nom in ('Torta de Pastor','Torta de Bistec','Torta de Milanesa','Torta de Arrachera','Torta de Pollo') then
                insert into categoria(idProducto,taqueGoria) values(:new.idProducto, 'TORTAS');
        elsif nom in ('Jarras de agua','Aguas frescas','Refrescos','Jugo de naranja','Naranjada','Cervezas','Micheladas','Cubanas','Cafe americano','Cafe de olla','Cafe capuchino','Chocolate con leche','Te','Cafe con leche','Vaso de leche') then
                insert into categoria(idProducto,taqueGoria) values(:new.idProducto, 'BEBIDAS');
        elsif nom in ('Flan','Pastel') then
                insert into categoria(idProducto,taqueGoria) values(:new.idProducto, 'POSTRES');
        else
          insert into categoria(idProducto,taqueGoria) values(:new.idProducto, 'SALSAS');  
    end if;
end;