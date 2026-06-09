PRAGMA foreign_keys = ON;

-- Ejercicio 03: Biblioteca Tech

DROP TABLE IF EXISTS prestamos;

DROP TABLE IF EXISTS libros;

DROP TABLE IF EXISTS socios;

DROP TABLE IF EXISTS autores;

DROP TABLE IF EXISTS categorias;

CREATE TABLE categorias (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre TEXT NOT NULL UNIQUE,
    descripcion TEXT
);

CREATE TABLE autores (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre TEXT NOT NULL,
    nacionalidad TEXT NOT NULL DEFAULT 'Desconocida'
);

CREATE TABLE libros (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    titulo TEXT NOT NULL,
    isbn TEXT NOT NULL UNIQUE,
    anio_publicacion INTEGER NOT NULL CHECK (
        anio_publicacion BETWEEN 1900 AND 2026
    ),
    precio REAL NOT NULL CHECK (precio >= 0),
    stock INTEGER NOT NULL DEFAULT 0 CHECK (stock >= 0),
    estado TEXT NOT NULL DEFAULT 'disponible' CHECK (
        estado IN ('disponible', 'agotado')
    ),
    categoria_id INTEGER NOT NULL,
    autor_id INTEGER NOT NULL,
    FOREIGN KEY (categoria_id) REFERENCES categorias (id),
    FOREIGN KEY (autor_id) REFERENCES autores (id)
);

CREATE TABLE socios (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    fecha_registro TEXT NOT NULL,
    estado TEXT NOT NULL DEFAULT 'activo' CHECK (
        estado IN ('activo', 'inactivo')
    )
);

CREATE TABLE prestamos (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    libro_id INTEGER NOT NULL,
    socio_id INTEGER NOT NULL,
    fecha_prestamo TEXT NOT NULL,
    fecha_devolucion TEXT,
    estado TEXT NOT NULL DEFAULT 'prestado' CHECK (
        estado IN (
            'prestado',
            'devuelto',
            'atrasado'
        )
    ),
    FOREIGN KEY (libro_id) REFERENCES libros (id),
    FOREIGN KEY (socio_id) REFERENCES socios (id)
);