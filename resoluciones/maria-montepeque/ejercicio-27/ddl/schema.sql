PRAGMA foreign_keys = ON;

-- Ejercicio 27: Indices y Busquedas
-- Modelo: categorias, cursos, instructores, inscripciones

CREATE TABLE categorias (
    id_categoria  INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre        TEXT NOT NULL UNIQUE
);

CREATE TABLE instructores (
    id_instructor  INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre         TEXT NOT NULL,
    correo         TEXT NOT NULL UNIQUE
);

CREATE TABLE cursos (
    id_curso          INTEGER PRIMARY KEY AUTOINCREMENT,
    id_categoria      INTEGER NOT NULL,
    id_instructor     INTEGER NOT NULL,
    nombre            TEXT NOT NULL UNIQUE,
    precio            REAL NOT NULL CHECK (precio > 0),
    duracion_horas    INTEGER NOT NULL CHECK (duracion_horas > 0),

    FOREIGN KEY (id_categoria) REFERENCES categorias (id_categoria),
    FOREIGN KEY (id_instructor) REFERENCES instructores (id_instructor)
);

CREATE TABLE inscripciones (
    id_inscripcion       INTEGER PRIMARY KEY AUTOINCREMENT,
    id_curso             INTEGER NOT NULL,
    estudiante_nombre    TEXT NOT NULL,
    estudiante_correo    TEXT NOT NULL,
    fecha_inscripcion    TEXT NOT NULL,   -- ISO 'YYYY-MM-DD'
    estado               TEXT NOT NULL CHECK (estado IN ('inscrito', 'completado', 'cancelado')),

    FOREIGN KEY (id_curso) REFERENCES cursos (id_curso)
);

-- Indices para busquedas frecuentes (tema del ejercicio)
-- Nota: las columnas UNIQUE (categorias.nombre, instructores.correo, cursos.nombre)
-- ya generan un indice automatico en SQLite; estos indices adicionales
-- aceleran filtros y joins que no estan cubiertos por esas restricciones.
CREATE INDEX idx_cursos_id_categoria ON cursos (id_categoria);
CREATE INDEX idx_inscripciones_id_curso ON inscripciones (id_curso);
CREATE INDEX idx_inscripciones_estudiante_correo ON inscripciones (estudiante_correo);
