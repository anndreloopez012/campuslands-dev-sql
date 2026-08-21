PRAGMA foreign_keys = ON;

-- Ejercicio 64: AUTO_INCREMENT Nivel Aplicado
-- Tema central: AUTO_INCREMENT
-- Contexto: prestamos de libros tecnicos de una biblioteca.

CREATE TABLE autores (
    id_autor   INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre     TEXT NOT NULL UNIQUE
);

CREATE TABLE libros (
    id_libro                  INTEGER PRIMARY KEY AUTOINCREMENT,
    id_autor                  INTEGER NOT NULL,
    titulo                    TEXT NOT NULL,
    categoria                 TEXT NOT NULL
                                  CHECK (categoria IN ('programacion', 'redes', 'bases_de_datos', 'sistemas_operativos')),
    ejemplares_disponibles    INTEGER NOT NULL DEFAULT 1 CHECK (ejemplares_disponibles >= 0),

    FOREIGN KEY (id_autor) REFERENCES autores (id_autor)
);

-- prestamos: id_prestamo se usa como numero de comprobante de prestamo;
-- no debe repetirse nunca, ni siquiera si un prestamo se elimina por
-- error, por eso se usa AUTOINCREMENT.
CREATE TABLE prestamos (
    id_prestamo         INTEGER PRIMARY KEY AUTOINCREMENT,
    id_libro            INTEGER NOT NULL,
    prestatario         TEXT NOT NULL,
    fecha_prestamo      TEXT NOT NULL DEFAULT (date('now')),
    fecha_devolucion    TEXT,
    estado              TEXT NOT NULL DEFAULT 'prestado'
                             CHECK (estado IN ('prestado', 'devuelto', 'atrasado')),

    FOREIGN KEY (id_libro) REFERENCES libros (id_libro)
);
