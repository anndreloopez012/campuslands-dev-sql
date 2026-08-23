PRAGMA foreign_keys = ON;

-- Ejercicio 46: PRIMARY KEY Nivel Aplicado
-- Tema central: PRIMARY KEY
-- Contexto: prestamos de libros tecnicos en una biblioteca.

CREATE TABLE autores (
    id_autor   INTEGER PRIMARY KEY AUTOINCREMENT,   -- PRIMARY KEY subrogada
    nombre     TEXT NOT NULL UNIQUE
);

-- libros: el isbn se deja como UNIQUE (no como PRIMARY KEY). Se prefirio
-- id_libro subrogado porque el isbn puede no estar disponible al momento de
-- catalogar un libro tecnico interno (fotocopiado, manual, etc.), y una
-- PRIMARY KEY no puede quedar en blanco.
CREATE TABLE libros (
    id_libro    INTEGER PRIMARY KEY AUTOINCREMENT,
    isbn        TEXT UNIQUE,
    titulo      TEXT NOT NULL,
    id_autor    INTEGER NOT NULL,

    FOREIGN KEY (id_autor) REFERENCES autores (id_autor)
);

-- prestamos: cada fila es un EVENTO de prestamo, identificado por su propia
-- PRIMARY KEY (id_prestamo). Esto es lo que permite que el mismo libro se
-- preste varias veces (incluso al mismo prestatario, en fechas distintas)
-- sin que la base de datos los confunda entre si: la PRIMARY KEY de
-- `prestamos` no depende de id_libro ni de prestatario, es un identificador
-- propio del evento.
CREATE TABLE prestamos (
    id_prestamo        INTEGER PRIMARY KEY AUTOINCREMENT,
    id_libro           INTEGER NOT NULL,
    prestatario        TEXT NOT NULL,
    fecha_prestamo     TEXT NOT NULL,
    fecha_devolucion   TEXT,   -- NULL mientras el libro no se devuelve

    FOREIGN KEY (id_libro) REFERENCES libros (id_libro)
);
