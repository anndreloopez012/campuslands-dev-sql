PRAGMA foreign_keys = ON;

-- Ejercicio 018: Escuela de Dibujo
-- Modelo minimo: catalogo de cursos y registro de entregas.

CREATE TABLE cursos (
    id_curso     INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_curso TEXT NOT NULL UNIQUE,
    nivel        TEXT NOT NULL CHECK (nivel IN ('principiante', 'intermedio', 'avanzado')),
    precio       REAL NOT NULL CHECK (precio > 0)
);

-- entregas: tabla principal. calificacion se deja sin NOT NULL a
-- proposito: una entrega pendiente o rechazada todavia no tiene nota.
CREATE TABLE entregas (
    id_entrega    INTEGER PRIMARY KEY AUTOINCREMENT,
    id_curso      INTEGER NOT NULL,
    nombre_alumno TEXT NOT NULL,
    fecha_entrega TEXT NOT NULL DEFAULT (date('now')),
    calificacion  INTEGER CHECK (calificacion BETWEEN 0 AND 100),
    estado        TEXT NOT NULL DEFAULT 'pendiente' CHECK (estado IN ('pendiente', 'evaluada', 'rechazada')),

    FOREIGN KEY (id_curso) REFERENCES cursos (id_curso)
);
