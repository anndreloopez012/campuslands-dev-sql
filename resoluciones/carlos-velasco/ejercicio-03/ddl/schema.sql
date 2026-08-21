PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS prestamos;
DROP TABLE IF EXISTS libros;
DROP TABLE IF EXISTS campers;
DROP TABLE IF EXISTS autores;

CREATE TABLE autores (
    id_autor INTEGER PRIMARY KEY,
    nombre_completo TEXT NOT NULL,
    nacionalidad TEXT NOT NULL,
    fecha_nacimiento TEXT NOT NULL,
    CONSTRAINT uq_autor_nombre UNIQUE (nombre_completo),
    CONSTRAINT chk_autor_fecha
        CHECK (
            fecha_nacimiento GLOB '[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]'
        )
);

CREATE TABLE libros (
    id_libro INTEGER PRIMARY KEY,
    titulo TEXT NOT NULL,
    isbn TEXT NOT NULL UNIQUE,
    anio_publicacion INTEGER NOT NULL,
    paginas INTEGER NOT NULL,
    id_autor INTEGER NOT NULL,
    FOREIGN KEY (id_autor)
        REFERENCES autores(id_autor),
    CONSTRAINT chk_libro_anio
        CHECK (anio_publicacion BETWEEN 1000 AND 2100),
    CONSTRAINT chk_libro_paginas
        CHECK (paginas > 0)
);

CREATE TABLE campers (
    id_camper INTEGER PRIMARY KEY,
    nombre_completo TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    fecha_ingreso TEXT NOT NULL,
    nivel TEXT NOT NULL,
    CONSTRAINT chk_camper_nivel
        CHECK (nivel IN ('JUNIOR', 'MID', 'SENIOR')),
    CONSTRAINT chk_camper_fecha
        CHECK (
            fecha_ingreso GLOB '[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]'
        )
);

CREATE TABLE prestamos (
    id_prestamo INTEGER PRIMARY KEY,
    id_libro INTEGER NOT NULL,
    id_camper INTEGER NOT NULL,
    fecha_prestamo TEXT NOT NULL,
    fecha_devolucion TEXT,
    estado TEXT NOT NULL DEFAULT 'PRESTADO',
    FOREIGN KEY (id_libro)
        REFERENCES libros(id_libro),
    FOREIGN KEY (id_camper)
        REFERENCES campers(id_camper),
    CONSTRAINT chk_prestamo_estado
        CHECK (estado IN ('PRESTADO', 'DEVUELTO')),
    CONSTRAINT chk_prestamo_fechas
        CHECK (
            fecha_devolucion IS NULL
            OR fecha_devolucion >= fecha_prestamo
        )
);