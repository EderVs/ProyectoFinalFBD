-- ##########################################################################
-- Nombre            : trigger_taquegoria.sql.
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

create or replace trigger categorias
after insert or update of nombre,idProducto on producto
for each row
declare 
        nom varchar2(100); -- Aquí metemos el nombre del producto.
        salsa_count integer;
begin  
        nom := :new.nombre; -- Se efectúa un análisis de casos exhaustivo para saber qué taquegoría ponerle al producto en cada escenario.
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
          insert into categoria(idProducto,taqueGoria) values(:new.idProducto, 'SALSAS');  -- En cualquier otro caso, se tratará de una salsa.
    end if;
end;
