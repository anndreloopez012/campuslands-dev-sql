PRAGMA foreign_keys = ON;

-- Ejercicio 50: UNIQUE Nivel Basico
-- Tema central: UNIQUE
-- Contexto: prestamos de libros tecnicos en una biblioteca.

CREATE TABLE autores (
    id_autor  INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre    TEXT NOT NULL UNIQUE   -- UNIQUE: no pueden existir dos autores con el mismo nombre
);

-- libros: tabla principal del ejercicio.
-- id_libro es la PRIMARY KEY. isbn es UNIQUE, no PRIMARY KEY: a diferencia
-- de una PRIMARY KEY, una columna UNIQUE si puede quedar en NULL, y SQLite
-- permite VARIAS filas con isbn NULL (cada NULL se considera "distinto" de
-- los demas para efectos de UNIQUE). Esto es util aqui porque no todo
-- material de la biblioteca tiene ISBN (por ejemplo, manuales internos).
CREATE TABLE libros (
    id_libro    INTEGER PRIMARY KEY AUTOINCREMENT,
    isbn        TEXT UNIQUE,
    titulo      TEXT NOT NULL,
    id_autor    INTEGER NOT NULL,

    FOREIGN KEY (id_autor) REFERENCES autores (id_autor)
);

CREATE TABLE prestamos (
    id_prestamo        INTEGER PRIMARY KEY AUTOINCREMENT,
    id_libro           INTEGER NOT NULL,
    prestatario        TEXT NOT NULL,
    fecha_prestamo     TEXT NOT NULL,
    fecha_devolucion   TEXT,

    FOREIGN KEY (id_libro) REFERENCES libros (id_libro)
);
