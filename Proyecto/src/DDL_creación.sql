##########################################################################
-- Nombre            : DDL_creación.sql.
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
--                     Se resuelve la integridad de dominios de marca nulos
--                     al especificar que no son aceptador al ser sujetos
--                     a potenciales ambigüedades.
##########################################################################

CREATE TABLE Categoria(
        idProducto INTEGER NOT NULL,
        taquegoria VARCHAR2(200) NOT NULL
);

CREATE TABLE Cliente(
        taquiClave INTEGER NOT NULL,
        email VARCHAR2(50) NOT NULL,
        telefono VARCHAR2(20) NOT NULL,
        nombre VARCHAR2(50) NOT NULL,
        apellidoPaterno VARCHAR2(50) NOT NULL,
        apellidoMaterno VARCHAR2(50) NOT NULL,
        municipio VARCHAR2(100) NOT NULL,
        colonia VARCHAR2(100) NOT NULL,
        calle VARCHAR2(100) NOT NULL,
        CP NUMBER(5) NOT NULL,
        numInterior INTEGER NOT NULL,
        numExterior INTEGER NOT NULL,
        fechaPrimerVista DATE NOT NULL,
        numPuntos INTEGER NOT NULL
);

CREATE TABLE Conservar(
        idProducto INTEGER NOT NULL,
        idHistorico INTEGER NOT NULL
);

CREATE TABLE Contener(
        numPedido INTEGER NOT NULL,
        idProducto INTEGER NOT NULL,
        cantidad INTEGER NOT NULL
);

CREATE TABLE CPEdoCliente(
        CP NUMBER(5) NOT NULL,
        estado VARCHAR2(100) NOT NULL
);

CREATE TABLE CPEdoEmpleado(
        CP NUMBER(5) NOT NULL,
        estado VARCHAR2(100) NOT NULL
);

CREATE TABLE CPEdoProveedor(
        CP NUMBER(5) NOT NULL,
        estado varchar2(100) NOT NULL
);

CREATE TABLE CPEdoSucursal(
        CP NUMBER(5) NOT NULL,
        estado VARCHAR2(100) NOT NULL
);

CREATE TABLE CURPFnacEmp(
        CURP CHAR(18) NOT NULL,
        fechaNac DATE NOT NULL
);

CREATE TABLE FechaPedPromo(
        fechaPedido DATE NOT NULL,
        promocion VARCHAR2(50) NOT NULL
);

CREATE TABLE Dirigir(
        idSucursal INTEGER NOT NULL,
        taquiClave INTEGER NOT NULL,
        fechaInicio DATE NOT NULL
);

CREATE TABLE Empleado(
        taquiClave INTEGER NOT NULL,
        idSucursal INTEGER NOT NULL,
        salario FLOAT(2) NOT NULL,
        email VARCHAR2(50) NOT NULL,
        telefono VARCHAR2(20) NOT NULL,
        nombre VARCHAR2(50) NOT NULL,
        apellidoPaterno VARCHAR2(50) NOT NULL,
        apellidoMaterno VARCHAR2(50) NOT NULL,
        municipio VARCHAR2(100) NOT NULL,
        colonia VARCHAR2(100) NOT NULL,
        calle VARCHAR2(100) NOT NULL,
        CP NUMBER(5) NOT NULL,
        numInterior INTEGER NOT NULL,
        numExterior INTEGER NOT NULL,
        CURP CHAR(18) NOT NULL,
        RFC CHAR(13) NOT NULL,
        tipo VARCHAR2(40) NOT NULL,
        tipoSangre varchar2(5) NOT NULL,
        numEmergencia VARCHAR2(20) NOT NULL,
        fechaContratacion DATE NOT NULL
);

CREATE TABLE Historico(
        idHistorico INTEGER NOT NULL,
        idProducto INTEGER NOT NULL,
        fechaActualizacion DATE NOT NULL,
        precioPrevio FLOAT(2) NOT NULL,
        precioNuevo FLOAT(2) NOT NULL
);

CREATE TABLE Ingrediente(
        idIngrediente INTEGER NOT NULL,
        nombre VARCHAR2(50) NOT NULL,
        marca VARCHAR2(60) NOT NULL,
        cantidadExistencia FLOAT(3) NOT NULL,
        fechaCaducidad DATE NOT NULL
);

CREATE TABLE Licencia(
        taquiClave INTEGER NOT NULL,
        codigo VARCHAR2(30) NOT NULL
);

CREATE TABLE Llevar(
        taquiClave INTEGER NOT NULL,
        numPedido INTEGER NOT NULL
);

CREATE TABLE Mobiliario(
        idMueble INTEGER NOT NULL,
        tipo VARCHAR2(30) NOT NULL
);

CREATE TABLE Pedido(
        numPedido INTEGER NOT NULL,
        idSucursal INTEGER NOT NULL,
        fechaPedido DATE NOT NULL,
        taquiClave INTEGER NOT NULL,
        metodoPago VARCHAR2(50) NOT NULL,
        preparado NUMBER(1) NOT NULL,
        entregado NUMBER(1) NOT NULL,
);

CREATE TABLE Poseer(
        taquiClave INTEGER NOT NULL,
        idTransporte INTEGER NOT NULL
);

CREATE TABLE Producto(
        idProducto INTEGER NOT NULL,
        puntosOtorgar INTEGER NOT NULL,
        nombre varchar2(200) NOT NULL,
        precio FLOAT(2) NOT NULL,
        descripcion VARCHAR2(200) NOT NULL
);

CREATE TABLE ProductoLeyenda(
        idProducto INTEGER NOT NULL,
        leyenda VARCHAR2(50) NOT NULL
);

CREATE TABLE Proveedor(
        RFC CHAR(13) NOT NULL,
        razonSocial VARCHAR2(100) NOT NULL,
        inicioRelacion DATE NOT NULL,
        email VARCHAR2(50) NOT NULL,
        telefono VARCHAR2(20) NOT NULL,
        municipio VARCHAR2(100) NOT NULL,
        colonia VARCHAR2(100) NOT NULL,
        calle VARCHAR2(100) NOT NULL,
        CP NUMBER(5) NOT NULL,
        numInterior INTEGER NOT NULL, 
        numExterior INTEGER NOT NULL
);

CREATE TABLE ProveerIng(
        RFC CHAR(13) NOT NULL,
        idIngrediente INTEGER NOT NULL,
        precio FLOAT(2) NOT NULL
);

CREATE TABLE ProveerMob(
        RFC CHAR (13) NOT NULL,
        idMueble INTEGER NOT NULL,
        precio FLOAT(2) NOT NULL
);
CREATE TABLE Recomendar(
        idProducto INTEGER NOT NULL,
        idProductoSalsa INTEGER NOT NULL
);

CREATE TABLE Salsa(
        idProducto INTEGER NOT NULL,
        presentacion VARCHAR2(70) NOT NULL,
        scoville VARCHAR2(20) NOT NULL
);

CREATE TABLE Sucursal(
        idSucursal INTEGER NOT NULL,
        horaApertura TIMESTAMP NOT NULL,
        horaCierre TIMESTAMP NOT NULL,
        municipio VARCHAR2(100) NOT NULL,
        colonia VARCHAR2(100) NOT NULL,
        calle VARCHAR2(100) NOT NULL,
        CP NUMBER(5) NOT NULL,
        numInterior INTEGER NOT NULL,
        numExterior INTEGER NOT NULL
);

CREATE TABLE SucursalTelefono(
        idSucursal INTEGER NOT NULL,
        telefono VARCHAR2(20) NOT NULL
);

CREATE TABLE Supervisar(
        taquiClaveGerente INTEGER NOT NULL,
        taquiClaveSupervisado INTEGER NOT NULL
);

CREATE TABLE TacoRider(
        taquiClave INTEGER NOT NULL,
        estaDisponible NUMBER(1) NOT NULL
);

CREATE TABLE Tener(
        idProducto INTEGER NOT NULL,
        idIngrediente INTEGER NOT NULL,
        cantidad FLOAT(3) NOT NULL
);

CREATE TABLE Transporte(
        idTransporte INTEGER NOT NULL,
        tipo VARCHAR2(50) NOT NULL,
        marca VARCHAR2(55) NOT NULL,
        modelo VARCHAR2(70) NOT NULL
);