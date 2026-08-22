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
);

create table categorias (

    id_categoria int auto_increment primary key,
    id_producto int,
    categoria_producto varchar(60),

    foreign key (id_producto) references productos (id_producto)
);

create table ventas (
    id_venta int auto_increment primary key,
    id_cliente int,
    id_producto int,
    id_categoria int,
    fecha_venta datetime default current_timestamp,

    foreign key (id_cliente) references clientes(id_cliente),
    foreign key (id_producto) references productos(id_producto),
    foreign key (id_categoria) references categorias(id_categoria)
);
