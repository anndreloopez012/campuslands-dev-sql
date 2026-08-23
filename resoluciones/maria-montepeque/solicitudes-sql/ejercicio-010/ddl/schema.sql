PRAGMA foreign_keys = ON;

-- Ejercicio 010: Biblioteca Sci-Fi
-- Modelo minimo: catalogo de libros y registro de prestamos/devoluciones.

-- libros: catalogo. titulo es UNIQUE (evita registros repetidos) y
-- anio_publicacion tiene un CHECK de rango (detecta valores fuera de
-- rango), tal como pidio el cliente.
CREATE TABLE libros (
    id_libro           INTEGER PRIMARY KEY AUTOINCREMENT,
    titulo             TEXT NOT NULL UNIQUE,
    autor              TEXT NOT NULL,
    anio_publicacion   INTEGER NOT NULL CHECK (anio_publicacion BETWEEN 1800 AND 2030),
    copias_disponibles INTEGER NOT NULL DEFAULT 1 CHECK (copias_disponibles >= 0)
);

-- prestamos: tabla principal. La FOREIGN KEY evita relaciones invalidas
-- (un prestamo de un libro que no existe).
CREATE TABLE prestamos (
    id_prestamo      INTEGER PRIMARY KEY AUTOINCREMENT,
    id_libro         INTEGER NOT NULL,
    nombre_lector    TEXT NOT NULL,
    fecha_prestamo   TEXT NOT NULL DEFAULT (date('now')),
    fecha_devolucion TEXT,
    estado           TEXT NOT NULL DEFAULT 'prestado' CHECK (estado IN ('prestado', 'devuelto', 'atrasado', 'perdido')),

    FOREIGN KEY (id_libro) REFERENCES libros (id_libro)
);
