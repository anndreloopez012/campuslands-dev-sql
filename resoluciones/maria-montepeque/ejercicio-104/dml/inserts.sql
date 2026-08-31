PRAGMA foreign_keys = ON;

-- Ejercicio 104: Triggers Nivel Basico
-- Datos de prueba: 3 libros, 3 cambios de stock (cada uno dispara el trigger de auditoria).

INSERT INTO libros (titulo, stock_total) VALUES
    ('Clean Code',        5),
    ('Refactoring',        3),
    ('Design Patterns',    2);

-- Cada UPDATE de aqui abajo dispara trg_auditar_cambio_stock y deja
-- una fila nueva en auditoria_libros, sin ningun INSERT manual sobre
-- esa tabla.
UPDATE libros SET stock_total = 4 WHERE id_libro = 1; -- Clean Code: se presta una copia (5 -> 4)
UPDATE libros SET stock_total = 6 WHERE id_libro = 1; -- Clean Code: llegan copias nuevas (4 -> 6)
UPDATE libros SET stock_total = 2 WHERE id_libro = 2; -- Refactoring: se presta una copia (3 -> 2)

-- Caso comentado que no se debe hacer, dejar comentado: dejar el
-- stock de un libro en negativo. El CHECK (stock_total >= 0) lo rechaza.
-- UPDATE libros SET stock_total = -1 WHERE id_libro = 3;
