-- Active: 1648930287171@@127.0.0.1@3306@proyectobd
CREATE DATABASE proyectobd;
USE proyectobd;
# Creacion de tablas 
# Tabla usuarios

CREATE TABLE pais (
  id_pais INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(45) NOT NULL,
  PRIMARY KEY (id_pais),
  UNIQUE KEY nombre (nombre)
);
 
CREATE TABLE cliente (
  id_cliente INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(45) NOT NULL,
  apellido VARCHAR(45) NOT NULL,
  email VARCHAR(45) NOT NULL,
  telefono VARCHAR(45) NOT NULL,
  direccion VARCHAR(45) NOT NULL,
  id_pais INT NOT NULL,
  PRIMARY KEY (id_cliente),
  FOREIGN KEY (id_pais) REFERENCES pais (id_pais)
);  

# en esta tabla se encargara de la compañia de los viajes o hoteles de los clientes.
CREATE TABLE compañia (
  id_compania INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(45) NOT NULL,
  telefono VARCHAR(45) NOT NULL,
  direccion VARCHAR(45) NOT NULL,
  PRIMARY KEY (id_compania),
  FOREIGN KEY (id_compania) REFERENCES cliente (id_cliente)
);

# sucursales de la compañia
CREATE TABLE sucursal (
  id_sucursal INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(45) NOT NULL,
  telefono VARCHAR(45) NOT NULL,
  direccion VARCHAR(45) NOT NULL,
  PRIMARY KEY (id_sucursal),
  FOREIGN KEY (id_sucursal) REFERENCES compañia (id_compania)
);

# esta tabala se encargara del tipo de moneda que se utilizara en los viajes o hoteles para los pagos.
CREATE TABLE Moneda (
  id_moneda INT NOT NULL AUTO_INCREMENT,
   tipo_moneda VARCHAR(45) NOT NULL,
    PRIMARY KEY (id_moneda),
    FOREIGN KEY (id_moneda) REFERENCES cliente (id_cliente)
);

CREATE TABLE habitacion (
  id_habitacion INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(45) NOT NULL,
  tipo_habitacion VARCHAR(45) NOT NULL,
  precio INT NOT NULL,
  numero_habitacion INT NOT NULL,
  PRIMARY KEY (id_habitacion),
  FOREIGN KEY (id_habitacion) REFERENCES cliente (id_cliente),
  FOREIGN KEY (id_habitacion) REFERENCES compañia (id_compania),
  FOREIGN KEY (id_habitacion) REFERENCES sucursal (id_sucursal),
  FOREIGN KEY (id_habitacion) REFERENCES Moneda (id_moneda)
);
CREATE TABLE reserva (
  id_reserva INT NOT NULL AUTO_INCREMENT,
  id_cliente INT NOT NULL,
  id_sucursal INT NOT NULL,
  id_compania INT NOT NULL,
  id_habitacion INT NOT NULL,
  id_moneda INT NOT NULL,
  fecha_entrada DATE NOT NULL,
  fecha_salida DATE NOT NULL,
  numero_personas INT NOT NULL,
  total INT NOT NULL,
  PRIMARY KEY (id_reserva),
  FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente) ON DELETE RESTRICT,
  FOREIGN KEY (id_sucursal) REFERENCES sucursal(id_sucursal) ON DELETE RESTRICT,
  FOREIGN KEY (id_compania) REFERENCES compañia(id_compania) ON DELETE RESTRICT,
  FOREIGN KEY (id_habitacion) REFERENCES habitacion(id_habitacion) ON DELETE RESTRICT,
  FOREIGN KEY (id_moneda) REFERENCES moneda(id_moneda) ON DELETE RESTRICT
);

CREATE TABLE reserva_habitacion (
  id_reserva_habitacion INT NOT NULL AUTO_INCREMENT,
  id_reserva INT NOT NULL,
  id_habitacion INT NOT NULL,
  PRIMARY KEY (id_reserva_habitacion),
  FOREIGN KEY (id_reserva_habitacion) REFERENCES reserva(id_reserva) ON DELETE RESTRICT,
  FOREIGN KEY (id_reserva_habitacion) REFERENCES habitacion(id_habitacion) ON DELETE RESTRICT
);

CREATE TABLE reserva_habitacion_detalle (
  id_reserva_habitacion_detalle INT NOT NULL AUTO_INCREMENT,
  id_reserva_habitacion INT NOT NULL,
  id_habitacion INT NOT NULL,
  cantidad INT NOT NULL,
  descripcion VARCHAR(45) NOT NULL,
  PRIMARY KEY (id_reserva_habitacion_detalle),
  FOREIGN KEY (id_reserva_habitacion_detalle) REFERENCES reserva_habitacion(id_reserva_habitacion) ON DELETE RESTRICT,
  FOREIGN KEY (id_reserva_habitacion_detalle) REFERENCES habitacion(id_habitacion) ON DELETE RESTRICT
);

# esta tabla sera la egargada del tipo de pago del hotel, si es tarjeta de credito, debito, etc.
CREATE TABLE tipo_pago (
  id_tipo_pago INT NOT NULL AUTO_INCREMENT,
  tipo_pago VARCHAR(45) NOT NULL,
  PRIMARY KEY (id_tipo_pago),
  FOREIGN KEY (id_tipo_pago) REFERENCES reserva(id_reserva) ON DELETE RESTRICT
);

# cancelacion de resevaciones
CREATE TABLE cancelacion (
  id_cancelacion INT NOT NULL AUTO_INCREMENT,
  id_reserva INT NOT NULL,
  id_tipo_pago INT NOT NULL,
  fecha_cancelacion DATE NOT NULL,
  monto INT NOT NULL,
  PRIMARY KEY (id_cancelacion),
  FOREIGN KEY (id_cancelacion) REFERENCES reserva(id_reserva) ON DELETE RESTRICT,
  FOREIGN KEY (id_cancelacion) REFERENCES tipo_pago(id_tipo_pago) ON DELETE RESTRICT
);

#pagos
CREATE TABLE pago (
  id_pago INT NOT NULL AUTO_INCREMENT,
  id_reserva INT NOT NULL,
  id_tipo_pago INT NOT NULL,
  fecha_pago DATE NOT NULL,
  monto INT NOT NULL,
  PRIMARY KEY (id_pago),
  FOREIGN KEY (id_pago) REFERENCES reserva(id_reserva) ON DELETE RESTRICT,
  FOREIGN KEY (id_pago) REFERENCES tipo_pago(id_tipo_pago) ON DELETE RESTRICT
);
#seguros
CREATE TABLE seguro (
  id_seguro INT NOT NULL AUTO_INCREMENT,
  tipo_seguro VARCHAR(45) NOT NULL,
  tipo_seguro_descripcion VARCHAR(45) NOT NULL,
  id_reserva INT NOT NULL,
  id_tipo_pago INT NOT NULL,
  fecha_pago DATE NOT NULL,
  monto INT NOT NULL,
  PRIMARY KEY (id_seguro),
  FOREIGN KEY (id_seguro) REFERENCES reserva(id_reserva) ON DELETE RESTRICT,
  FOREIGN KEY (id_seguro) REFERENCES tipo_pago(id_tipo_pago) ON DELETE RESTRICT
);

CREATE TABLE cliente_pais (
  id_cliente INT NOT NULL,
  id_pais INT NOT NULL,
  PRIMARY KEY (id_cliente, id_pais),
  FOREIGN KEY (id_cliente) REFERENCES cliente (id_cliente),
  FOREIGN KEY (id_pais) REFERENCES pais (id_pais)
);

CREATE TABLE cliente_compañia (
  id_cliente INT NOT NULL,
  id_compania INT NOT NULL,
  PRIMARY KEY (id_cliente, id_compania),
  FOREIGN KEY (id_cliente) REFERENCES cliente (id_cliente),
  FOREIGN KEY (id_compania) REFERENCES compañia (id_compania)
);

CREATE TABLE cliente_sucursal (
  id_cliente INT NOT NULL,
  id_sucursal INT NOT NULL,
  PRIMARY KEY (id_cliente, id_sucursal),
  FOREIGN KEY (id_cliente) REFERENCES cliente (id_cliente),
  FOREIGN KEY (id_sucursal) REFERENCES sucursal (id_sucursal)
);

CREATE TABLE cliente_habitacion (
  id_cliente INT NOT NULL,
  id_habitacion INT NOT NULL,
  PRIMARY KEY (id_cliente, id_habitacion),
  FOREIGN KEY (id_cliente) REFERENCES cliente (id_cliente),
  FOREIGN KEY (id_habitacion) REFERENCES habitacion (id_habitacion)
);

CREATE TABLE cliente_reserva (
  id_cliente INT NOT NULL,
  id_reserva INT NOT NULL,
  PRIMARY KEY (id_cliente, id_reserva),
  FOREIGN KEY (id_cliente) REFERENCES cliente (id_cliente),
  FOREIGN KEY (id_reserva) REFERENCES reserva (id_reserva)
);


CREATE TABLE cliente_reserva_habitacion (
  id_cliente INT NOT NULL,
  id_reserva INT NOT NULL,
  id_habitacion INT NOT NULL,
  PRIMARY KEY (id_cliente, id_reserva, id_habitacion),
  FOREIGN KEY (id_cliente) REFERENCES cliente (id_cliente),
  FOREIGN KEY (id_reserva) REFERENCES reserva (id_reserva),
  FOREIGN KEY (id_habitacion) REFERENCES habitacion (id_habitacion)
);


CREATE TABLE cliente_reserva_habitacion_detalle (
  id_cliente INT NOT NULL,
  id_reserva INT NOT NULL,
  id_habitacion INT NOT NULL,
  id_reserva_habitacion_detalle INT NOT NULL,
  PRIMARY KEY (id_cliente, id_reserva, id_habitacion, id_reserva_habitacion_detalle),
  FOREIGN KEY (id_cliente) REFERENCES cliente (id_cliente),
  FOREIGN KEY (id_reserva) REFERENCES reserva (id_reserva),
  FOREIGN KEY (id_habitacion) REFERENCES habitacion (id_habitacion),
  FOREIGN KEY (id_reserva_habitacion_detalle) REFERENCES reserva_habitacion_detalle (id_reserva_habitacion_detalle)
);


CREATE TABLE cliente_reserva_habitacion_detalle_tipo_pago (
  id_cliente INT NOT NULL,
  id_reserva INT NOT NULL,
  id_habitacion INT NOT NULL,
  id_reserva_habitacion_detalle INT NOT NULL,
  id_tipo_pago INT NOT NULL,
  PRIMARY KEY (id_cliente, id_reserva, id_habitacion, id_reserva_habitacion_detalle, id_tipo_pago),
  FOREIGN KEY (id_cliente) REFERENCES cliente (id_cliente),
  FOREIGN KEY (id_reserva) REFERENCES reserva (id_reserva),
  FOREIGN KEY (id_habitacion) REFERENCES habitacion (id_habitacion),
  FOREIGN KEY (id_reserva_habitacion_detalle) REFERENCES reserva_habitacion_detalle (id_reserva_habitacion_detalle),
  FOREIGN KEY (id_tipo_pago) REFERENCES tipo_pago (id_tipo_pago)
);


CREATE TABLE cliente_reserva_habitacion_detalle_tipo_pago_cancelacion (
  id_cliente INT NOT NULL,
  id_reserva INT NOT NULL,
  id_habitacion INT NOT NULL,
  id_reserva_habitacion_detalle INT NOT NULL,
  id_tipo_pago INT NOT NULL,
  id_cancelacion INT NOT NULL,
  PRIMARY KEY (id_cliente, id_reserva, id_habitacion, id_reserva_habitacion_detalle, id_tipo_pago, id_cancelacion),
  FOREIGN KEY (id_cliente) REFERENCES cliente (id_cliente),
  FOREIGN KEY (id_reserva) REFERENCES reserva (id_reserva),
  FOREIGN KEY (id_habitacion) REFERENCES habitacion (id_habitacion),
  FOREIGN KEY (id_reserva_habitacion_detalle) REFERENCES reserva_habitacion_detalle (id_reserva_habitacion_detalle),
  FOREIGN KEY (id_tipo_pago) REFERENCES tipo_pago (id_tipo_pago),
  FOREIGN KEY (id_cancelacion) REFERENCES cancelacion (id_cancelacion)
);





