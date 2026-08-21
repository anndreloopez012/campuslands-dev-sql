PRAGMA foreign_keys = ON;

-- Ejercicio 37: Normalizacion Biblioteca Multiautor
-- Modelo normalizado (3FN): autores, libros, generos, usuarios, prestamos
-- + tablas puente libro_autor y libro_genero (relaciones N:M)

CREATE TABLE autores (
    id_autor  INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre    TEXT NOT NULL UNIQUE
);

CREATE TABLE generos (
    id_genero  INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre     TEXT NOT NULL UNIQUE
);

CREATE TABLE libros (
    id_libro  INTEGER PRIMARY KEY AUTOINCREMENT,
    titulo    TEXT NOT NULL UNIQUE CHECK (length(titulo) > 0)
);

CREATE TABLE usuarios (
    id_usuario  INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre      TEXT NOT NULL UNIQUE
);

-- Tabla puente: un libro puede tener varios autores y un autor puede tener
-- varios libros (relacion N:M). El CSV original repetia la lista completa
-- de autores en cada fila donde aparecia el libro.
CREATE TABLE libro_autor (
    id_libro  INTEGER NOT NULL,
    id_autor  INTEGER NOT NULL,

    PRIMARY KEY (id_libro, id_autor),
    FOREIGN KEY (id_libro) REFERENCES libros (id_libro),
    FOREIGN KEY (id_autor) REFERENCES autores (id_autor)
);

-- Tabla puente: un libro puede tener varios generos y un genero agrupa
-- varios libros (relacion N:M).
CREATE TABLE libro_genero (
    id_libro   INTEGER NOT NULL,
    id_genero  INTEGER NOT NULL,

    PRIMARY KEY (id_libro, id_genero),
    FOREIGN KEY (id_libro) REFERENCES libros (id_libro),
    FOREIGN KEY (id_genero) REFERENCES generos (id_genero)
);

-- Detalle transaccional: cada prestamo de un libro a un usuario.
CREATE TABLE prestamos (
    id_prestamo       INTEGER PRIMARY KEY AUTOINCREMENT,
    id_libro          INTEGER NOT NULL,
    id_usuario        INTEGER NOT NULL,
    fecha_devolucion  TEXT NOT NULL CHECK (fecha_devolucion GLOB '[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]'),  -- ISO 'YYYY-MM-DD'

    FOREIGN KEY (id_libro) REFERENCES libros (id_libro),
    FOREIGN KEY (id_usuario) REFERENCES usuarios (id_usuario)
);
