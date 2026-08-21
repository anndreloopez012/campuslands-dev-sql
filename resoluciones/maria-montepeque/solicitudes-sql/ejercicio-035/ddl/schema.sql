PRAGMA foreign_keys = ON;

-- Ejercicio 035: Biblioteca Sci-Fi
-- Modelo: dos catalogos independientes (libros, lectores) que
-- alimentan una tabla de movimientos (prestamos) con dos FOREIGN KEY.

CREATE TABLE libros (
    id_libro         INTEGER PRIMARY KEY AUTOINCREMENT,
    titulo           TEXT NOT NULL UNIQUE,
    autor            TEXT NOT NULL,
    genero           TEXT NOT NULL CHECK (genero IN ('space_opera', 'cyberpunk', 'distopia', 'hard_sci_fi')),
    anio_publicacion INTEGER NOT NULL
);

CREATE TABLE lectores (
    id_lector     INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_lector TEXT NOT NULL UNIQUE,
    email         TEXT NOT NULL
);

-- prestamos: tabla principal. NOT NULL en los campos que, si faltaran,
-- impedirian controlar devoluciones y atrasos, que es la queja
-- central del cliente.
CREATE TABLE prestamos (
    id_prestamo               INTEGER PRIMARY KEY AUTOINCREMENT,
    id_libro                  INTEGER NOT NULL,
    id_lector                 INTEGER NOT NULL,
    fecha_prestamo             TEXT NOT NULL,
    fecha_devolucion_esperada TEXT NOT NULL,
    estado                    TEXT NOT NULL DEFAULT 'prestado' CHECK (estado IN ('prestado', 'devuelto', 'atrasado', 'perdido')),

    FOREIGN KEY (id_libro) REFERENCES libros (id_libro),
    FOREIGN KEY (id_lector) REFERENCES lectores (id_lector),
    CHECK (fecha_devolucion_esperada > fecha_prestamo)
);
