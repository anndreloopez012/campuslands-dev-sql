PRAGMA foreign_keys = ON;


drop database if exists campus_shop;
create database campus_shop;
use campus_shop;

create table clientes(

    id_cliente int auto_increment primary key,
    nombre_cliente varchar (60) not null,
    telefono varchar(10) unique;
    direccion varchar(160),
    nit varchar(7)
);

create table productos (

    id_producto int auto_increment primary key,
    nombre_producto varchar(60) not null,
    cantidad_producto int check(cantidad_producto > 1),
    precio int,
    fecha_vencimiento datetime
);

