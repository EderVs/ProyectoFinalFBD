
create or replace trigger actualiza_historico
after insert or update on producto
for each row
	insert into historico values(to_char(:new.idProducto)||to_char(current_date)||to_char(:new.precio), :new.idProducto,
	                               current_date,:new.precio);