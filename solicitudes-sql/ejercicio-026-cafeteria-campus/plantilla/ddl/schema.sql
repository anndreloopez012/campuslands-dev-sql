PRAGMA foreign_keys = ON;

-- Ejercicio 026: Cafeteria Campus
-- Cree aqui las tablas segun su analisis del requerimiento.
-- No copie este ejemplo literalmente si no se adapta a su caso.

-- Tabla principal sugerida:
-- CREATE TABLE productos (
--   id INTEGER PRIMARY KEY AUTOINCREMENT,
--   nombre TEXT NOT NULL,
--   estado TEXT NOT NULL DEFAULT 'activo' CHECK (estado IN ('activo', 'inactivo'))
-- );

-- Tabla relacionada sugerida:
-- CREATE TABLE ventas (
--   id INTEGER PRIMARY KEY AUTOINCREMENT,
--   producto_id INTEGER NOT NULL,
--   fecha TEXT NOT NULL,
--   observacion TEXT,
--   FOREIGN KEY (producto_id) REFERENCES productos(id)
-- );
