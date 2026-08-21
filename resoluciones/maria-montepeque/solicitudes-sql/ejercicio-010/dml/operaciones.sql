PRAGMA foreign_keys = ON;

-- Ejercicio 010: Biblioteca Sci-Fi
-- Operaciones de mantenimiento (UPDATE / DELETE controlados).

-- 1. Karen Solis finalmente devolvio el libro atrasado (id_prestamo = 3):
--    se corrige el estado de 'atrasado' a 'devuelto' y se registra la
--    fecha real de devolucion. WHERE especifico por PK + estado actual.
UPDATE prestamos
SET estado = 'devuelto', fecha_devolucion = '2026-08-01'
WHERE id_prestamo = 3 AND estado = 'atrasado';

-- 2. El libro perdido (id_prestamo = 6, "Un Mundo Feliz") reduce
--    permanentemente el inventario disponible del libro 5.
UPDATE libros
SET copias_disponibles = copias_disponibles - 1
WHERE id_libro = 5;

-- 3. Se elimina la entrada de prueba (id_prestamo = 10): nunca fue un
--    prestamo real. DELETE seguro porque usa el id exacto de la fila.
DELETE FROM prestamos
WHERE id_prestamo = 10;
