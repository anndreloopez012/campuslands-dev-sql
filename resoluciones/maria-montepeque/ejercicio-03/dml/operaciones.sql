-- Ejercicio 03: Biblioteca Tech
-- Operaciones sobre los datos base

-- 2 INSERT adicionales
INSERT INTO autores (nombre) VALUES
    ('Joshua Bloch');

INSERT INTO prestamos (id_camper, id_libro, fecha_prestamo, fecha_devolucion, estado) VALUES
    (2, 5, '2026-07-14', NULL, 'prestado');

-- 2 UPDATE validos
UPDATE prestamos
SET estado = 'devuelto', fecha_devolucion = '2026-07-25'
WHERE id_prestamo = 3;

UPDATE libros
SET stock = stock - 1
WHERE id_libro = 5;

-- 2 DELETE controlados con WHERE
DELETE FROM prestamos
WHERE estado = 'devuelto'
  AND fecha_prestamo = '2026-07-01';

DELETE FROM prestamos
WHERE id_prestamo = 8;
