PRAGMA foreign_keys = ON;

-- Ejercicio 043: Escuela de Dibujo
-- Cree aqui las tablas segun su analisis del requerimiento.
-- No copie este ejemplo literalmente si no se adapta a su caso.

-- Tabla principal sugerida:
-- CREATE TABLE alumnos (
--   id INTEGER PRIMARY KEY AUTOINCREMENT,
--   nombre TEXT NOT NULL,
--   estado TEXT NOT NULL DEFAULT 'activo' CHECK (estado IN ('activo', 'inactivo'))
-- );

-- Tabla relacionada sugerida:
-- CREATE TABLE entregas (
--   id INTEGER PRIMARY KEY AUTOINCREMENT,
--   alumno_id INTEGER NOT NULL,
--   fecha TEXT NOT NULL,
--   observacion TEXT,
--   FOREIGN KEY (alumno_id) REFERENCES alumnos(id)
-- );
