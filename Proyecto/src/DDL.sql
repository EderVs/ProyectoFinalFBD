##########################################################################
-- Nombre            : ddlTacoste.sql.
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
--                     Oracle, se efectúa la construcción de la base de 
--                     datos de acuerdo con el esquema lógico obtenido 
--                     luego de su normalización a BCNF que siguió de la 
--                     previa abstracción del sistema luego del modelo
--                     conceptual. Se crean a continuación las relaciones
--                     (tablas) y se especifican los distintos atributos con 
--                     sus respectivos dominios.  
##########################################################################
CREATE TABLE Cliente(
        taquiClave INTEGER,
        email VARCHAR2(50),
        telefono VARCHAR2(20),
        nombre VARCHAR2(50),
        apellidoPaterno VARCHAR2(50),
        apellidoMaterno VARCHAR2(50),
        municipio VARCHAR2(100),
        colonia VARCHAR2(100),
        calle VARCHAR2(100),
        CP NUMBER(5),
        numInterior INTEGER,
        numExterior INTEGER,
        fechaPrimerVista DATE,
        numPuntos INTEGER
);

CREATE TABLE Conservar(
        idProducto INTEGER,
        idHistorico INTEGER
);

CREATE TABLE Contener(
        numPedido INTEGER,
        idProducto INTEGER,
        cantidad INTEGER
);

CREATE TABLE CPEdoCliente(
        CP NUMBER(5),
        estado VARCHAR2(100)
);

CREATE TABLE CPEdoEmpleado(
        CP NUMBER(5),
        estado VARCHAR2(100)
);

CREATE TABLE CPEdoProveedor(
        CP NUMBER(5),
        estado varchar2(100)
);

CREATE TABLE CPEdoSucursal(
        CP NUMBER(5),
        estado VARCHAR2(100)
);

CREATE TABLE CURPFnacEmp(
        CURP CHAR(18),
        fechaNac DATE
);

CREATE TABLE FechaPedPromo(
        fechaPedido DATE,
        promocion VARCHAR2(50)
);

CREATE TABLE Dirigir(
        idSucursal INTEGER,
        taquiClave INTEGER,
        fechaInicio DATE
);

CREATE TABLE Empleado(
        taquiClave INTEGER,
        idSucursal INTEGER,
        salario FLOAT(2),
        email VARCHAR2(50),
        telefono VARCHAR2(20),
        nombre VARCHAR2(50),
        apellidoPaterno VARCHAR2(50),
        apellidoMaterno VARCHAR2(50),
        municipio VARCHAR2(100),
        colonia VARCHAR2(100),
        calle VARCHAR2(100),
        CP NUMBER(5),
        numInterior INTEGER,
        numExterior INTEGER,
        CURP CHAR(18),
        RFC CHAR(13),
        tipo VARCHAR2(40),
        tipoSangre varchar2(5),
        numEmergencia VARCHAR2(20),
        fechaContratacion DATE
);

CREATE TABLE Historico(
        idHistorico INTEGER,
        idProducto INTEGER,
        fechaActualizacion DATE,
        precioPrevio FLOAT(2),
        precioNuevo FLOAT(2)
);

CREATE TABLE Ingrediente(
        idIngrediente INTEGER,
        nombre VARCHAR2(50),
        marca VARCHAR2(60),
        cantidadExistencia FLOAT(3),
        fechaCaducidad DATE
);

CREATE TABLE Licencia(
        taquiClave INTEGER,
        codigo VARCHAR2(30)
);

CREATE TABLE Llevar(
        taquiClave INTEGER,
        numPedido INTEGER
);

CREATE TABLE Mobiliario(
        idMueble INTEGER,
        tipo VARCHAR2(30)
);

CREATE TABLE Pedido(
        numPedido INTEGER,
        idSucursal INTEGER,
        fechaPedido DATE,
        taquiClave INTEGER,
        metodoPago VARCHAR2(50)
);

CREATE TABLE Poseer(
        taquiClave INTEGER,
        idTransporte INTEGER
);

CREATE TABLE Producto(
        idProducto INTEGER,
        puntosOtorgar INTEGER,
        nombre varchar2(70),
        precio FLOAT(2),
        taquegoria VARCHAR2(50)
);

CREATE TABLE ProductoLeyenda(
        idProducto INTEGER,
        leyenda VARCHAR2(50)
);

CREATE TABLE Proveedor(
        RFC CHAR(13),
        razonSocial VARCHAR2(100),
        inicioRelacion DATE,
        email VARCHAR2(50),
        telefono VARCHAR2(20),
        municipio VARCHAR2(100),
        colonia VARCHAR2(100),
        calle VARCHAR2(100),
        CP NUMBER(5),
        numInterior INTEGER,
        numExterior INTEGER
);

CREATE TABLE ProveerIng(
        RFC CHAR(13),
        idIngrediente INTEGER,
        precio FLOAT(2)
);

CREATE TABLE ProveerMob(
        RFC CHAR (13),
        idMueble INTEGER,
        precio FLOAT(2)
);
CREATE TABLE Recomendar(
        idProducto INTEGER,
        idProductoSalsa INTEGER
);

CREATE TABLE Salsa(
        idProducto INTEGER,
        presentacion VARCHAR2(70),
        scoville VARCHAR2(20)
);

CREATE TABLE Sucursal(
        idSucursal INTEGER,
        horaApertura TIMESTAMP,
        horaCierre TIMESTAMP,
        municipio VARCHAR2(100),
        colonia VARCHAR2(100),
        calle VARCHAR2(100),
        CP NUMBER(5),
        numInterior INTEGER,
        numExterior INTEGER
);

CREATE TABLE SucursalTelefono(
        idSucursal INTEGER,
        telefono VARCHAR2(20)
);

CREATE TABLE Supervisar(
        taquiClaveGerente INTEGER,
        taquiClaveSupervisado INTEGER
);

CREATE TABLE TacoRider(
        taquiClave INTEGER,
        estaDisponible NUMBER(1)
);

CREATE TABLE Tener(
        idProducto INTEGER,
        idIngrediente INTEGER,
        cantidad FLOAT(3)
);

CREATE TABLE Transporte(
        idTransporte INTEGER,
        tipo VARCHAR2(50),
        marca VARCHAR2(55),
        modelo VARCHAR2(70)
);