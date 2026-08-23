-- Ejercicio 25: Reportes Biblioteca
-- Operaciones sobre los datos base

-- 2 INSERT adicionales
INSERT INTO usuarios (nombre, correo) VALUES
    ('Ingrid Say', 'ingrid.say@correo.com');

INSERT INTO prestamos (id_libro, id_usuario, fecha_prestamo, fecha_devolucion, estado) VALUES
    (2, 6, '2026-07-20', NULL, 'prestado');

-- 2 UPDATE validos
UPDATE prestamos
SET estado = 'devuelto', fecha_devolucion = '2026-07-25'
WHERE id_prestamo = 2;

UPDATE libros
SET autor = 'Gabriel Jose Garcia Marquez'
WHERE id_libro = 1;

-- 2 DELETE controlados con WHERE
DELETE FROM prestamos
WHERE id_prestamo = 8;

DELETE FROM prestamos
WHERE estado = 'prestado' AND id_prestamo = 10;
