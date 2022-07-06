-- Active: 1648930287171@@127.0.0.1@3306@proyectobd
CREATE DATABASE proyectobd;
USE proyectobd;

# Creacion de tablas 


# Tabla usuarios 
CREATE TABLE cliente (
  id_cliente INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(45) NOT NULL,
  apellido VARCHAR(45) NOT NULL,
  email VARCHAR(45) NOT NULL,
  telefono VARCHAR(45) NOT NULL,
  direccion VARCHAR(45) NOT NULL,
  PRIMARY KEY (id_cliente)
);  
# en esta tabla se encargara de los paises de los clientes
CREATE TABLE pais (
  id_pais INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(45) NOT NULL,
  PRIMARY KEY (id_pais)
);

# en esta tabla se encargara de la compañia de los viajes o hoteles de los clientes.
CREATE TABLE compañia (
  id_compania INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(45) NOT NULL,
  telefono VARCHAR(45) NOT NULL,
  direccion VARCHAR(45) NOT NULL,
  PRIMARY KEY (id_compania)
);

# sucursales de la compañia
CREATE TABLE sucursal (
  id_sucursal INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(45) NOT NULL,
  telefono VARCHAR(45) NOT NULL,
  direccion VARCHAR(45) NOT NULL,
  PRIMARY KEY (id_sucursal)
);

# esta tabala se encargara del tipo de moneda que se utilizara en los viajes o hoteles para los pagos.
CREATE TABLE Moneda (
  id_moneda INT NOT NULL AUTO_INCREMENT,
   tipo_moneda VARCHAR(45) NOT NULL,
    PRIMARY KEY (id_moneda)
);

CREATE TABLE habitacion (
  id_habitacion INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(45) NOT NULL,
  tipo_habitacion VARCHAR(45) NOT NULL,
  precio INT NOT NULL,
  numero_habitacion INT NOT NULL,
  PRIMARY KEY (id_habitacion)
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
  PRIMARY KEY (id_reserva)
);

CREATE TABLE reserva_habitacion (
  id_reserva_habitacion INT NOT NULL AUTO_INCREMENT,
  id_reserva INT NOT NULL,
  id_habitacion INT NOT NULL,
  PRIMARY KEY (id_reserva_habitacion)
);

CREATE TABLE reserva_habitacion_detalle (
  id_reserva_habitacion_detalle INT NOT NULL AUTO_INCREMENT,
  id_reserva_habitacion INT NOT NULL,
  id_habitacion INT NOT NULL,
  cantidad INT NOT NULL,
  descripcion VARCHAR(45) NOT NULL,
  PRIMARY KEY (id_reserva_habitacion_detalle)
);

# esta tabla sera la egargada del tipo de pago del hotel, si es tarjeta de credito, debito, etc.
CREATE TABLE tipo_pago (
  id_tipo_pago INT NOT NULL AUTO_INCREMENT,
  tipo_pago VARCHAR(45) NOT NULL,
  PRIMARY KEY (id_tipo_pago)
);

# cancelacion de resevaciones
CREATE TABLE cancelacion (
  id_cancelacion INT NOT NULL AUTO_INCREMENT,
  id_reserva INT NOT NULL,
  id_tipo_pago INT NOT NULL,
  fecha_cancelacion DATE NOT NULL,
  monto INT NOT NULL,
  PRIMARY KEY (id_cancelacion)
);

#pagos
CREATE TABLE pago (
  id_pago INT NOT NULL AUTO_INCREMENT,
  id_reserva INT NOT NULL,
  id_tipo_pago INT NOT NULL,
  fecha_pago DATE NOT NULL,
  monto INT NOT NULL,
  PRIMARY KEY (id_pago)
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
  PRIMARY KEY (id_seguro)
);




