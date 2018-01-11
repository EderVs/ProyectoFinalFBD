-- ##########################################################################
-- Nombre            : trigger_ingredientes.sql.
-- Fecha             : 12 de enero del 2018.
-- Autores           : Flores Martínez Andrés, 
--                     Vázquez Salcedo Eduardo Eder,
--                     Sánchez Pérez Pedro Juan Salvador,
--                     Concha Vázquez Miguel.
-- Compañía          : Computólogos A.C., Facultad de Ciencias UNAM.
-- Cliente           : Taquería Tacoste.
-- ========================================================================
-- Propósito         : Deseamos que cada que se haga un producto (lo cual sabemos 
--                     cuando se agrega un elemento a contener) actualicemos la 
--                     cantidad en existencia de dicho ingrediente, además
--                     verificaremos si es posible realizar todo el pedido con
--                     la cantidad de ingredientes en almacén.
-- ##########################################################################

create or replace trigger update_ingredientes
-- En la tabla contener agregamos los productos y su respectiva cantidad de cada pedido,
-- por lo cual cada que agreguemos un producto restamos la cantidad de ingredientes utilizadas para dicho producto.
after insert or update on contener
for each row
declare
	c float(3);
	possible number(1);
	-- Agrupamos por ingrediente la cantidad necesaria para realizar todo el pedido.
	cursor my_query is select idIngrediente, sum(:new.cantidad*t.cantidad) as cant
                       from producto p, tener t
                       where :new.idProducto = p.idProducto and p.idProducto = t.idProducto
                       group by idIngrediente;
    esc_ing varchar2(50);
begin
	possible := 1;
    -- Verificamos si la cantidad de cada ingrediente alcanza para realizar todo el pedido.
	for ingcan in my_query
	LOOP
		-- Almacenamos en la variable la cantidad en existencia del ingrediente actual en la iteración.
		select cantidadExistencia into c
		from (select cantidadExistencia from ingrediente where ingcan.idIngrediente = idIngrediente);
		-- Si se necesita más ingrediente del disponible para algún ingrediente, reportamos un error.
		if ingcan.cant > c then
			select nombre into esc_ing 
			from (select nombre from ingrediente where ingcan.idIngrediente = idIngrediente);
			possible := 0;
			exit;
		end if;
	end LOOP;
    -- Reportamos error:
	if possible = 0 then 
		raise_application_error(-20003,'La cantidad en existencia del ingrediente '||esc_ing||' no es suficiente para realizar el pedido.');
	-- Si hay suficientes ingredientes para todos los productos entonces los utilizamos y actualizamos la cantidad en existencia.
	else
		for ingcan in my_query
		LOOP
			update ingrediente
			set cantidadExistencia = cantidadExistencia - ingcan.cant
			where idIngrediente = ingcan.idIngrediente;
		end LOOP;
	end if;	
end;

-- Ejemplos:
/*
INSERT INTO SUCURSAL(IDSUCURSAL, HORAAPERTURA, HORACIERRE, MUNICIPIO, COLONIA, CALLE, CP, NUMINTERIOR, NUMEXTERIOR) VALUES
(1, TO_TIMESTAMP ('10-Sep-02 11:10:10.123000', 'DD-Mon-RR HH24:MI:SS.FF'),TO_TIMESTAMP ('10-Sep-02 14:10:10.123000', 'DD-Mon-RR HH24:MI:SS.FF'), 'Elkland', 'Fakenham', '1954 Monument Road', 0, 95, 3914);
INSERT INTO CLIENTE(TAQUICLAVE, EMAIL, TELEFONO, NOMBRE, APELLIDOPATERNO, APELLIDOMATERNO, MUNICIPIO, COLONIA, CALLE, CP, NUMINTERIOR, NUMEXTERIOR, FECHAPRIMERVISTA, NUMPUNTOS) VALUES
(7000000016, 'RhonaArriaga@example.com', '(342) 816-0981', 'Avelina', 'Mccray', 'Laster', 'Medical Lake', 'Bristol', '96 Glenwood Pkwy', 25, 22, 1876, TO_DATE('07/03/1986','dd/mm/yyyy'), 0);
INSERT INTO PEDIDO(NUMPEDIDO, IDSUCURSAL, FECHAPEDIDO, TAQUICLAVE, METODOPAGO) VALUES
(1, 1, TO_DATE('06/01/2006','dd/mm/yyyy'), 7000000016, 'EFECTIVO');
INSERT INTO PRODUCTO(IDPRODUCTO, PUNTOSOTORGAR, NOMBRE, PRECIO, TAQUEGORIA) VALUES
(15, 38039, 'Monjectry', 5, 'QUECAS');
INSERT INTO INGREDIENTE(IDINGREDIENTE, NOMBRE, MARCA, CANTIDADEXISTENCIA, FECHACADUCIDAD) VALUES
(1, 'Cabtinfiator', 'Union E-Mobile Corporation', 9.003, TO_DATE('01/01/1970','dd/mm/yyyy'));
INSERT INTO INGREDIENTE(IDINGREDIENTE, NOMBRE, MARCA, CANTIDADEXISTENCIA, FECHACADUCIDAD) VALUES
(2, 'Contoperer', 'WorldWide Wind Power Inc.', 4.002, TO_DATE('01/01/1970','dd/mm/yyyy'));
select * from ingrediente;
INSERT INTO TENER(IDPRODUCTO, IDINGREDIENTE, CANTIDAD) VALUES
(15, 1, 1.32);
INSERT INTO TENER(IDPRODUCTO, IDINGREDIENTE, CANTIDAD) VALUES
(15, 2, 0.54);
INSERT INTO CONTENER(NUMPEDIDO, IDPRODUCTO, CANTIDAD) VALUES
(1, 15, 10);
select * from ingrediente;
*/
