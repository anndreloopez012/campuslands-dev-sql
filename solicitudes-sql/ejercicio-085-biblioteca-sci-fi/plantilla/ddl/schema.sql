PRAGMA foreign_keys = ON;

-- Ejercicio 085: Biblioteca Sci-Fi
-- Cree aqui las tablas segun su analisis del requerimiento.
-- No copie este ejemplo literalmente si no se adapta a su caso.

-- Tabla principal sugerida:
-- CREATE TABLE libros (
--   id INTEGER PRIMARY KEY AUTOINCREMENT,
--   nombre TEXT NOT NULL,
--   estado TEXT NOT NULL DEFAULT 'activo' CHECK (estado IN ('activo', 'inactivo'))
-- );

-- Tabla relacionada sugerida:
-- CREATE TABLE devoluciones (
--   id INTEGER PRIMARY KEY AUTOINCREMENT,
--   libro_id INTEGER NOT NULL,
--   fecha TEXT NOT NULL,
--   observacion TEXT,
--   FOREIGN KEY (libro_id) REFERENCES libros(id)
-- );
