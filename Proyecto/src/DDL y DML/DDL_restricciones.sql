-- ##########################################################################
-- Nombre            : DDL_restricciones.sql.
-- Fecha             : 12 de enero del 2018.
-- Autores           : Flores Martínez Andrés, 
--                     Vázquez Salcedo Eduardo Eder,
--                     Sánchez Pérez Pedro Juan Salvador,
--                     Concha Vázquez Miguel.
-- Compañía          : Computólogos A.C., Facultad de Ciencias UNAM.
-- Cliente           : Taquería Tacoste.
-- ========================================================================
-- Propósito         : Con las sentencias de alteración de tablas del DDL
--                     se especifican las respectivas restricciones
--                     ("constraints") de las relaciones, correspondientes
--                     a las de entidad de llaves primarias, de entidad de 
--                     llaves foráneas y las de dominio (chequeos y unicidad).
--                     Lo corresondiente a las marcas NULL ya fue manejado
--                     directamente en el archivo DDL_creación.sql  
-- ##########################################################################

/**
  * INTEGRIDADES DE ENTIDAD DE LLAVES PRIMARIAS.
  * Estableciendo las llaves primarias simples y compuestas de las tablas.
*/
ALTER TABLE Categoria ADD CONSTRAINT pk_categoria PRIMARY KEY(idProducto);
ALTER TABLE Cliente ADD CONSTRAINT pk_taquiClave_c PRIMARY KEY(taquiClave);
ALTER TABLE Conservar ADD CONSTRAINT pk_ProdHist PRIMARY KEY(idProducto,idHistorico);
ALTER TABLE Contener ADD CONSTRAINT pk_numPedidProd PRIMARY KEY(numPedido,idProducto);
ALTER TABLE CPEdoCliente ADD CONSTRAINT pk_cp_edoc PRIMARY KEY(CP);
ALTER TABLE CPEdoEmpleado ADD CONSTRAINT pk_cp_edoemp PRIMARY KEY(CP);
ALTER TABLE CPEdoProveedor ADD CONSTRAINT pk_cp_edoprov PRIMARY KEY(CP);
ALTER TABLE CPEdoSucursal ADD CONSTRAINT pk_cp_edos PRIMARY KEY(CP);
ALTER TABLE CURPFnacEmp ADD CONSTRAINT pk_curp PRIMARY KEY(CURP);
ALTER TABLE FechaPedPromo ADD CONSTRAINT pk_fechaPedProm PRIMARY KEY(fechaPedido);
ALTER TABLE Dirigir ADD CONSTRAINT pk_idSucursal_d PRIMARY KEY(idSucursal,taquiClave);
ALTER TABLE Empleado ADD CONSTRAINT pk_taquiClave_e PRIMARY KEY(taquiClave);
ALTER TABLE Historico ADD CONSTRAINT pk_idHistorico PRIMARY KEY(idHistorico);
ALTER TABLE Ingrediente ADD CONSTRAINT pk_idIngrediente PRIMARY KEY(idIngrediente);
ALTER TABLE Licencia ADD CONSTRAINT pk_taquiClave_l PRIMARY KEY(taquiClave);
ALTER TABLE Llevar ADD CONSTRAINT pk_clavePed PRIMARY KEY(taquiClave,numPedido);
ALTER TABLE Mobiliario ADD CONSTRAINT pk_idMueble PRIMARY KEY(idMueble);
ALTER TABLE Pedido ADD CONSTRAINT pk_numPedido PRIMARY KEY(numPedido);
ALTER TABLE Poseer ADD CONSTRAINT pk_taquiClave_po PRIMARY KEY(taquiClave,idTransporte);
ALTER TABLE Producto ADD CONSTRAINT pk_idProducto_p PRIMARY KEY(idProducto);
ALTER TABLE ProductoLeyenda ADD CONSTRAINT pk_idProducto_pl PRIMARY KEY(idProducto,leyenda);
ALTER TABLE Proveedor ADD CONSTRAINT pk_rfc PRIMARY KEY(RFC);
ALTER TABLE ProveerIng ADD CONSTRAINT pk_ProvIng PRIMARY KEY(RFC,idIngrediente);
ALTER TABLE ProveerMob ADD CONSTRAINT pk_ProvMob PRIMARY KEY(RFC,idMueble);
ALTER TABLE Recomendar ADD CONSTRAINT pk_GerSub_r PRIMARY KEY(idProducto,idProductoSalsa);
ALTER TABLE Salsa ADD CONSTRAINT pk_idProducto_s PRIMARY KEY(idProducto);
ALTER TABLE Sucursal ADD CONSTRAINT pk_idSucursal_s PRIMARY KEY(idSucursal);
ALTER TABLE SucursalTelefono ADD CONSTRAINT pk_tel_idSucursal PRIMARY KEY(telefono);
ALTER TABLE Supervisar ADD CONSTRAINT pk_GerSub_sup PRIMARY KEY(taquiClaveGerente,taquiClaveSupervisado);
ALTER TABLE TacoRider ADD CONSTRAINT pk_taquiClave_tr PRIMARY KEY(taquiClave);
ALTER TABLE Tener ADD CONSTRAINT pk_idProdidIng PRIMARY KEY(idProducto,idIngrediente);
ALTER TABLE Transporte ADD CONSTRAINT pk_idTransporte PRIMARY KEY(idTransporte);

/**
  * INTEGRIDADES DE ENTIDAD DE LLAVES FORÁNEAS.
  * Estableciendo las restricciones de llaves externas para lograr la conexión entre las tablas.
  * Estamos asegurando la integridad referencial al usar casada porque al eliminar un registro de una tabla
  * referenciada, se borran también en las tablas rerenciantes.
*/
ALTER TABLE Categoria ADD CONSTRAINT fk_idProducto_cat FOREIGN KEY(idProducto) REFERENCES Producto(idProducto) ON DELETE CASCADE;
ALTER TABLE Conservar ADD CONSTRAINT fk_idProducto_cons FOREIGN KEY(idProducto) REFERENCES Producto(idProducto) ON DELETE CASCADE;
ALTER TABLE Conservar ADD CONSTRAINT fk_idHistorico FOREIGN KEY(idHistorico) REFERENCES Historico(idHistorico) ON DELETE CASCADE;
ALTER TABLE Contener ADD CONSTRAINT fk_idProducto_cont FOREIGN KEY(idProducto) REFERENCES Producto(idProducto) ON DELETE CASCADE;
ALTER TABLE Dirigir ADD CONSTRAINT fk_idSucursal_d FOREIGN KEY(idSucursal) REFERENCES Sucursal(idSucursal) ON DELETE CASCADE;
ALTER TABLE Dirigir ADD CONSTRAINT fk_taquiClave_d FOREIGN KEY(taquiClave) REFERENCES Empleado(taquiClave) ON DELETE CASCADE;
ALTER TABLE Empleado ADD CONSTRAINT fk_empleado FOREIGN KEY(idSucursal) REFERENCES Sucursal(idSucursal) ON DELETE CASCADE;
ALTER TABLE Historico ADD CONSTRAINT fk_idProducto_h FOREIGN KEY(idProducto) REFERENCES Producto(idProducto) ON DELETE CASCADE;
ALTER TABLE Licencia ADD CONSTRAINT fk_taquiClave_li FOREIGN KEY(taquiClave) REFERENCES TacoRider(taquiClave) ON DELETE CASCADE;
ALTER TABLE Llevar ADD CONSTRAINT fk_numPedido FOREIGN KEY(numPedido) REFERENCES Pedido(numPedido) ON DELETE CASCADE;
ALTER TABLE Llevar ADD CONSTRAINT fk_taquiClave_ll FOREIGN KEY(taquiClave) REFERENCES TacoRider(taquiClave) ON DELETE CASCADE;
ALTER TABLE Pedido ADD CONSTRAINT fk_idSucursal_p FOREIGN KEY(idSucursal) REFERENCES Sucursal(idSucursal) ON DELETE CASCADE;
ALTER TABLE Pedido ADD CONSTRAINT fk_taquiClave_p FOREIGN KEY(taquiClave) REFERENCES Cliente(taquiClave) ON DELETE CASCADE;
ALTER TABLE Poseer ADD CONSTRAINT fk_taquiClave_pos FOREIGN KEY(taquiClave) REFERENCES TacoRider(taquiClave) ON DELETE CASCADE;
ALTER TABLE Poseer ADD CONSTRAINT fk_idTransporte FOREIGN KEY(idTransporte) REFERENCES Transporte(idTransporte) ON DELETE CASCADE;
ALTER TABLE ProductoLeyenda ADD CONSTRAINT fk_idProducto_pl FOREIGN KEY(idProducto) REFERENCES Producto(idProducto) ON DELETE CASCADE;
ALTER TABLE ProveerIng ADD CONSTRAINT fk_rfc_ping FOREIGN KEY(RFC) REFERENCES Proveedor(RFC) ON DELETE CASCADE;
ALTER TABLE ProveerIng ADD CONSTRAINT fk_idIngrediente_pr FOREIGN KEY(idIngrediente) REFERENCES Ingrediente(idIngrediente) ON DELETE CASCADE;
ALTER TABLE ProveerMob ADD CONSTRAINT fk_rfc_pmob FOREIGN KEY(RFC) REFERENCES Proveedor(RFC) ON DELETE CASCADE;
ALTER TABLE ProveerMob ADD CONSTRAINT fk_idMueble FOREIGN KEY(idMueble) REFERENCES Mobiliario(idMueble) ON DELETE CASCADE;
ALTER TABLE Recomendar ADD CONSTRAINT fk_idProducto_rec FOREIGN KEY(idProducto) REFERENCES Producto(idProducto) ON DELETE CASCADE;
ALTER TABLE Salsa ADD CONSTRAINT fk_idProducto_s FOREIGN KEY(idProducto) REFERENCES Producto(idProducto) ON DELETE CASCADE;
ALTER TABLE Recomendar ADD CONSTRAINT fk_idProductoSalsa FOREIGN KEY(idProductoSalsa) REFERENCES Salsa(idProducto) ON DELETE CASCADE;
ALTER TABLE SucursalTelefono ADD CONSTRAINT fk_idSucursal_st FOREIGN KEY(idSucursal) REFERENCES Sucursal(idSucursal) ON DELETE CASCADE;
ALTER TABLE Supervisar ADD CONSTRAINT fk_tcGer FOREIGN KEY(taquiClaveGerente) REFERENCES Empleado(taquiClave) ON DELETE CASCADE;
ALTER TABLE Supervisar ADD CONSTRAINT fk_tcSub FOREIGN KEY(taquiClaveSupervisado) REFERENCES Empleado(taquiClave) ON DELETE CASCADE;
ALTER TABLE TacoRider ADD CONSTRAINT fk_taquiClave_tr FOREIGN KEY(taquiClave) REFERENCES Empleado(taquiClave) ON DELETE CASCADE;
ALTER TABLE Tener ADD CONSTRAINT fk_idProducto_ten FOREIGN KEY(idProducto) REFERENCES Producto(idProducto) ON DELETE CASCADE;
ALTER TABLE Cliente ADD CONSTRAINT fk_cpe_cl FOREIGN KEY(CP) REFERENCES CPEdoCliente(CP) ON DELETE CASCADE;
ALTER TABLE Empleado ADD CONSTRAINT fk_cpe_emp FOREIGN KEY(CP) REFERENCES CPEdoEmpleado(CP) ON DELETE CASCADE;
ALTER TABLE Sucursal ADD CONSTRAINT fk_cpe_sucu FOREIGN KEY(CP) REFERENCES CPEdoSucursal(CP) ON DELETE CASCADE;
ALTER TABLE Proveedor ADD CONSTRAINT fk_cpe_prov FOREIGN KEY(CP) REFERENCES CPEdoProveedor(CP) ON DELETE CASCADE;
ALTER TABLE Empleado ADD CONSTRAINT fk_curp_fnac FOREIGN KEY(CURP) REFERENCES CURPFnacEmp(CURP) ON DELETE CASCADE;

/**
  * INTEGRIDADES DE DOMINIO: UNICIDAD y CHECKS. No incluimos en la base de datos valores nulos que pueden 
  * prestarse a diversas interpretaciones como son datos que no aplican, valores desconocidos, entre otros.
*/
-- Checks:
ALTER TABLE Categoria ADD CONSTRAINT ch_taquegoria CHECK (taquegoria IN('ENTRADAS','DEL CAZO', 'SOPES Y HUARACHES','ENCHILADAS','QUESOS','GRINGAS, QUECAS Y VOLCANES','ALAMBRES','ENSALADAS','TACOS','HAMBURGUESAS','TORTAS','BEBIDAS','POSTRES','SALSAS')); --Quizás haya cosas gratis a veces.
ALTER TABLE Cliente ADD CONSTRAINT ch_num_puntos_cl CHECK (numPuntos >= 0); -- No se puede tener una cantidad negativa de puntos.
ALTER TABLE Contener ADD CONSTRAINT ch_cantidad_cont CHECK (cantidad >= 0); --No puede tener un pedido una cantidad negativa de productos.
ALTER TABLE Empleado ADD CONSTRAINT ch_tipoSangre CHECK (tipoSangre IN ('O+','O-','A+','A-','B+','B-','AB+','AB-'));
ALTER TABLE Empleado ADD CONSTRAINT ch_tipo_emp CHECK (tipo IN ('PARRILLERO','TAQUERO','MESERO','CAJERO','TORTILLERO','TACORIDER'));
ALTER TABLE Empleado ADD CONSTRAINT ch_salario CHECK (salario >= 0); --Quizá trabajen sin sueldo por un periodo de prueba.
ALTER TABLE FechaPedPromo ADD CONSTRAINT ch_promo CHECK (promocion IN ('JUEVES POZOLERO','TACO AMIGO', 'MARTES DE TORTUGA', 'NINGUNA'));
ALTER TABLE Historico ADD CONSTRAINT ch_precio_prevh CHECK (precioPrevio >= 0); --Quizás haya cosas gratis a veces, pero no puede ser negativo.
ALTER TABLE Historico ADD CONSTRAINT ch_precio_nuevh CHECK (precioNuevo >= 0); --Quizás haya cosas gratis a veces, pero no puede ser negativo.
ALTER TABLE Ingrediente ADD CONSTRAINT ch_cantidadExistencia CHECK (cantidadExistencia >= 0); --No puede faltar negativamente.
ALTER TABLE Mobiliario ADD CONSTRAINT ch_tipo CHECK (tipo IN ('MESA','SILLA','BANCO','PLATO','SERVILLETERO')); --Los tipos de mueble especificados en el caso de uso.
ALTER TABLE Pedido ADD CONSTRAINT ch_metodoPago CHECK (metodoPago IN ('EFECTIVO','TARJETA DEBITO','TARJETA CREDITO','CRYPTOCURRENCY','VALES'));
ALTER TABLE Pedido ADD CONSTRAINT ch_preparado CHECK (preparado IN (0,1)); --Valores booleanos.
ALTER TABLE Pedido ADD CONSTRAINT ch_entregado CHECK (entregado IN (0,1)); --Valores booleanos.
ALTER TABLE Producto ADD CONSTRAINT ch_precio_prod CHECK (precio >= 0); --Quizás haya cosas gratis a veces.
ALTER TABLE ProductoLeyenda ADD CONSTRAINT ch_ley CHECK (leyenda IN ('VEGANO','ESPECIAL','ORGANICO','DELUXE','RECOMENDACION','LIGHT','HOT')); --No puede tener un producto una cantidad negativa de un ingrediente.
ALTER TABLE ProveerIng ADD CONSTRAINT ch_precio_ping CHECK (precio >= 0); --Tal vez como parte de una oferta le dé cosas gratis al local.
ALTER TABLE ProveerMob ADD CONSTRAINT ch_precio_pmob CHECK (precio >= 0); --Tal vez como parte de una oferta le dé cosas gratis al local.
ALTER TABLE Salsa ADD CONSTRAINT ch_scoville  CHECK (scoville IN ('DULCE','BAJO','MEDIO','ALTO','EXTREMO'));
ALTER TABLE Salsa ADD CONSTRAINT ch_psalsa CHECK (presentacion IN ('300ml', '500ml', '1L', '2L')); --No puede tener un producto una cantidad negativa de un ingrediente.
ALTER TABLE Sucursal ADD CONSTRAINT ch_horario CHECK (horaApertura < horaCierre);
ALTER TABLE TacoRider ADD CONSTRAINT ch_dispo CHECK (estaDisponible IN (0,1)); --Valores booleanos.
ALTER TABLE Tener ADD CONSTRAINT ch_cantidad_ten CHECK (cantidad >= 0); --No puede tener un producto una cantidad negativa de un ingrediente.
ALTER TABLE Transporte ADD CONSTRAINT ch_tipo_tr  CHECK (tipo IN ('BICICLETA','MOTOCICLETA'));
-- Unicidad:
ALTER TABLE Cliente ADD CONSTRAINT unq_email_cl UNIQUE (email); --Hay una dirección de correo electrónico para cada cliente; no coinciden.
ALTER TABLE Empleado ADD CONSTRAINT unq_email_emp UNIQUE (email); --Hay una dirección de correo electrónico para cada empleado; no coinciden.
ALTER TABLE Proveedor ADD CONSTRAINT unq_razonSocial_prov UNIQUE (razonSocial); --No puede haber legalmente dos proveedores con la misma razón social. 
ALTER TABLE Proveedor ADD CONSTRAINT unq_email_prov UNIQUE (email); --Hay una direccón de correo electrónico para cada proveedor; no coinciden.
ALTER TABLE Producto ADD CONSTRAINT unq_nombre_prod UNIQUE (nombre); --Hay un único nombre para cada producto de la taquería.
