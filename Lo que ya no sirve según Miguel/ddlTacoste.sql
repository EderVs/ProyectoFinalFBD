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

CREATE TABLE CPEdoSucursal(
        CP NUMBER(5),
        estado VARCHAR2(100)
);

CREATE TABLE SucursalTelefono(
        idSucursal INTEGER,
        telefono VARCHAR2(20)
);

CREATE TABLE CPEdoCliente(
        CP NUMBER(5),
        estado VARCHAR2(100)
);

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

CREATE TABLE CPEdoEmpleado(
        CP NUMBER(5),
        estado VARCHAR2(100)
);

CREATE TABLE CURPFnacEmp(
        CURP INTEGER,
        fechaNac DATE
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
        CURP INTEGER,
        RFC CHAR(13),
        tipo VARCHAR2(40),
        tipoSangre varchar2(5),
        numEmergencia VARCHAR2(20),
        fechaContratacion DATE
);

CREATE TABLE FechaPedPromo(
        fechaPedido DATE,
        promocion VARCHAR2(50)
);

CREATE TABLE Pedido(
        numPedido INTEGER,
        idSucursal INTEGER,
        fechaPedido DATE,
        taquiClave INTEGER,
        metodoPago VARCHAR2(50)
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

CREATE TABLE ProdHist(
        idProducto INTEGER,
        precioPrevio FLOAT(2)
);

CREATE TABLE Historico(
        idHistorico INTEGER,
        idProducto INTEGER,
        fechaActualizacion DATE,
        precioNuevo FLOAT(2)
);

CREATE TABLE Ingrediente(
        idIngrediente INTEGER,
        nombre VARCHAR2(50),
        marca VARCHAR2(60),
        cantidadExistencia FLOAT(3),
        fechaCaducidad DATE
);

CREATE TABLE Salsa(
        idProducto INTEGER,
        nombre VARCHAR2(50),
        presentacion VARCHAR2(70),
        scoville VARCHAR2(20)
);

CREATE TABLE Mobiliario(
        idMueble INTEGER,
        tipo VARCHAR2(30)
);

CREATE TABLE Transporte(
        idTransporte INTEGER,
        tipo VARCHAR2(50),
        marca VARCHAR2(55),
        modelo VARCHAR2(70)
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

CREATE TABLE CPEdoProveedor(
        CP NUMBER(5),
        estado varchar2(100)
);

CREATE TABLE TacoRider(
        taquiClave INTEGER,
        estaDisponible NUMBER(1)
);

CREATE TABLE Llevar(
        taquiClave INTEGER,
        numPedido INTEGER
);

CREATE TABLE Licencia(
        taquiClave INTEGER,
        codigo VARCHAR2(30)
);

CREATE TABLE Poseer(
        taquiClave INTEGER,
        idTransporte INTEGER
);

CREATE TABLE Supervisar(
        taquiClaveGerente INTEGER,
        taquiClaveSupervisado INTEGER
);

CREATE TABLE Dirigir(
        idSucursal INTEGER,
        taquiClave INTEGER,
        fechaInicio DATE
);

CREATE TABLE Contener(
        numPedido INTEGER,
        idProducto INTEGER,
        cantidad INTEGER
);

CREATE TABLE Conservar(
        idProducto INTEGER,
        idHistorico INTEGER
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

CREATE TABLE Tener(
        idProducto INTEGER,
        idIngrediente INTEGER,
        cantidad FLOAT(3)
);

CREATE TABLE Recomendar(
        idProducto INTEGER,
        idProductoSalsa INTEGER
);
