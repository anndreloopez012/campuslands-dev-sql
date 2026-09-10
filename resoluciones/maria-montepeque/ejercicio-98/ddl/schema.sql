PRAGMA foreign_keys = ON;

-- Ejercicio 98: Vistas Nivel Basico
-- Tema central: Vistas
-- Contexto: registro de campers inscritos en rutas de entrenamiento.

CREATE TABLE campers (
    id_camper      INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_camper  TEXT NOT NULL,
    email          TEXT NOT NULL UNIQUE
);

CREATE TABLE inscripciones (
    id_inscripcion       INTEGER PRIMARY KEY AUTOINCREMENT,
    id_camper            INTEGER NOT NULL,
    nombre_ruta          TEXT NOT NULL,
    fecha_inscripcion    TEXT NOT NULL,
    estado               TEXT NOT NULL DEFAULT 'activo'
                             CHECK (estado IN ('activo', 'retirado', 'completado')),

    FOREIGN KEY (id_camper) REFERENCES campers (id_camper)
);

-- Vista: encapsula el JOIN + WHERE que se repetiria cada vez que se
-- necesita ver solo las inscripciones activas con el nombre del
-- camper, en vez de escribir esa consulta una y otra vez.
CREATE VIEW vista_inscripciones_activas AS
SELECT i.id_inscripcion,
       c.nombre_camper,
       i.nombre_ruta,
       i.fecha_inscripcion
FROM inscripciones i
JOIN campers c ON c.id_camper = i.id_camper
WHERE i.estado = 'activo';
