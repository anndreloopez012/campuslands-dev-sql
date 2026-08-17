-- Ejercicio 10: Hotel Reservas
-- Operaciones sobre los datos base

-- 2 INSERT adicionales
INSERT INTO huespedes (nombre, documento, correo) VALUES
    ('Ingrid Say', 'DPI-1006', 'ingrid.say@correo.com');

INSERT INTO pagos (id_reserva, monto, fecha_pago, metodo) VALUES
    (5, 100.00, '2026-08-09', 'efectivo');

-- 2 UPDATE validos
UPDATE reservas
SET estado = 'finalizada'
WHERE id_reserva = 3;

UPDATE habitaciones
SET precio_noche = 380.00
WHERE id_habitacion = 2;

-- 2 DELETE controlados con WHERE
DELETE FROM pagos
WHERE id_pago = 11;

DELETE FROM reservas
WHERE estado = 'cancelada'
  AND NOT EXISTS (SELECT 1 FROM pagos WHERE pagos.id_reserva = reservas.id_reserva);
