-- Ejercicio 09: Gimnasio Membresias
-- Operaciones sobre los datos base

-- 2 INSERT adicionales
INSERT INTO planes (nombre, duracion_meses, precio) VALUES
    ('Plan Familiar', 3, 900.00);

INSERT INTO pagos (id_membresia, monto, fecha_pago, metodo) VALUES
    (5, 100.00, '2026-08-01', 'efectivo');

-- 2 UPDATE validos
UPDATE membresias
SET estado = 'cancelada'
WHERE id_membresia = 6;

UPDATE clientes
SET correo = 'oscar.villagran2@correo.com'
WHERE id_cliente = 2;

-- 2 DELETE controlados con WHERE
DELETE FROM pagos
WHERE id_pago = 11;

DELETE FROM pagos
WHERE metodo = 'efectivo'
  AND id_membresia = 6;
