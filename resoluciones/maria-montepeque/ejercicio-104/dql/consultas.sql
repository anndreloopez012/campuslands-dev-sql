.headers on
.mode column

-- Ejercicio 104: Triggers Nivel Basico
-- Consultas de validacion.

-- 1. Mostrar todos los datos principales.
SELECT id_libro, titulo, stock_total
FROM libros;

-- 2. Consulta con WHERE: solo los libros con menos de 3 copias.
SELECT id_libro, titulo, stock_total
FROM libros
WHERE stock_total < 3;

-- 3. Consulta con ORDER BY: libros ordenados de mayor a menor stock.
SELECT id_libro, titulo, stock_total
FROM libros
ORDER BY stock_total DESC;

-- 4. Conteo o resumen: total de cambios de stock auditados por libro.
SELECT id_libro, COUNT(*) AS total_cambios
FROM auditoria_libros
GROUP BY id_libro;

-- 5. Validacion especifica de Triggers: la tabla auditoria_libros
-- debe tener exactamente 3 filas (una por cada UPDATE de
-- dml/inserts.sql), generadas SOLAS por trg_auditar_cambio_stock, sin
-- que ningun INSERT manual haya tocado auditoria_libros en todo el
-- script. Esto demuestra que el trigger cumple su proposito:
-- automatizar el registro de auditoria ante cambios en "libros".
SELECT id_auditoria, id_libro, stock_anterior, stock_nuevo
FROM auditoria_libros
ORDER BY id_auditoria;

-- Caso comentado que no es recomendable, dejar comentado: crear un
-- trigger AFTER INSERT que referencia OLD, cuando en un INSERT no
-- existe ninguna fila "anterior" (OLD solo existe en UPDATE y
-- DELETE). Se verifico con Python (sqlite3) que el CREATE TRIGGER en
-- si no falla (SQLite no valida el cuerpo del trigger al crearlo),
-- pero el primer INSERT en "libros" que lo dispare falla con el error
-- "no such column: OLD.stock_total".
-- CREATE TRIGGER trg_auditar_insercion_mal
-- AFTER INSERT ON libros
-- FOR EACH ROW
-- BEGIN
--     INSERT INTO auditoria_libros (id_libro, stock_anterior, stock_nuevo)
--     VALUES (NEW.id_libro, OLD.stock_total, NEW.stock_total);
-- END;
--
-- INSERT INTO libros (titulo, stock_total) VALUES ('Domain-Driven Design', 4);
