PRAGMA foreign_keys = ON;

-- Ejercicio 82: SELECT Nivel Aplicado
-- Tema central: SELECT
-- Contexto: biblioteca tecnica, prestamos de libros.

CREATE TABLE autores (
    id_autor      INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_autor  TEXT NOT NULL UNIQUE,
    especialidad  TEXT NOT NULL
);

CREATE TABLE libros (
    id_libro              INTEGER PRIMARY KEY AUTOINCREMENT,
    titulo                TEXT NOT NULL,
    id_autor              INTEGER NOT NULL,
    categoria             TEXT NOT NULL,
    ejemplares_totales    INTEGER NOT NULL CHECK (ejemplares_totales > 0),

    FOREIGN KEY (id_autor) REFERENCES autores (id_autor)
);

-- prestamos: fecha_devolucion queda NULL mientras el prestamo sigue
-- activo (el libro todavia no se devuelve).
CREATE TABLE prestamos (
    id_prestamo           INTEGER PRIMARY KEY AUTOINCREMENT,
    id_libro              INTEGER NOT NULL,
    nombre_prestatario    TEXT NOT NULL,
    fecha_prestamo        TEXT NOT NULL DEFAULT (date('now')),
    fecha_devolucion      TEXT,

    FOREIGN KEY (id_libro) REFERENCES libros (id_libro)
);
