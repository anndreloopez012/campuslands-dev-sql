PRAGMA foreign_keys = ON;

-- Ejercicio 48: FOREIGN KEY Nivel Intermedio
-- Tema central: FOREIGN KEY
-- Contexto: prestamos de libros tecnicos en una biblioteca.

CREATE TABLE autores (
    id_autor  INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre    TEXT NOT NULL UNIQUE
);

-- libros.id_autor -> autores.id_autor con ON DELETE RESTRICT (explicito):
-- el catalogo de libros es informacion que no se quiere perder solo porque
-- se elimino un autor; por eso NO se permite borrar un autor mientras
-- todavia tenga libros en el catalogo.
CREATE TABLE libros (
    id_libro    INTEGER PRIMARY KEY AUTOINCREMENT,
    titulo      TEXT NOT NULL,
    id_autor    INTEGER NOT NULL,

    FOREIGN KEY (id_autor) REFERENCES autores (id_autor)
        ON DELETE RESTRICT
);

-- prestamos.id_libro -> libros.id_libro con ON DELETE CASCADE: a diferencia
-- de la relacion anterior, si un libro se da de baja del catalogo (perdido,
-- descontinuado), tiene sentido de negocio eliminar tambien su historial de
-- prestamos junto con el. Este contraste (RESTRICT vs CASCADE) es el punto
-- central del ejercicio: la misma FOREIGN KEY puede comportarse distinto
-- segun la accion ON DELETE que se declare, y esa decision depende de la
-- regla de negocio, no de la sintaxis.
CREATE TABLE prestamos (
    id_prestamo        INTEGER PRIMARY KEY AUTOINCREMENT,
    id_libro           INTEGER NOT NULL,
    prestatario        TEXT NOT NULL,
    fecha_prestamo     TEXT NOT NULL,
    fecha_devolucion   TEXT,

    FOREIGN KEY (id_libro) REFERENCES libros (id_libro)
        ON DELETE CASCADE
);
