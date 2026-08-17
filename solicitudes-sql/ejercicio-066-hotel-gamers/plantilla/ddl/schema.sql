PRAGMA foreign_keys = ON;

-- Ejercicio 066: Hotel Gamers
-- Cree aqui las tablas segun su analisis del requerimiento.
-- No copie este ejemplo literalmente si no se adapta a su caso.

-- Tabla principal sugerida:
-- CREATE TABLE huespedes (
--   id INTEGER PRIMARY KEY AUTOINCREMENT,
--   nombre TEXT NOT NULL,
--   estado TEXT NOT NULL DEFAULT 'activo' CHECK (estado IN ('activo', 'inactivo'))
-- );

-- Tabla relacionada sugerida:
-- CREATE TABLE eventos (
--   id INTEGER PRIMARY KEY AUTOINCREMENT,
--   huespede_id INTEGER NOT NULL,
--   fecha TEXT NOT NULL,
--   observacion TEXT,
--   FOREIGN KEY (huespede_id) REFERENCES huespedes(id)
-- );
