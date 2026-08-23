PRAGMA foreign_keys = ON;

-- Ejercicio 060: Biblioteca Sci-Fi
-- Operaciones de mantenimiento: UPDATE de estado y DELETE controlado.

-- 1. Karla Rivas devolvio Neuromante (id_prestamo = 5): se corrige el
--    estado de 'prestado' a 'devuelto'.
UPDATE prestamos
SET estado = 'devuelto'
WHERE id_prestamo = 5 AND estado = 'prestado';

-- 2. El prestamo de Fundacion a Bryan Solis (id_prestamo = 2) paso su
--    fecha de devolucion esperada sin que el libro volviera: se
--    marca como 'atrasado'.
UPDATE prestamos
SET estado = 'atrasado'
WHERE id_prestamo = 2 AND estado = 'prestado';

-- 3. DELETE controlado: se detectan y eliminan duplicados exactos de
--    forma general (mismo libro, mismo lector, misma fecha de
--    prestamo), conservando siempre la fila con el id mas bajo (el
--    primer registro real). Esto borra el prestamo 11 (copia exacta
--    del prestamo 1); ningun prestamo unico se ve afectado porque la
--    condicion solo es verdadera cuando existe otra fila identica
--    con un id anterior.
DELETE FROM prestamos
WHERE id_prestamo > (
    SELECT MIN(p2.id_prestamo)
    FROM prestamos p2
    WHERE p2.id_libro = prestamos.id_libro
      AND p2.id_lector = prestamos.id_lector
      AND p2.fecha_prestamo = prestamos.fecha_prestamo
);
