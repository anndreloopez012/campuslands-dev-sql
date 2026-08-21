PRAGMA foreign_keys = ON;

-- Ejercicio 060: Biblioteca Sci-Fi
-- Modelo: autores -> libros (1:N), y libros + lectores -> prestamos
-- (doble FOREIGN KEY). Cada restriccion ataca uno de los tres
-- errores que pidio detectar el cliente: repetidos (UNIQUE),
-- relaciones invalidas (FOREIGN KEY) y valores fuera de rango
-- (CHECK).

CREATE TABLE autores (
    id_autor      INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_autor  TEXT NOT NULL UNIQUE,
    nacionalidad  TEXT NOT NULL
);

-- Un mismo autor no puede repetir titulo (UNIQUE compuesto), pero
-- autores distintos si pueden compartir titulo.
CREATE TABLE libros (
    id_libro   INTEGER PRIMARY KEY AUTOINCREMENT,
    titulo     TEXT NOT NULL,
    id_autor   INTEGER NOT NULL,
    genero     TEXT NOT NULL CHECK (genero IN ('space_opera', 'cyberpunk', 'distopia', 'hard_sci_fi')),

    FOREIGN KEY (id_autor) REFERENCES autores (id_autor),
    UNIQUE (titulo, id_autor)
);

CREATE TABLE lectores (
    id_lector      INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_lector  TEXT NOT NULL UNIQUE,
    email          TEXT NOT NULL UNIQUE
);

-- prestamos: tabla principal. fecha_devolucion_esperada debe ser
-- posterior a fecha_prestamo, o la base de datos rechaza el INSERT.
CREATE TABLE prestamos (
    id_prestamo                INTEGER PRIMARY KEY AUTOINCREMENT,
    id_libro                   INTEGER NOT NULL,
    id_lector                  INTEGER NOT NULL,
    fecha_prestamo              TEXT NOT NULL,
    fecha_devolucion_esperada  TEXT NOT NULL,
    estado                     TEXT NOT NULL DEFAULT 'prestado' CHECK (estado IN ('prestado', 'devuelto', 'atrasado', 'perdido')),

    FOREIGN KEY (id_libro) REFERENCES libros (id_libro),
    FOREIGN KEY (id_lector) REFERENCES lectores (id_lector),
    CHECK (fecha_devolucion_esperada > fecha_prestamo)
);
