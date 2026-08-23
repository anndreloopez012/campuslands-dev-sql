-- Ejercicio 28: Vistas y Reportes
-- Operaciones sobre los datos base

-- 2 INSERT adicionales
INSERT INTO clientes (nombre, correo) VALUES
    ('Ingrid Say', 'ingrid.say@correo.com');

INSERT INTO pagos (id_venta, monto, metodo, fecha) VALUES
    (3, 150.00, 'transferencia', '2026-07-15');

-- 2 UPDATE validos
UPDATE pagos
SET metodo = 'transferencia'
WHERE id_pago = 1;

UPDATE ventas
SET total = 1250.00
WHERE id_venta = 4;

-- 2 DELETE controlados con WHERE
DELETE FROM pagos
WHERE id_pago = 6;

DELETE FROM pagos
WHERE metodo = 'efectivo' AND id_pago = 9;
