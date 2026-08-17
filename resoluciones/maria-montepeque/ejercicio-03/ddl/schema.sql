PRAGMA foreign_keys = ON;

-- Ejercicio 03: Biblioteca Tech
-- Modelo: autores, libros, campers, prestamos

CREATE TABLE autores (
    id_autor    INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre      TEXT NOT NULL UNIQUE
);

CREATE TABLE libros (
    id_libro           INTEGER PRIMARY KEY AUTOINCREMENT,
    id_autor           INTEGER NOT NULL,
    titulo             TEXT NOT NULL,
    genero             TEXT NOT NULL,
    anio_publicacion   INTEGER NOT NULL CHECK (anio_publicacion > 0),
    stock              INTEGER NOT NULL CHECK (stock >= 0),

    FOREIGN KEY (id_autor) REFERENCES autores (id_autor)
);

CREATE TABLE campers (
    id_camper   INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre      TEXT NOT NULL,
    correo      TEXT NOT NULL UNIQUE,
    ficha       TEXT NOT NULL
);

CREATE TABLE prestamos (
    id_prestamo        INTEGER PRIMARY KEY AUTOINCREMENT,
    id_camper          INTEGER NOT NULL,
    id_libro           INTEGER NOT NULL,
    fecha_prestamo     TEXT NOT NULL,   -- ISO 'YYYY-MM-DD'
    fecha_devolucion   TEXT,            -- ISO 'YYYY-MM-DD', NULL si aun no se devuelve
    estado             TEXT NOT NULL DEFAULT 'prestado' CHECK (estado IN ('prestado', 'devuelto', 'atrasado')),

    FOREIGN KEY (id_camper) REFERENCES campers (id_camper),
    FOREIGN KEY (id_libro) REFERENCES libros (id_libro)
);
