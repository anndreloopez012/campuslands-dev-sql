PRAGMA foreign_keys = ON;

-- Ejercicio 104: Triggers Nivel Basico
-- Tema central: Triggers
-- Cree aqui el DDL necesario.

-- Base recomendada:
-- CREATE TABLE ejemplo (
--   id INTEGER PRIMARY KEY AUTOINCREMENT,
--   nombre TEXT NOT NULL,
--   estado TEXT NOT NULL DEFAULT 'activo' CHECK (estado IN ('activo', 'inactivo'))
-- );

-- CREATE TRIGGER nombre_trigger
-- AFTER INSERT ON tabla
-- BEGIN
--   INSERT INTO auditoria (...);
-- END;
