--para poder imprimir en pantalla
set serveroutput on format wrapped;
--procedimiento que elimina aquellos ingredientes que ya caducaron
create or replace procedure elimina_caducos is
	--creamos un cursor de los ingredientes caducados
	cursor a_eliminar_cursor is
		select idIngrediente, nombre
		from ingrediente 
		where fechaCaducidad < current_date;
begin
	--notificamos que ingredientes serán eliminados a la vez que eliminamos cada ingrediente
    dbms_output.put_line('Los siguientes ingredientes están caducados y serán eliminados');
	for c in a_eliminar_cursor loop
		dbms_output.put_line('idIngrediente: '||c.idIngrediente||', nombre: '||c.nombre);
        delete from ingrediente where idIngrediente = c.idIngrediente;
	end loop;
end elimina_caducos;
/*
INSERT INTO INGREDIENTE(IDINGREDIENTE, NOMBRE, MARCA, CANTIDADEXISTENCIA, FECHACADUCIDAD) VALUES
(1, 'Cabtinfiator', 'Union E-Mobile Corporation', 4, TO_DATE('01/01/1970','dd/mm/yyyy'));
INSERT INTO INGREDIENTE(IDINGREDIENTE, NOMBRE, MARCA, CANTIDADEXISTENCIA, FECHACADUCIDAD) VALUES
(2, 'Contoperer', 'WorldWide Wind Power Inc.', 4, TO_DATE('11/09/2982','dd/mm/yyyy'));
INSERT INTO INGREDIENTE(IDINGREDIENTE, NOMBRE, MARCA, CANTIDADEXISTENCIA, FECHACADUCIDAD) VALUES
(3, 'Cleantectefry', 'WorldWide 5D Electronic Inc.', 5, TO_DATE('01/01/2018','dd/mm/yyyy'));
INSERT INTO INGREDIENTE(IDINGREDIENTE, NOMBRE, MARCA, CANTIDADEXISTENCIA, FECHACADUCIDAD) VALUES
(4, 'Monoceivor', 'South Space Research Inc.', 1, TO_DATE('03/09/1979','dd/mm/yyyy'));

execute elimina_caducos;
select * from ingrediente;*/