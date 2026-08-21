PRAGMA foreign_keys = ON;

-- Ejercicio 58: CHECK Nivel Aplicado
-- Tema central: CHECK
-- Contexto: registro de campers inscritos en rutas de entrenamiento
-- (campers, rutas e inscripciones).

-- nivel: CHECK de valores permitidos.
CREATE TABLE campers (
    id_camper INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre    TEXT NOT NULL,
    email     TEXT NOT NULL UNIQUE,
    nivel     TEXT NOT NULL CHECK (nivel IN ('principiante', 'intermedio', 'avanzado'))
);

-- dificultad: CHECK de valores permitidos. cupo_maximo: CHECK de rango
-- numerico (una ruta con cupo 0 o negativo no se puede ofrecer).
CREATE TABLE rutas (
    id_ruta      INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_ruta  TEXT NOT NULL,
    dificultad   TEXT NOT NULL CHECK (dificultad IN ('baja', 'media', 'alta')),
    cupo_maximo  INTEGER NOT NULL CHECK (cupo_maximo > 0)
);

-- inscripciones: tabla principal del caso de negocio. Combina los tres
-- tipos de regla de dominio:
--   - estado: CHECK de valores permitidos.
--   - calificacion_final: CHECK de rango numerico (0 a 100).
--   - CHECK a nivel de tabla: solo puede existir calificacion si la
--     inscripcion esta 'completada' (regla de negocio entre dos columnas).
CREATE TABLE inscripciones (
    id_inscripcion     INTEGER PRIMARY KEY AUTOINCREMENT,
    id_camper          INTEGER NOT NULL,
    id_ruta            INTEGER NOT NULL,
    fecha_inscripcion  TEXT NOT NULL,
    estado             TEXT NOT NULL DEFAULT 'activa' CHECK (estado IN ('activa', 'completada', 'cancelada')),
    calificacion_final INTEGER CHECK (calificacion_final BETWEEN 0 AND 100),

    FOREIGN KEY (id_camper) REFERENCES campers (id_camper),
    FOREIGN KEY (id_ruta) REFERENCES rutas (id_ruta),
    CHECK (calificacion_final IS NULL OR estado = 'completada')
);
