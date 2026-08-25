PRAGMA foreign_keys = ON;

-- Ejercicio 085: Biblioteca Sci-Fi
-- Modelo: autores -> libros (1:N); libros + lectores -> prestamos
-- (1:N cada una); prestamos -> devoluciones (1:1). A diferencia de
-- versiones mas simples de este mismo caso, aqui la devolucion es su
-- propia tabla (ver decision documentada en analisis/requerimiento.md).

CREATE TABLE autores (
    id_autor      INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_autor  TEXT NOT NULL UNIQUE,
    nacionalidad  TEXT NOT NULL
);

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

CREATE TABLE prestamos (
    id_prestamo                INTEGER PRIMARY KEY AUTOINCREMENT,
    id_libro                   INTEGER NOT NULL,
    id_lector                  INTEGER NOT NULL,
    fecha_prestamo              TEXT NOT NULL,
    fecha_devolucion_esperada  TEXT NOT NULL,
    estado                     TEXT NOT NULL DEFAULT 'prestado'
                                   CHECK (estado IN ('prestado', 'devuelto', 'atrasado', 'perdido')),

    FOREIGN KEY (id_libro) REFERENCES libros (id_libro),
    FOREIGN KEY (id_lector) REFERENCES lectores (id_lector),
    CHECK (fecha_devolucion_esperada > fecha_prestamo)
);

-- devoluciones: evento de negocio separado de prestamos (ver
-- analisis/requerimiento.md). UNIQUE (id_prestamo) impide registrar
-- la misma devolucion dos veces.
CREATE TABLE devoluciones (
    id_devolucion            INTEGER PRIMARY KEY AUTOINCREMENT,
    id_prestamo              INTEGER NOT NULL UNIQUE,
    fecha_devolucion_real    TEXT NOT NULL,
    estado_libro             TEXT NOT NULL CHECK (estado_libro IN ('bueno', 'danado', 'perdido')),

    FOREIGN KEY (id_prestamo) REFERENCES prestamos (id_prestamo)
);

-- Vista SQL (requerida en nivel 5): resumen completo de cada
-- prestamo, con LEFT JOIN a devoluciones para que un prestamo
-- todavia activo siga siendo visible en el reporte.
CREATE VIEW vista_resumen_prestamos AS
    SELECT
        pr.id_prestamo,
        lec.nombre_lector,
        lib.titulo,
        aut.nombre_autor,
        pr.fecha_prestamo,
        pr.fecha_devolucion_esperada,
        pr.estado,
        dev.fecha_devolucion_real,
        dev.estado_libro
    FROM prestamos pr
    JOIN lectores lec ON lec.id_lector = pr.id_lector
    JOIN libros lib ON lib.id_libro = pr.id_libro
    JOIN autores aut ON aut.id_autor = lib.id_autor
    LEFT JOIN devoluciones dev ON dev.id_prestamo = pr.id_prestamo;
