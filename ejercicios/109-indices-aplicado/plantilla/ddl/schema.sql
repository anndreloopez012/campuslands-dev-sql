PRAGMA foreign_keys = ON;

-- Ejercicio 109: Indices Nivel Aplicado
-- Tema central: Indices
-- Cree aqui el DDL necesario.

-- Base recomendada:
-- CREATE TABLE ejemplo (
--   id INTEGER PRIMARY KEY AUTOINCREMENT,
--   nombre TEXT NOT NULL,
--   estado TEXT NOT NULL DEFAULT 'activo' CHECK (estado IN ('activo', 'inactivo'))
-- );

-- CREATE INDEX idx_tabla_columna ON tabla(columna);
