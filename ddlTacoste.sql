
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

ALTER TABLE Sucursal ADD CONSTRAINT pk_idSucursal PRIMARY KEY(idSucursal);
ALTER TABLE Sucursal ADD CONSTRAINT ch_horario CHECK horaApertura < horaCierre;

CREATE TABLE CPEdoSucursal(
        CP NUMBER(5) NOT NULL,
        estado VARCHAR2(100) NOT NULL
);

ALTER TABLE CPEdoSucursal ADD CONSTRAINT pk_cp PRIMARY KEY(CP);

CREATE TABLE SucursalTelefono(
        idSucursal INTEGER NOT NULL,
        telefono VARCHAR2(20) NOT NULL
);

ALTER TABLE SucursalTelefono ADD CONSTRAINT pk_tel_idSucursal PRIMARY KEY(idSucursal,telefono);
ALTER TABLE SucursalTelefono ADD CONSTRAINT fk_idSucursal FOREIGN KEY(idSucursal) REFERENCES Sucursal(idSucursal) ON DELETE CASCADE;

CREATE TABLE CPEdoCliente(
        CP NUMBER(5) NOT NULL,
        estado VARCHAR2(100) NOT NULL
);

ALTER TABLE CPEdoCliente ADD CONSTRAINT pk_cp PRIMARY KEY(CP);

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

ALTER TABLE Cliente ADD CONSTRAINT pk_taquiClave PRIMARY KEY(taquiClave);
ALTER TABLE Cliente ADD CONSTRAINT unq_email UNIQUE (email); --Hay una dirección de correo electrónico para cada cliente; no coinciden.
ALTER TABLE Cliente ADD CONSTRAINT ch_fechapv CHECK (TO_CHAR(fechaPrimerVista, 'YYYY-MM-DD') >= '1940-12-31');
ALTER TABLE Cliente ADD CONSTRAINT ch_num_puntos CHECK numPuntos >= 0; -- No se puede tener una cantidad negativa de puntos.

CREATE TABLE CPEdoEmpleado(
        CP NUMBER(5) NOT NULL,
        estado VARCHAR2(100) NOT NULL
);

ALTER TABLE CPEdoEmpleado ADD CONSTRAINT pk_cp PRIMARY KEY(CP);

CREATE TABLE CURPFnacEmp(
        CURP CHAR(18) NOT NULL,
        fechaNac DATE NOT NULL
);

ALTER TABLE CURPFnacEmp ADD CONSTRAINT pk_curp PRIMARY KEY(CURP);
ALTER TABLE CURPFnacEmp ADD CONSTRAINT fk_curp FOREIGN KEY(CURP) REFERENCES Empleado(CURP) ON DELETE CASCADE;
ALTER TABLE CURPFnacEmp ADD CONSTRAINT ch_fechaNac CHECK (TO_CHAR(fechaNac, 'YYYY-MM-DD') >= '1940-12-31');

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

ALTER TABLE Empleado ADD CONSTRAINT pk_taquiClave PRIMARY KEY(taquiClave);
ALTER TABLE Empleado ADD CONSTRAINT ch_fechaCon CHECK (TO_CHAR(fechaContratacion, 'YYYY-MM-DD') >= '1940-12-31');
ALTER TABLE Empleado ADD CONSTRAINT ch_tipoSangre CHECK tipoSangre IN ('O+','O-','A+','A-','B+','B-','AB+','AB-');
ALTER TABLE Empleado ADD CONSTRAINT ch_tipo CHECK tipo IN ('PARRILLERO','TAQUERO','MESERO','CAJERO','TORTILLERO','TACORIDER');
ALTER TABLE Empleado ADD CONSTRAINT ch_salario CHECK salario >= 0; --Quizá trabajen sin sueldo por un periodo de prueba.
ALTER TABLE Empleado ADD CONSTRAINT unq_email UNIQUE (email); --Hay una dirección de correo electrónico para cada empleado; no coinciden.

CREATE TABLE FechaPedPromo(
        fechaPedido DATE NOT NULL,
        promocion VARCHAR2(50) NOT NULL
);

ALTER TABLE FechaPedPromo ADD CONSTRAINT pk_fechaPedProm PRIMARY KEY(fechaPedido,promocion);
ALTER TABLE FechaPedPromo ADD CONSTRAINT fk_fechaPed FOREIGN KEY(fechaPedido) REFERENCES Pedido(fechaPedido) ON DELETE CASCADE;
ALTER TABLE FechaPedPromo ADD CONSTRAINT ch_fechaPed CHECK (TO_CHAR(fechapPedido, 'YYYY-MM-DD') >= '1940-12-31');
ALTER TABLE FechaPedPromo ADD CONSTRAINT ch_promo CHECK promocion IN ('JUEVES POZOLERO','TACO AMIGO', 'MARTES DE TORTUGA');

CREATE TABLE Pedido(
        numPedido INTEGER NOT NULL,
        idSucursal INTEGER NOT NULL,
        fechaPedido DATE NOT NULL,
        taquiClave INTEGER NOT NULL,
        metodoPago VARCHAR2(50) NOT NULL
);

ALTER TABLE Pedido ADD CONSTRAINT pk_numPedido PRIMARY KEY(numPedido);
ALTER TABLE Pedido ADD CONSTRAINT fk_idSucursal FOREIGN KEY(idSucursal) REFERENCES Sucursal(idSucursal) ON DELETE CASCADE;
ALTER TABLE Pedido ADD CONSTRAINT ch_fechaPed CHECK (TO_CHAR(fechapPedido, 'YYYY-MM-DD') >= '1940-12-31');
ALTER TABLE Pedido ADD CONSTRAINT ch_metodoPago CHECK IN ('EFECTIVO','TARJETA DÉBITO','TARJETA CRÉDITO','CRYPTOCURRENCY','VALES');

CREATE TABLE Producto(
        idProducto INTEGER NOT NULL,
        puntosOtorgar INTEGER NOT NULL,
        nombre varchar2(70) NOT NULL,
        precio FLOAT(2) NOT NULL,
        taquegoria VARCHAR2(50) NOT NULL
);

ALTER TABLE Producto ADD CONSTRAINT pk_idProducto PRIMARY KEY(idProducto);
ALTER TABLE Producto ADD CONSTRAINT ch_num_puntos CHECK puntosOtorgar >= 0; --No podemos asignar puntos negativos.
ALTER TABLE Producto ADD CONSTRAINT ch_precio CHECK precio >= 0; --Quizás haya cosas gratis a veces.
ALTER TABLE Producto ADD CONSTRAINT ch_taquegoria CHECK taquegoria IN('ENTRADAS','DEL CAZO', 'SOPES', 'HUARACHES','GRINGAS','ENCHILADAS','QUESOS','QUECAS','VOLCANES','ENSALADAS','TACOS','HAMBURGUESAS','TORTAS','BEBIDAS','POSTRES'); --Quizás haya cosas gratis a veces.

CREATE TABLE ProductoLeyenda(
        idProducto INTEGER NOT NULL,
        leyenda VARCHAR2(50) NOT NULL
);

ALTER TABLE ProductoLeyenda ADD CONSTRAINT pk_idProducto PRIMARY KEY(idProducto);
ALTER TABLE ProductoLeyenda ADD CONSTRAINT fk_idProducto FOREIGN KEY(idProducto) REFERENCES Producto(idProducto) ON DELETE CASCADE;

CREATE TABLE ProdHist(
        idProducto INTEGER NOT NULL,
        nombre VARCHAR2(50) NOT NULL,
        precioPrevio FLOAT(2) NOT NULL
);

ALTER TABLE ProdHist ADD CONSTRAINT pk_idProducto PRIMARY KEY(idProducto);
ALTER TABLE ProdHist ADD CONSTRAINT fk_idProducto FOREIGN KEY(idProducto) REFERENCES Producto(idProducto) ON DELETE CASCADE;

--p
CREATE TABLE Historico(
        idHistorico INTEGER NOT NULL,
        idProducto INTEGER NOT NULL,
        fechaActualizacion DATE NOT NULL,
        precioNuevo FLOAT(2) NOT NULL
);

ALTER TABLE Historico ADD CONSTRAINT pk_idHistorico PRIMARY KEY(idHistorico);
ALTER TABLE Historico ADD CONSTRAINT fk_idProducto FOREIGN KEY(idProducto) REFERENCES Producto(idProducto) ON DELETE CASCADE;
ALTER TABLE Historico ADD CONSTRAINT ch_fechaAct CHECK (TO_CHAR(fechaActualizacion, 'YYYY-MM-DD') >= '1940-12-31');

CREATE TABLE Ingrediente(
        idIngrediente INTEGER NOT NULL,
        nombre VARCHAR2(50) NOT NULL,
        marca VARCHAR2(60) NOT NULL,
        cantidadExistencia INTEGER NOT NULL,
        fechaCaducidad DATE NOT NULL
);

ALTER TABLE Ingrediente ADD CONSTRAINT pk_idIngrediente PRIMARY KEY(idIngrediente);
ALTER TABLE Ingrediente ADD CONSTRAINT ch_cantidadExistencia CHECK precio >= 0; --No puede faltar negativamente.
ALTER TABLE Ingrediente ADD CONSTRAINT ch_fechaCaducidad  CHECK (TO_CHAR(fechaNac, 'YYYY-MM-DD') >= '1940-12-31');

CREATE TABLE Salsa(
        idProducto INTEGER NOT NULL,
        nombre VARCHAR2(50) NOT NULL,
        presentacion VARCHAR2(70) NOT NULL,
        scoville INTEGER NOT NULL
);

ALTER TABLE Salsa ADD CONSTRAINT pk_idProducto PRIMARY KEY(idProducto);
ALTER TABLE Salsa ADD CONSTRAINT fk_idProducto FOREIGN KEY(idProducto) REFERENCES Producto(idProducto) ON DELETE CASCADE;
ALTER TABLE Salsa ADD CONSTRAINT ch_scoville  CHECK scoville <= 2,480,000; --El máximo valor de qué tan picante es la salsa en la escala. 

CREATE TABLE Mobiliario(
        idMueble INTEGER NOT NULL,
        tipo VARCHAR2(30) NOT NULL
);

ALTER TABLE Mobiliario ADD CONSTRAINT pk_idMueble PRIMARY KEY(idMueble);

CREATE TABLE Transporte(
        idTransporte INTEGER NOT NULL,
        tipo VARCHAR2(50) NOT NULL,
        marca VARCHAR2(55) NOT NULL,
        modelo VARCHAR2(70) NOT NULL
);

ALTER TABLE Transporte ADD CONSTRAINT pk_idTransporte PRIMARY KEY(idTransporte);
ALTER TABLE Transporte ADD CONSTRAINT ch_tipo  CHECK tipo IN ('BICICLETA','MOTOCICLETA');

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

ALTER TABLE Proveedor ADD CONSTRAINT pk_rfc PRIMARY KEY(RFC);
ALTER TABLE Proveedor ADD CONSTRAINT ch_inicioRel CHECK (TO_CHAR(fechaNac, 'YYYY-MM-DD') >= '1940-12-31');
ALTER TABLE Proveedor ADD CONSTRAINT unq_razonSocial UNIQUE (razonSocialC); --No puede haber legalmente dos proveedores con la misma razón social. 
ALTER TABLE Proveedor ADD CONSTRAINT unq_email UNIQUE (email); --Hay una direccón de correo electrónico para cada proveedor; no coinciden.

CREATE TABLE CPEdoProveedor(
        CP NUMBER(5) NOT NULL,
        estado varchar2(100) NOT NULL
);

ALTER TABLE CPEdoProveedor ADD CONSTRAINT pk_cp PRIMARY KEY(CP);

CREATE TABLE TacoRider(
        taquiClave INTEGER NOT NULL,
        estaDisponible NUMBER(1) NOT NULL
);

ALTER TABLE TacoRider ADD CONSTRAINT pk_taquiClave PRIMARY KEY(taquiClave);
ALTER TABLE TacoRider ADD CONSTRAINT fk_taquiClave FOREIGN KEY(taquiClave) REFERENCES Empleado(taquiClave) ON DELETE CASCADE;

CREATE TABLE Llevar(
        taquiClave INTEGER NOT NULL,
        numPedido INTEGER NOT NULL
);

ALTER TABLE Llevar ADD CONSTRAINT pk_clavePed PRIMARY KEY(taquiClave,numPedido);
ALTER TABLE Llevar ADD CONSTRAINT fk_taquiClave FOREIGN KEY(taquiClave) REFERENCES TacoRider(taquiClave) ON DELETE CASCADE;
ALTER TABLE Llevar ADD CONSTRAINT fk_numPedido FOREIGN KEY(numPedido) REFERENCES Pedido(numPedido) ON DELETE CASCADE;

CREATE TABLE Licencia(
        taquiClave INTEGER NOT NULL,
        codigo VARCHAR2(30) NOT NULL
);

ALTER TABLE Licencia ADD CONSTRAINT pk_taquiClave PRIMARY KEY(taquiClave);
ALTER TABLE Licencia ADD CONSTRAINT fk_taquiClave FOREIGN KEY(taquiClave) REFERENCES TacoRider(taquiClave) ON DELETE CASCADE;

CREATE TABLE Poseer(
        taquiClave INTEGER NOT NULL,
        idTransporte INTEGER NOT NULL
);

ALTER TABLE Poseer ADD CONSTRAINT pk_taquiClave PRIMARY KEY(taquiClave,idTransporte);
ALTER TABLE Poseer ADD CONSTRAINT fk_taquiClave FOREIGN KEY(taquiClave) REFERENCES TacoRider(taquiClave) ON DELETE CASCADE;
ALTER TABLE Poseer ADD CONSTRAINT fk_idTransporte FOREIGN KEY(idTransporte) REFERENCES Transporte(idTransporte) ON DELETE CASCADE;

CREATE TABLE Supervisar(
        taquiClaveGerente INTEGER NOT NULL,
        taquiClaveSupervisado INTEGER NOT NULL
);

ALTER TABLE Supervisar ADD CONSTRAINT pk_GerSub PRIMARY KEY(taquiClaveGerente,taquiClaveSupervisado);
ALTER TABLE Supervisar ADD CONSTRAINT fk_tcGer FOREIGN KEY(taquiClaveGerente) REFERENCES Empleado(taquiClave) ON DELETE CASCADE;
ALTER TABLE Supervisar ADD CONSTRAINT fk_tcSub FOREIGN KEY(taquiClaveSupervisado) REFERENCES Empleado(taquiClave) ON DELETE CASCADE;

CREATE TABLE Dirigir(
        idSucursal INTEGER NOT NULL,
        taquiClave INTEGER NOT NULL,
        fechaInicio DATE NOT NULL
);

ALTER TABLE Dirigir ADD CONSTRAINT pk_idSucursal PRIMARY KEY(idSucursal,taquiClave);
ALTER TABLE Dirigir ADD CONSTRAINT fk_idSucursal FOREIGN KEY(idSucursal) REFERENCES Sucursal(idSucursal) ON DELETE CASCADE;
ALTER TABLE Dirigir ADD CONSTRAINT fk_taquiClave FOREIGN KEY(taquiClave) REFERENCES Empleado(taquiClave) ON DELETE CASCADE;
ALTER TABLE Dirigir ADD CONSTRAINT ch_inicioRel CHECK (TO_CHAR(fechaInicio, 'YYYY-MM-DD') >= '1940-12-31');

CREATE TABLE Contener(
        numPedido INTEGER NOT NULL,
        idProducto INTEGER NOT NULL,
        cantidad INTEGER NOT NULL
);

ALTER TABLE Contener ADD CONSTRAINT pk_numPedidProd PRIMARY KEY(numPedido,idProducto);
ALTER TABLE Contener ADD CONSTRAINT fk_idnumPedido FOREIGN KEY(numPedido) REFERENCES Pedido(numPedido) ON DELETE CASCADE;
ALTER TABLE Contener ADD CONSTRAINT fk_idProducto FOREIGN KEY(idProducto) REFERENCES Producto(idProducto) ON DELETE CASCADE;
ALTER TABLE Contener ADD CONSTRAINT ch_cantidad CHECK cantidad >= 0; --No puede tener un pedido una cantidad negativa de productos.

CREATE TABLE Conservar(
        idProducto INTEGER NOT NULL,
        idHistorico INTEGER NOT NULL
);

ALTER TABLE Conservar ADD CONSTRAINT pk_ProdHist PRIMARY KEY(idProducto,idHistorico);
ALTER TABLE Conservar ADD CONSTRAINT fk_idProducto FOREIGN KEY(idProducto) REFERENCES Producto(idProducto) ON DELETE CASCADE;
ALTER TABLE Conservar ADD CONSTRAINT fk_idHistorico FOREIGN KEY(idHistorico) REFERENCES Historico(idHistorico) ON DELETE CASCADE;

CREATE TABLE ProveerIng(
        RFC CHAR(13) NOT NULL,
        idIngrediente INTEGER NOT NULL,
        precio FLOAT(2) NOT NULL
);

ALTER TABLE ProveerIng ADD CONSTRAINT pk_ProvIng PRIMARY KEY(RFC,idIngrediente);
ALTER TABLE ProveerIng ADD CONSTRAINT fk_rfc FOREIGN KEY(RFC) REFERENCES Proveedor(RFC) ON DELETE CASCADE;
ALTER TABLE ProveerIng ADD CONSTRAINT fk_idIngrediente FOREIGN KEY(idIngrediente) REFERENCES Ingrediente(idIngrediente) ON DELETE CASCADE;
ALTER TABLE ProveerIng ADD CONSTRAINT ch_precio CHECK precio >= 0; --Tal vez como parte de una oferta le dé cosas gratis al local.


CREATE TABLE ProveerMob(
        RFC CHAR (13) NOT NULL,
        idMueble INTEGER NOT NULL,
        precio FLOAT(2) NOT NULL
);

ALTER TABLE ProveerMob ADD CONSTRAINT pk_ProvMob PRIMARY KEY(RFC,idMueble);
ALTER TABLE ProveerMob ADD CONSTRAINT fk_rfc FOREIGN KEY(RFC) REFERENCES Proveedor(RFC) ON DELETE CASCADE;
ALTER TABLE ProveerMob ADD CONSTRAINT fk_idMueble FOREIGN KEY(idMueble) REFERENCES Mobiliario(idMueble) ON DELETE CASCADE;
ALTER TABLE ProveerMob ADD CONSTRAINT ch_precio CHECK precio >= 0; --Tal vez como parte de una oferta le dé cosas gratis al local.

CREATE TABLE Tener(
        idProducto INTEGER NOT NULL,
        idIngrediente INTEGER NOT NULL,
        cantidad INTEGER NOT NULL
);

ALTER TABLE Tener ADD CONSTRAINT pk_idProdidIng PRIMARY KEY(idProducto,idIngrediente);
ALTER TABLE Tener ADD CONSTRAINT fk_idProducto FOREIGN KEY(idProducto) REFERENCES Producto(idProducto) ON DELETE CASCADE;
ALTER TABLE Tener ADD CONSTRAINT fk_idIngrediente FOREIGN KEY(idIngrediente) REFERENCES Ingrediente(idIngrediente) ON DELETE CASCADE;
ALTER TABLE Tener ADD CONSTRAINT ch_cantidad CHECK cantidad >= 0; --No puede tener un producto una cantidad negativa de un ingrediente.

CREATE TABLE Recomendar(
        idProducto INTEGER NOT NULL,
        idProductoSalsa INTEGER NOT NULL
);

ALTER TABLE Recomendar ADD CONSTRAINT pk_GerSub PRIMARY KEY(idProducto,idProductoSalsa);
ALTER TABLE Recomendar ADD CONSTRAINT fk_idProducto FOREIGN KEY(idProducto) REFERENCES Producto(idProducto) ON DELETE CASCADE;
ALTER TABLE Recomendar ADD CONSTRAINT fk_idProductoSalsa FOREIGN KEY(idProductoSalsa) REFERENCES Salsa(idProducto) ON DELETE CASCADE;

