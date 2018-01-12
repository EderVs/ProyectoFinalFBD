-- ##########################################################################
-- Nombre            : sp_incrementa_salario.sql.
-- Fecha             : 12 de enero del 2018.
-- Autores           : Flores Martínez Andrés, 
--                     Vázquez Salcedo Eduardo Eder,
--                     Sánchez Pérez Pedro Juan Salvador,
--                     Concha Vázquez Miguel.
-- Compañía          : Computólogos A.C., Facultad de Ciencias UNAM.
-- Cliente           : Taquería Tacoste.
-- ========================================================================
-- Propósito         : Se crea un un procedimiento almacenado que será una función
--                     cuyo proósito será el de incrementar el sueldo de los empleados
--                     en un porcentaje dado. Será útil debido a la continua
--                     inflación monetaria.
-- ##########################################################################

create or replace procedure inc_sal(inc float) is --Le pasamos el porcentaje de incremento.
begin
	update empleado
	set salario = salario + salario*inc; --El salario actual del Empleado tiene que ser lo que era sumado en el salario por el incremento dado.
end inc_sal;

-- Ejemplos: 
/*INSERT INTO SUCURSAL(IDSUCURSAL, HORAAPERTURA, HORACIERRE, MUNICIPIO, COLONIA, CALLE, CP, NUMINTERIOR, NUMEXTERIOR) VALUES
(1, TO_DATE('02/12/1977','dd/mm/yyyy'), TO_DATE('03/12/1977','dd/mm/yyyy'), 'Elkland', 'Fakenham', '1954 Monument Road', 0, 95, 3914);
INSERT INTO EMPLEADO(TAQUICLAVE, IDSUCURSAL, SALARIO, EMAIL, TELEFONO, NOMBRE, APELLIDOPATERNO, APELLIDOMATERNO, MUNICIPIO, COLONIA, CALLE, CP, NUMINTERIOR, NUMEXTERIOR, CURP, RFC, TIPO, TIPOSANGRE, NUMEMERGENCIA, FECHACONTRATACION) VALUES
(805441, 1, 8.54, 'Rosy.OMorrow@example.com', '(861) 905-3386', 'Buster', 'Deluca', 'Barr', 'Murdock', 'Lancaster', '90th FL', 0, 39, 4519, 0, 'SX 62 72 40 B', 'PARRILLERO', 'O-', '(406) 932-6328', TO_DATE('01/10/1970','dd/mm/yyyy'));
INSERT INTO EMPLEADO(TAQUICLAVE, IDSUCURSAL, SALARIO, EMAIL, TELEFONO, NOMBRE, APELLIDOPATERNO, APELLIDOMATERNO, MUNICIPIO, COLONIA, CALLE, CP, NUMINTERIOR, NUMEXTERIOR, CURP, RFC, TIPO, TIPOSANGRE, NUMEMERGENCIA, FECHACONTRATACION) VALUES
(1000805442, 1, 12.544, 'LeenaD.Crook368@nowhere.com', '(518) 934-2749', 'Gilbert', 'Clifford', 'Carder', 'Avoca', 'Strathaven', '93th Floor', 1, 98, 1551, 1, 'HX 09 98 55 D', 'CAJERO', 'A-', '(716) 657-7324', TO_DATE('12/01/1975','dd/mm/yyyy'));
INSERT INTO EMPLEADO(TAQUICLAVE, IDSUCURSAL, SALARIO, EMAIL, TELEFONO, NOMBRE, APELLIDOPATERNO, APELLIDOMATERNO, MUNICIPIO, COLONIA, CALLE, CP, NUMINTERIOR, NUMEXTERIOR, CURP, RFC, TIPO, TIPOSANGRE, NUMEMERGENCIA, FECHACONTRATACION) VALUES
(6232990399, 1, 2.456, 'MerrieI.Seals@example.com', '(454) 654-8717', 'Wendell', 'Gandy', 'Smalls', 'Howard Lake', 'Dromore (Co Down)', '89th FL', 2, 97, 1940, 2, 'BH 12 01 20 A', 'TAQUERO', 'O+', '(525) 709-9587', TO_DATE('02/12/1977','dd/mm/yyyy'));
select * from empleado;
execute inc_sal(0.15);
select * from empleado;
/*