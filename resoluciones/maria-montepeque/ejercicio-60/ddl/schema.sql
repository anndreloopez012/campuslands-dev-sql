PRAGMA foreign_keys = ON;

-- Ejercicio 60: DEFAULT Nivel Intermedio
-- Tema central: DEFAULT
-- Contexto: registro de campers inscritos en rutas de entrenamiento
-- (campers, rutas e inscripciones).

-- campers: DEFAULT para estado (nivel), bandera (activo) y fecha
-- (fecha_registro).
CREATE TABLE campers (
    id_camper      INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre         TEXT NOT NULL,
    email          TEXT NOT NULL UNIQUE,

    -- DEFAULT para estado: un camper nuevo entra como 'principiante' si no
    -- se indica otro nivel.
    nivel          TEXT NOT NULL DEFAULT 'principiante' CHECK (nivel IN ('principiante', 'intermedio', 'avanzado')),

    -- DEFAULT para bandera: un camper nuevo se registra activo (1) salvo
    -- que se indique lo contrario.
    activo         INTEGER NOT NULL DEFAULT 1 CHECK (activo IN (0, 1)),

    -- DEFAULT para fecha: si no se indica, se usa la fecha del dia del
    -- registro.
    fecha_registro TEXT NOT NULL DEFAULT (date('now'))
);

-- rutas: DEFAULT para cantidad (cupo_maximo).
CREATE TABLE rutas (
    id_ruta     INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_ruta TEXT NOT NULL,

    -- DEFAULT para cantidad: si no se indica, la ruta abre con un cupo
    -- estandar de 10 campers.
    cupo_maximo INTEGER NOT NULL DEFAULT 10 CHECK (cupo_maximo > 0)
);

-- inscripciones: tabla principal. DEFAULT para estado (estado de la
-- inscripcion) y para fecha (fecha_inscripcion).
CREATE TABLE inscripciones (
    id_inscripcion    INTEGER PRIMARY KEY AUTOINCREMENT,
    id_camper         INTEGER NOT NULL,
    id_ruta           INTEGER NOT NULL,

    -- DEFAULT para estado: toda inscripcion nueva empieza como 'activa'.
    estado            TEXT NOT NULL DEFAULT 'activa' CHECK (estado IN ('activa', 'completada', 'cancelada')),

    -- DEFAULT para fecha: si no se indica, se usa la fecha/hora actual del
    -- momento en que se registra la inscripcion.
    fecha_inscripcion TEXT NOT NULL DEFAULT (datetime('now')),

    FOREIGN KEY (id_camper) REFERENCES campers (id_camper),
    FOREIGN KEY (id_ruta) REFERENCES rutas (id_ruta)
);
