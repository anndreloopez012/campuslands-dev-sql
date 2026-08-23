PRAGMA foreign_keys = ON;

-- Ejercicio 42: Tipos de datos Nivel Intermedio
-- Tema central: Tipos de datos
-- Contexto: registro de campers inscritos en rutas de entrenamiento.

-- rutas: catalogo de rutas.
CREATE TABLE rutas (
    id_ruta            INTEGER PRIMARY KEY AUTOINCREMENT,   -- INTEGER: identificador entero
    nombre             TEXT NOT NULL UNIQUE,                -- TEXT: texto libre
    duracion_semanas   INTEGER NOT NULL CHECK (duracion_semanas > 0),   -- INTEGER: unidad entera de tiempo
    precio             REAL NOT NULL CHECK (precio > 0),     -- REAL: monto con decimales

    -- BOOLEAN simulado: SQLite no tiene BOOLEAN nativo. INTEGER 0/1 + CHECK
    -- + DEFAULT reproduce su comportamiento (1 = ruta abierta a inscripcion).
    activa             INTEGER NOT NULL DEFAULT 1 CHECK (activa IN (0, 1))
);

-- campers: catalogo de estudiantes.
CREATE TABLE campers (
    id_camper           INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre               TEXT NOT NULL,
    correo               TEXT NOT NULL UNIQUE,

    -- DATE simulado: SQLite no tiene DATE nativo. TEXT en formato ISO
    -- 'YYYY-MM-DD' valida con CHECK + GLOB y mantiene el orden cronologico
    -- al compararse como texto.
    fecha_nacimiento     TEXT NOT NULL CHECK (fecha_nacimiento GLOB '[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]'),

    -- BOOLEAN simulado: indica si el camper tiene beca.
    becado               INTEGER NOT NULL DEFAULT 0 CHECK (becado IN (0, 1))
);

-- inscripciones: relacion N:1 con camper y con ruta, mas atributos propios
-- de la inscripcion.
CREATE TABLE inscripciones (
    id_inscripcion      INTEGER PRIMARY KEY AUTOINCREMENT,
    id_camper           INTEGER NOT NULL,
    id_ruta             INTEGER NOT NULL,
    fecha_inscripcion   TEXT NOT NULL CHECK (fecha_inscripcion GLOB '[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]'),   -- DATE simulado

    -- REAL nullable: la nota final puede no existir todavia (camper en
    -- curso). REAL admite decimales (85.5) y NULL representa "sin nota aun".
    nota_final           REAL CHECK (nota_final IS NULL OR (nota_final >= 0 AND nota_final <= 100)),

    -- BOOLEAN simulado: se deriva/registra al cerrar la ruta.
    aprobado             INTEGER NOT NULL DEFAULT 0 CHECK (aprobado IN (0, 1)),

    FOREIGN KEY (id_camper) REFERENCES campers (id_camper),
    FOREIGN KEY (id_ruta) REFERENCES rutas (id_ruta),
    UNIQUE (id_camper, id_ruta)
);
