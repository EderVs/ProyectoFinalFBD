-- ##########################################################################
-- Nombre            : DDL_borrado.sql.
-- Fecha             : 12 de enero del 2018.
-- Autores           : Flores Martínez Andrés, 
--                     Vázquez Salcedo Eduardo Eder,
--                     Sánchez Pérez Pedro Juan Salvador,
--                     Concha Vázquez Miguel.
-- Compañía          : Computólogos A.C., Facultad de Ciencias UNAM.
-- Cliente           : Taquería Tacoste.
-- ========================================================================
-- Propósito         : A través de las sentencias del lenguje de definición 
--                     de datos (DDL, "Data Definition Language") del SMBD
--                     Oracle se hace el borrado de las tablas creadas. 
--                     Más aún, se hace el borrado de los disparadores y 
--                     procedimientos almacenados creados anteriormente.
-- ##########################################################################

/**
  * Borrado de disparadores ("triggers").
*/
DROP TRIGGER actualiza_historico; 
DROP SEQUENCE hist_seq;
DROP TRIGGER update_puntos_cliente;
DROP TRIGGER categorias;
DROP trigger update_fecha_promocion;
DROP trigger update_ingredientes;
DROP TRIGGER salsa_aux_trigger;
DROP SEQUENCE salsa_seq;
DROP SEQUENCE cont_seq;


/**
  * Borrado de procedimientos almacenados ("stored procedures").
*/
DROP PROCEDURE elimina_caducos;  
DROP PROCEDURE inc_sal;


/**
  * Borrado de tablas.
*/
DROP TABLE Categoria;
DROP TABLE Recomendar;
DROP TABLE Tener;
DROP TABLE ProveerMob;
DROP TABLE ProveerIng;
DROP TABLE Conservar;
DROP TABLE Contener;
DROP TABLE Dirigir;
DROP TABLE Supervisar;
DROP TABLE Poseer;
DROP TABLE Licencia;
DROP TABLE Llevar;
DROP TABLE TacoRider;
DROP TABLE Proveedor;
DROP TABLE Transporte;
DROP TABLE Mobiliario;
DROP TABLE Salsa;
DROP TABLE Ingrediente;
DROP TABLE Historico;
DROP TABLE ProductoLeyenda;
DROP TABLE Producto;
DROP TABLE Pedido;
DROP TABLE FechaPedPromo;
DROP TABLE Empleado;
DROP TABLE CURPFnacEmp;
DROP TABLE CPEdoEmpleado;
DROP TABLE Cliente;
DROP TABLE CPEdoCliente;
DROP TABLE SucursalTelefono;
DROP TABLE Sucursal;
DROP TABLE CPEdoProveedor;
DROP TABLE CPEdoSucursal;
DROP TABLE contener_django; --Tabla auxiliar necesario por la aplicación.