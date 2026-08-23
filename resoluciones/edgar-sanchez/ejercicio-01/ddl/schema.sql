create database prueva;
use  prueva;
DROP TABLE IF EXISTS boletos;
DROP TABLE IF EXISTS funciones;
DROP TABLE IF EXISTS salas;
DROP TABLE IF EXISTS peliculas;

CREATE TABLE peliculas (
    pelicula_id INTEGER PRIMARY KEY auto_increment,
    titulo VARCHAR(120) NOT NULL,
    clasificacion VARCHAR(10) NOT NULL CHECK (clasificacion IN ('G', 'PG', 'PG-13', 'R', 'NC-17')),
    duracion_minutos INTEGER NOT NULL CHECK (duracion_minutos > 0),
    genero VARCHAR(50) NOT NULL,
    precio_base NUMERIC(6, 2) NOT NULL CHECK (precio_base > 0.00)
);

CREATE TABLE salas (
    sala_id INTEGER PRIMARY KEY auto_increment,
    nombre_sala VARCHAR(50) NOT NULL UNIQUE,
    capacidad_asientos INTEGER NOT NULL CHECK (capacidad_asientos BETWEEN 20 AND 500),
    tipo_pantalla VARCHAR(30) NOT NULL DEFAULT 'Estándar' CHECK (tipo_pantalla IN ('Estándar', '3D', 'IMAX', '4DX'))
);

CREATE TABLE funciones (
    funcion_id INTEGER PRIMARY KEY auto_increment,
    pelicula_id INTEGER NOT NULL,
    sala_id INTEGER NOT NULL,
    fecha_hora_inicio date,
    precio_boleto NUMERIC(6, 2) NOT NULL CHECK (precio_boleto > 0.00),
    FOREIGN KEY (pelicula_id) REFERENCES peliculas(pelicula_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (sala_id) REFERENCES salas(sala_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    UNIQUE (sala_id, fecha_hora_inicio)
);
CREATE TABLE boletos (
    boleto_id INTEGER PRIMARY KEY auto_increment,
    funcion_id INTEGER NOT NULL,
    numero_asiento VARCHAR(10) NOT NULL,
    fecha_venta TEXT NOT NULL DEFAULT (DATETIME('now')),
    metodo_pago VARCHAR(20) NOT NULL CHECK (metodo_pago IN ('Efectivo', 'Tarjeta', 'Transferencia')),
    monto_pagado NUMERIC(6, 2) NOT NULL CHECK (monto_pagado > 0.00),
    FOREIGN KEY (funcion_id) REFERENCES funciones(funcion_id) ON DELETE CASCADE ON UPDATE CASCADE,
    UNIQUE (funcion_id, numero_asiento)
);