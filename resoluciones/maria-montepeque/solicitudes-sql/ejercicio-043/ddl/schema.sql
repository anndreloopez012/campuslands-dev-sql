PRAGMA foreign_keys = ON;

-- Ejercicio 043: Escuela de Dibujo
-- Modelo: profesores -> cursos (1:N), y alumnos + cursos -> entregas
-- (doble FOREIGN KEY). 4 tablas en total.

CREATE TABLE profesores (
    id_profesor     INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_profesor TEXT NOT NULL UNIQUE,
    especialidad    TEXT NOT NULL CHECK (especialidad IN ('dibujo_realista', 'manga', 'pintura_digital', 'ilustracion_infantil'))
);

CREATE TABLE cursos (
    id_curso     INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_curso TEXT NOT NULL UNIQUE,
    id_profesor  INTEGER NOT NULL,
    cupo_maximo  INTEGER NOT NULL CHECK (cupo_maximo > 0),

    FOREIGN KEY (id_profesor) REFERENCES profesores (id_profesor)
);

CREATE TABLE alumnos (
    id_alumno     INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_alumno TEXT NOT NULL UNIQUE,
    email         TEXT NOT NULL UNIQUE
);

-- entregas: tabla principal. fecha_entrega es NOT NULL a proposito:
-- es el dato que, si faltara, volveria el registro inutil para un
-- reporte (la queja central del cliente).
CREATE TABLE entregas (
    id_entrega     INTEGER PRIMARY KEY AUTOINCREMENT,
    id_alumno      INTEGER NOT NULL,
    id_curso       INTEGER NOT NULL,
    fecha_entrega  TEXT NOT NULL,
    calificacion   REAL CHECK (calificacion IS NULL OR (calificacion BETWEEN 0 AND 100)),
    estado         TEXT NOT NULL DEFAULT 'pendiente' CHECK (estado IN ('pendiente', 'entregada', 'evaluada', 'rechazada')),

    FOREIGN KEY (id_alumno) REFERENCES alumnos (id_alumno),
    FOREIGN KEY (id_curso) REFERENCES cursos (id_curso)
);
