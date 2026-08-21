-- Ejercicio 29: Transacciones Reservas
-- Operaciones sobre los datos base

-- 2 INSERT adicionales
INSERT INTO usuarios (nombre, correo) VALUES
    ('Ingrid Say', 'ingrid.say@correo.com');

INSERT INTO reservas (id_usuario, id_recurso, fecha_inicio, fecha_fin, estado) VALUES
    (2, 3, '2026-08-12 09:00', '2026-08-12 11:00', 'pendiente');

-- 2 UPDATE validos
UPDATE reservas
SET estado = 'confirmada'
WHERE id_reserva = 4;

UPDATE recursos
SET precio_hora = 90.00
WHERE id_recurso = 1;

-- 2 DELETE controlados con WHERE
DELETE FROM reservas
WHERE id_reserva = 8;

DELETE FROM reservas
WHERE estado = 'pendiente' AND id_reserva = 10;

-- Demostracion de transaccion (tema del ejercicio): crear una reserva y su pago
-- de forma atomica. Si cualquiera de los dos INSERT fallara, ninguno se aplica.
BEGIN TRANSACTION;

INSERT INTO reservas (id_usuario, id_recurso, fecha_inicio, fecha_fin, estado) VALUES
    (3, 4, '2026-08-15 17:00', '2026-08-15 20:00', 'confirmada');

INSERT INTO pagos (id_reserva, monto, fecha) VALUES
    (last_insert_rowid(), 750.00, '2026-08-15');

COMMIT;

-- Demostracion de ROLLBACK: se inicia una reserva de prueba y se revierte
-- antes de confirmarla, dejando la base de datos sin cambios (consistencia).
BEGIN TRANSACTION;

INSERT INTO reservas (id_usuario, id_recurso, fecha_inicio, fecha_fin, estado) VALUES
    (4, 5, '2026-08-20 08:00', '2026-08-20 10:00', 'pendiente');

ROLLBACK;
