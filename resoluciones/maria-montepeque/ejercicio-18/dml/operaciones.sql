-- Ejercicio 18: Farmacia Inventario
-- Operaciones sobre los datos base

-- 2 INSERT adicionales
INSERT INTO laboratorios (nombre, pais) VALUES
    ('Sanofi', 'Francia');

INSERT INTO ventas (id_medicamento, cantidad, precio_unitario, fecha) VALUES
    (1, 6, 15.00, '2026-07-12');

-- 2 UPDATE validos
UPDATE medicamentos
SET stock = stock - 15
WHERE id_medicamento = 1;

UPDATE medicamentos
SET precio_venta = 9.00
WHERE id_medicamento = 4;

-- 2 DELETE controlados con WHERE
DELETE FROM ventas
WHERE id_venta = 8;

DELETE FROM ventas
WHERE id_medicamento = 5 AND id_venta = 10;

-- 2 operaciones comentadas que deben fallar por restricciones
-- Falla por UNIQUE (el nombre del laboratorio ya existe)
-- INSERT INTO laboratorios (nombre, pais) VALUES ('Bayer', 'Alemania');

-- Falla por CHECK (la cantidad vendida debe ser mayor a 0)
-- INSERT INTO ventas (id_medicamento, cantidad, precio_unitario, fecha) VALUES (2, 0, 25.00, '2026-07-13');
