
--Las restricciones de valores nulos se incluyen en cada tabla por comodidad.

/*Restricciones de llaves primarias.*/
ALTER TABLE Sucursal ADD CONSTRAINT pk_idSucursal_s PRIMARY KEY(idSucursal);
ALTER TABLE CPEdoSucursal ADD CONSTRAINT pk_cp_edos PRIMARY KEY(CP);
ALTER TABLE SucursalTelefono ADD CONSTRAINT pk_tel_idSucursal PRIMARY KEY(idSucursal,telefono);
ALTER TABLE CPEdoCliente ADD CONSTRAINT pk_cp_edoc PRIMARY KEY(CP);
ALTER TABLE Cliente ADD CONSTRAINT pk_taquiClave_c PRIMARY KEY(taquiClave);
ALTER TABLE CPEdoEmpleado ADD CONSTRAINT pk_cp_edoemp PRIMARY KEY(CP);
ALTER TABLE CURPFnacEmp ADD CONSTRAINT pk_curp PRIMARY KEY(CURP);
ALTER TABLE Empleado ADD CONSTRAINT pk_taquiClave_e PRIMARY KEY(taquiClave);
ALTER TABLE FechaPedPromo ADD CONSTRAINT pk_fechaPedProm PRIMARY KEY(fechaPedido,promocion);
ALTER TABLE Pedido ADD CONSTRAINT pk_numPedido PRIMARY KEY(numPedido);
ALTER TABLE Producto ADD CONSTRAINT pk_idProducto_p PRIMARY KEY(idProducto);
ALTER TABLE ProductoLeyenda ADD CONSTRAINT pk_idProducto_pl PRIMARY KEY(idProducto);
ALTER TABLE ProdHist ADD CONSTRAINT pk_idProducto_ph PRIMARY KEY(idProducto);
ALTER TABLE Historico ADD CONSTRAINT pk_idHistorico PRIMARY KEY(idHistorico);
ALTER TABLE Ingrediente ADD CONSTRAINT pk_idIngrediente PRIMARY KEY(idIngrediente);
ALTER TABLE Salsa ADD CONSTRAINT pk_idProducto_s PRIMARY KEY(idProducto);
ALTER TABLE Mobiliario ADD CONSTRAINT pk_idMueble PRIMARY KEY(idMueble);
ALTER TABLE Transporte ADD CONSTRAINT pk_idTransporte PRIMARY KEY(idTransporte);
ALTER TABLE Proveedor ADD CONSTRAINT pk_rfc PRIMARY KEY(RFC);
ALTER TABLE CPEdoProveedor ADD CONSTRAINT pk_cp_edoprov PRIMARY KEY(CP);
ALTER TABLE TacoRider ADD CONSTRAINT pk_taquiClave_tr PRIMARY KEY(taquiClave);
ALTER TABLE Llevar ADD CONSTRAINT pk_clavePed PRIMARY KEY(taquiClave,numPedido);
ALTER TABLE Licencia ADD CONSTRAINT pk_taquiClave_l PRIMARY KEY(taquiClave);
ALTER TABLE Poseer ADD CONSTRAINT pk_taquiClave_po PRIMARY KEY(taquiClave,idTransporte);
ALTER TABLE Supervisar ADD CONSTRAINT pk_GerSub_sup PRIMARY KEY(taquiClaveGerente,taquiClaveSupervisado);
ALTER TABLE Dirigir ADD CONSTRAINT pk_idSucursal_d PRIMARY KEY(idSucursal,taquiClave);
ALTER TABLE Contener ADD CONSTRAINT pk_numPedidProd PRIMARY KEY(numPedido,idProducto);
ALTER TABLE Conservar ADD CONSTRAINT pk_ProdHist PRIMARY KEY(idProducto,idHistorico);
ALTER TABLE ProveerIng ADD CONSTRAINT pk_ProvIng PRIMARY KEY(RFC,idIngrediente);
ALTER TABLE ProveerMob ADD CONSTRAINT pk_ProvMob PRIMARY KEY(RFC,idMueble);
ALTER TABLE Tener ADD CONSTRAINT pk_idProdidIng PRIMARY KEY(idProducto,idIngrediente);
ALTER TABLE Recomendar ADD CONSTRAINT pk_GerSub_r PRIMARY KEY(idProducto,idProductoSalsa);

/*Restricciones de integridad referencial por llaves externas (foráneas).*/
ALTER TABLE SucursalTelefono ADD CONSTRAINT fk_idSucursal_st FOREIGN KEY(idSucursal) REFERENCES Sucursal(idSucursal) ON DELETE CASCADE;
ALTER TABLE Pedido ADD CONSTRAINT fk_idSucursal_p FOREIGN KEY(idSucursal) REFERENCES Sucursal(idSucursal) ON DELETE CASCADE;
ALTER TABLE ProductoLeyenda ADD CONSTRAINT fk_idProducto_pl FOREIGN KEY(idProducto) REFERENCES Producto(idProducto) ON DELETE CASCADE;
ALTER TABLE ProdHist ADD CONSTRAINT fk_idProducto_ph FOREIGN KEY(idProducto) REFERENCES Producto(idProducto) ON DELETE CASCADE;
ALTER TABLE Historico ADD CONSTRAINT fk_idProducto_h FOREIGN KEY(idProducto) REFERENCES Producto(idProducto) ON DELETE CASCADE;
ALTER TABLE Salsa ADD CONSTRAINT fk_idProducto_s FOREIGN KEY(idProducto) REFERENCES Producto(idProducto) ON DELETE CASCADE;
ALTER TABLE TacoRider ADD CONSTRAINT fk_taquiClave_tr FOREIGN KEY(taquiClave) REFERENCES Empleado(taquiClave) ON DELETE CASCADE;
ALTER TABLE Llevar ADD CONSTRAINT fk_taquiClave_ll FOREIGN KEY(taquiClave) REFERENCES TacoRider(taquiClave) ON DELETE CASCADE;
ALTER TABLE Llevar ADD CONSTRAINT fk_numPedido FOREIGN KEY(numPedido) REFERENCES Pedido(numPedido) ON DELETE CASCADE;
ALTER TABLE Licencia ADD CONSTRAINT fk_taquiClave_li FOREIGN KEY(taquiClave) REFERENCES TacoRider(taquiClave) ON DELETE CASCADE;
ALTER TABLE Poseer ADD CONSTRAINT fk_taquiClave_pos FOREIGN KEY(taquiClave) REFERENCES TacoRider(taquiClave) ON DELETE CASCADE;
ALTER TABLE Poseer ADD CONSTRAINT fk_idTransporte FOREIGN KEY(idTransporte) REFERENCES Transporte(idTransporte) ON DELETE CASCADE;
ALTER TABLE Supervisar ADD CONSTRAINT fk_tcGer FOREIGN KEY(taquiClaveGerente) REFERENCES Empleado(taquiClave) ON DELETE CASCADE;
ALTER TABLE Supervisar ADD CONSTRAINT fk_tcSub FOREIGN KEY(taquiClaveSupervisado) REFERENCES Empleado(taquiClave) ON DELETE CASCADE;
ALTER TABLE Dirigir ADD CONSTRAINT fk_idSucursal_d FOREIGN KEY(idSucursal) REFERENCES Sucursal(idSucursal) ON DELETE CASCADE;
ALTER TABLE Dirigir ADD CONSTRAINT fk_taquiClave_d FOREIGN KEY(taquiClave) REFERENCES Empleado(taquiClave) ON DELETE CASCADE;
ALTER TABLE Contener ADD CONSTRAINT fk_idnumPedido FOREIGN KEY(numPedido) REFERENCES Pedido(numPedido) ON DELETE CASCADE;
ALTER TABLE Contener ADD CONSTRAINT fk_idProducto_cont FOREIGN KEY(idProducto) REFERENCES Producto(idProducto) ON DELETE CASCADE;
ALTER TABLE Conservar ADD CONSTRAINT fk_idProducto_cons FOREIGN KEY(idProducto) REFERENCES Producto(idProducto) ON DELETE CASCADE;
ALTER TABLE Conservar ADD CONSTRAINT fk_idHistorico FOREIGN KEY(idHistorico) REFERENCES Historico(idHistorico) ON DELETE CASCADE;
ALTER TABLE ProveerIng ADD CONSTRAINT fk_rfc_ping FOREIGN KEY(RFC) REFERENCES Proveedor(RFC) ON DELETE CASCADE;
ALTER TABLE ProveerIng ADD CONSTRAINT fk_idIngrediente_pr FOREIGN KEY(idIngrediente) REFERENCES Ingrediente(idIngrediente) ON DELETE CASCADE;
ALTER TABLE ProveerMob ADD CONSTRAINT fk_rfc_pmob FOREIGN KEY(RFC) REFERENCES Proveedor(RFC) ON DELETE CASCADE;
ALTER TABLE ProveerMob ADD CONSTRAINT fk_idMueble FOREIGN KEY(idMueble) REFERENCES Mobiliario(idMueble) ON DELETE CASCADE;
ALTER TABLE Tener ADD CONSTRAINT fk_idProducto_ten FOREIGN KEY(idProducto) REFERENCES Producto(idProducto) ON DELETE CASCADE;
ALTER TABLE Tener ADD CONSTRAINT fk_idIngrediente_ten FOREIGN KEY(idIngrediente) REFERENCES Ingrediente(idIngrediente) ON DELETE CASCADE;
ALTER TABLE Recomendar ADD CONSTRAINT fk_idProducto_rec FOREIGN KEY(idProducto) REFERENCES Producto(idProducto) ON DELETE CASCADE;
ALTER TABLE Recomendar ADD CONSTRAINT fk_idProductoSalsa FOREIGN KEY(idProductoSalsa) REFERENCES Salsa(idProducto) ON DELETE CASCADE;

/*Restricciones de chequeos.*/
ALTER TABLE Sucursal ADD CONSTRAINT ch_horario CHECK (horaApertura < horaCierre);
ALTER TABLE Cliente ADD CONSTRAINT ch_fechapv CHECK (TO_CHAR(fechaPrimerVista, 'YYYY-MM-DD') >= '1940-12-31');
ALTER TABLE Cliente ADD CONSTRAINT ch_num_puntos_cl CHECK (numPuntos >= 0); -- No se puede tener una cantidad negativa de puntos.
ALTER TABLE CURPFnacEmp ADD CONSTRAINT ch_fechaNac CHECK (TO_CHAR(fechaNac, 'YYYY-MM-DD') >= '1940-12-31');
ALTER TABLE Empleado ADD CONSTRAINT ch_fechaCon CHECK (TO_CHAR(fechaContratacion, 'YYYY-MM-DD') >= '1940-12-31');
ALTER TABLE Empleado ADD CONSTRAINT ch_tipoSangre CHECK (tipoSangre IN ('O+','O-','A+','A-','B+','B-','AB+','AB-'));
ALTER TABLE Empleado ADD CONSTRAINT ch_tipo_emp CHECK (tipo IN ('PARRILLERO','TAQUERO','MESERO','CAJERO','TORTILLERO','TACORIDER'));
ALTER TABLE Empleado ADD CONSTRAINT ch_salario CHECK (salario >= 0); --Quizá trabajen sin sueldo por un periodo de prueba.
ALTER TABLE FechaPedPromo ADD CONSTRAINT ch_fechaPed_fpr CHECK (TO_CHAR(fechapPedido, 'YYYY-MM-DD') >= '1940-12-31');
ALTER TABLE FechaPedPromo ADD CONSTRAINT ch_promo CHECK (promocion IN ('JUEVES POZOLERO','TACO AMIGO', 'MARTES DE TORTUGA'));
ALTER TABLE Pedido ADD CONSTRAINT ch_fechaPed_p CHECK (TO_CHAR(fechapPedido, 'YYYY-MM-DD') >= '1940-12-31');
ALTER TABLE Pedido ADD CONSTRAINT ch_metodoPago CHECK (metodoPago IN ('EFECTIVO','TARJETA DÉBITO','TARJETA CRÉDITO','CRYPTOCURRENCY','VALES'));
ALTER TABLE Producto ADD CONSTRAINT ch_num_puntos_prod CHECK (puntosOtorgar >= 0); --No podemos asignar puntos negativos.
ALTER TABLE Producto ADD CONSTRAINT ch_precio_prod CHECK (precio >= 0); --Quizás haya cosas gratis a veces.
ALTER TABLE Producto ADD CONSTRAINT ch_taquegoria CHECK (taquegoria IN('ENTRADAS','DEL CAZO', 'SOPES', 'HUARACHES','GRINGAS','ENCHILADAS','QUESOS','QUECAS','VOLCANES','ENSALADAS','TACOS','HAMBURGUESAS','TORTAS','BEBIDAS','POSTRES')); --Quizás haya cosas gratis a veces.
ALTER TABLE Historico ADD CONSTRAINT ch_fechaAct CHECK (TO_CHAR(fechaActualizacion, 'YYYY-MM-DD') >= '1940-12-31');
ALTER TABLE Ingrediente ADD CONSTRAINT ch_cantidadExistencia CHECK (precio >= 0); --No puede faltar negativamente.
ALTER TABLE Ingrediente ADD CONSTRAINT ch_fechaCaducidad  CHECK (TO_CHAR(fechaNac, 'YYYY-MM-DD') >= '1940-12-31');
ALTER TABLE Salsa ADD CONSTRAINT ch_scoville  CHECK (scoville IN ('DULCE','BAJO','MEDIO','ALTO','EXTREMO'));
ALTER TABLE Transporte ADD CONSTRAINT ch_tipo_tr  CHECK (tipo IN ('BICICLETA','MOTOCICLETA'));
ALTER TABLE Proveedor ADD CONSTRAINT ch_inicioRel CHECK (TO_CHAR(fechaNac, 'YYYY-MM-DD') >= '1940-12-31');
ALTER TABLE Dirigir ADD CONSTRAINT ch_inicioDir CHECK (TO_CHAR(fechaInicio, 'YYYY-MM-DD') >= '1940-12-31');
ALTER TABLE Contener ADD CONSTRAINT ch_cantidad_cont CHECK (cantidad >= 0); --No puede tener un pedido una cantidad negativa de productos.
ALTER TABLE ProveerIng ADD CONSTRAINT ch_precio_ping CHECK (precio >= 0); --Tal vez como parte de una oferta le dé cosas gratis al local.
ALTER TABLE ProveerMob ADD CONSTRAINT ch_precio_pmob CHECK (precio >= 0); --Tal vez como parte de una oferta le dé cosas gratis al local.
ALTER TABLE Tener ADD CONSTRAINT ch_cantidad_ten CHECK (cantidad >= 0); --No puede tener un producto una cantidad negativa de un ingrediente.

/*Restricciones de unicidad.*/
ALTER TABLE Cliente ADD CONSTRAINT unq_email_cl UNIQUE (email); --Hay una dirección de correo electrónico para cada cliente; no coinciden.
ALTER TABLE Empleado ADD CONSTRAINT unq_email_emp UNIQUE (email); --Hay una dirección de correo electrónico para cada empleado; no coinciden.
ALTER TABLE Proveedor ADD CONSTRAINT unq_razonSocial_prov UNIQUE (razonSocialC); --No puede haber legalmente dos proveedores con la misma razón social. 
ALTER TABLE Proveedor ADD CONSTRAINT unq_email_prov UNIQUE (email); --Hay una direccón de correo electrónico para cada proveedor; no coinciden.



