PRAGMA foreign_keys = ON;

-- Ejercicio 25: Reportes Biblioteca
-- Modelo: sedes, libros, usuarios, prestamos

CREATE TABLE sedes (
    id_sede  INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre   TEXT NOT NULL UNIQUE,
    ciudad   TEXT NOT NULL
);

CREATE TABLE libros (
    id_libro  INTEGER PRIMARY KEY AUTOINCREMENT,
    id_sede   INTEGER NOT NULL,
    titulo    TEXT NOT NULL,
    autor     TEXT NOT NULL,
    isbn      TEXT NOT NULL UNIQUE,

    FOREIGN KEY (id_sede) REFERENCES sedes (id_sede)
);

CREATE TABLE usuarios (
    id_usuario  INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre      TEXT NOT NULL,
    correo      TEXT NOT NULL UNIQUE
);

CREATE TABLE prestamos (
    id_prestamo        INTEGER PRIMARY KEY AUTOINCREMENT,
    id_libro           INTEGER NOT NULL,
    id_usuario         INTEGER NOT NULL,
    fecha_prestamo     TEXT NOT NULL,   -- ISO 'YYYY-MM-DD'
    fecha_devolucion   TEXT,            -- ISO 'YYYY-MM-DD', NULL si aun no se devuelve
    estado             TEXT NOT NULL CHECK (estado IN ('prestado', 'devuelto', 'atrasado')),

    CHECK (fecha_devolucion IS NULL OR fecha_devolucion >= fecha_prestamo),
    FOREIGN KEY (id_libro) REFERENCES libros (id_libro),
    FOREIGN KEY (id_usuario) REFERENCES usuarios (id_usuario)
);
