
/*Poner restricciones de llaves primarias, foráneas, unicidad, checks*/

--a
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

--p
CREATE TABLE CPEdoSucursal(
        CP NUMBER(5) NOT NULL,
        estado VARCHAR2(100) NOT NULL
);

--m
CREATE TABLE SucursalTelefono(
        idSucursal INTEGER NOT NULL,
        telefono VARCHAR2(20) NOT NULL
);

--e
CREATE TABLE CPEdoCliente(
        CP NUMBER(5) NOT NULL,
        estado VARCHAR2(100) NOT NULL
);

--a
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

--p
CREATE TABLE CPEdoEmpleado(
        CP NUMBER(5) NOT NULL,
        estado VARCHAR2(100) NOT NULL
);

--m
CREATE TABLE CURPFnacEmp(
        CURP CHAR(18) NOT NULL,
        fechaNac DATE NOT NULL
);

--e
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

--a
CREATE TABLE FechaPedPromo(
        fechapPedido DATE NOT NULL,
        promocion VARCHAR2(50) NOT NULL
);

--p
CREATE TABLE Pedido(
        numPedido INTEGER NOT NULL,
        idSucursal INTEGER NOT NULL,
        fechaPedido DATE NOT NULL,
        taquiClave INTEGER NOT NULL,
        metodoPago VARCHAR2(50) NOT NULL
);

--m
CREATE TABLE Producto(
        idProducto INTEGER NOT NULL,
        puntosOtorgar INTEGER NOT NULL,
        nombre varchar2(70) NOT NULL,
        precio FLOAT(2) NOT NULL,
        taquegoria VARCHAR2(50) NOT NULL
);

--e
CREATE TABLE ProductoLeyenda(
        idProducto INTEGER NOT NULL,
        leyenda VARCHAR2(50) NOT NULL
);

--a
CREATE TABLE ProdHist(
        idProducto INTEGER NOT NULL,
        nombre VARCHAR2(50) NOT NULL,
        precioPrevio FLOAT(2) NOT NULL
);

--p
CREATE TABLE Historico(
        idHistorico INTEGER NOT NULL,
        idProducto INTEGER NOT NULL,
        fechaActualizacion DATE NOT NULL,
        precioNuevo FLOAT(2) NOT NULL
);

--m
CREATE TABLE Ingrediente(
        idIngrediente INTEGER NOT NULL,
        nombre VARCHAR2(50) NOT NULL,
        marca VARCHAR2(60) NOT NULL,
        cantidadExistencia INTEGER NOT NULL,
        fechaCaducidad DATE NOT NULL
);

--e
CREATE TABLE Salsa(
        idProducto INTEGER NOT NULL,
        nombre VARCHAR2(50) NOT NULL,
        presentacion VARCHAR2(70) NOT NULL,
        scoville INTEGER NOT NULL
);


--a
CREATE TABLE Mobiliario(
        idMueble INTEGER NOT NULL,
        tipo VARCHAR2(30) NOT NULL
);

--p
CREATE TABLE Transporte(
        idTransporte INTEGER NOT NULL,
        tipo VARCHAR2(50) NOT NULL,
        marca VARCHAR2(55) NOT NULL,
        modelo VARCHAR2(70) NOT NULL
);

--m
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

--e
CREATE TABLE CPEdoProveedor(
        CP NUMBER(5) NOT NULL,
        estado varchar2(100) NOT NULL
);

--a
CREATE TABLE TacoRider(
        taquiClave INTEGER NOT NULL,
        estaDisponible NUMBER(1) NOT NULL
);

--p
CREATE TABLE Llevar(
        taquiClave INTEGER NOT NULL,
        numPedido INTEGER NOT NULL
);

--m
CREATE TABLE Licencia(
        taquiClave INTEGER NOT NULL,
        codigo VARCHAR2(30) NOT NULL
);

--e
CREATE TABLE Poseer(
        taquiClave INTEGER NOT NULL,
        idTransporte INTEGER NOT NULL
);

--a
CREATE TABLE Supervisar(
        taquiClaveGerente INTEGER NOT NULL,
        taquiClaveSupervisado INTEGER NOT NULL
);

--p
CREATE TABLE Dirigir(
        idSucursal INTEGER NOT NULL,
        taquiClave INTEGER NOT NULL,
        fechaInicio DATE NOT NULL
);

--m
CREATE TABLE Contener(
        numPedido INTEGER NOT NULL,
        idProducto INTEGER NOT NULL,
        cantidad INTEGER NOT NULL
);

--e
CREATE TABLE Conservar(
        idProducto INTEGER NOT NULL,
        idHistorico INTEGER NOT NULL
);

--a
CREATE TABLE ProveerIng(
        RFC CHAR(13) NOT NULL,
        idIngrediente INTEGER NOT NULL,
        precio FLOAT(2) NOT NULL
);

--ṕ
CREATE TABLE ProveerMob(
        RFC CHAR (13) NOT NULL,
        idMueble INTEGER NOT NULL,
        precio FLOAT(2) NOT NULL
);

--m
CREATE TABLE Tener(
        idProducto INTEGER NOT NULL,
        idIngrediente INTEGER NOT NULL,
        cantidad INTEGER NOT NULL
);

--e
CREATE TABLE Recomendar(
        idProducto INTEGER NOT NULL,
        idProductoSalsa INTEGER NOT NULL
);
