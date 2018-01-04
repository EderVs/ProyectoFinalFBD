--creamos una secuencia para la llave de cada tupla del histórico
create sequence hist_seq start with 1;

--creamos un trigger que se encargará de colocar el respectivo id a la nueva tupla del histórico
create or replace trigger dept_bir 
before insert on historico 
for each row
--colocamos el nuevo valor de la secuencia como id del nuevo renglón del historico
begin
  select hist_seq.nextval
  into   :new.idhistorico
  from   dual;
end;

--creamos disparador para almacenar la informacion necesaria en el historico
create or replace trigger actualiza_historico
after insert or update on producto
for each row
begin
	insert into historico(idProducto, fechaActualizacion, precioNuevo)
	               values(:new.idProducto, current_date,:new.precio);
end;

/*
INSERT INTO PRODUCTO(IDPRODUCTO, PUNTOSOTORGAR, NOMBRE, PRECIO, TAQUEGORIA) VALUES
(15, 38039, 'Monjectry', 5, 'QUECAS');
select * from historico;
INSERT INTO PEDIDO(NUMPEDIDO, IDSUCURSAL, FECHAPEDIDO, TAQUICLAVE, METODOPAGO) VALUES
(1, 1, TO_DATE('07/03/1986','dd/mm/yyyy'), 7000000016, 'EFECTIVO');
select * from cliente
INSERT INTO CONTENER(NUMPEDIDO, IDPRODUCTO, CANTIDAD) VALUES
(1, 15, 5);
*/