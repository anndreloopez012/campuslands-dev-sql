PRAGMA foreign_keys = ON;

-- Ejercicio 048: Clanes Shooter
-- Cree aqui las tablas segun su analisis del requerimiento.
-- No copie este ejemplo literalmente si no se adapta a su caso.

-- Tabla principal sugerida:
-- CREATE TABLE clanes (
--   id INTEGER PRIMARY KEY AUTOINCREMENT,
--   nombre TEXT NOT NULL,
--   estado TEXT NOT NULL DEFAULT 'activo' CHECK (estado IN ('activo', 'inactivo'))
-- );

-- Tabla relacionada sugerida:
-- CREATE TABLE scrims (
--   id INTEGER PRIMARY KEY AUTOINCREMENT,
--   clane_id INTEGER NOT NULL,
--   fecha TEXT NOT NULL,
--   observacion TEXT,
--   FOREIGN KEY (clane_id) REFERENCES clanes(id)
-- );
