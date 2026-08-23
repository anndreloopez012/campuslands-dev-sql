-- Ejercicio 20: Eventos Boletos
-- Operaciones sobre los datos base

-- 2 INSERT adicionales
INSERT INTO asistentes (nombre, correo) VALUES
    ('Ingrid Say', 'ingrid.say@correo.com');

INSERT INTO boletos (id_evento, id_asistente, precio, estado, fecha_compra) VALUES
    (1, 6, 150.00, 'vendido', '2026-08-07');

-- 2 UPDATE validos
UPDATE boletos
SET estado = 'vendido'
WHERE id_boleto = 4;

UPDATE eventos
SET precio_base = 175.00
WHERE id_evento = 1;

-- 2 DELETE controlados con WHERE
DELETE FROM boletos
WHERE id_boleto = 8;

DELETE FROM boletos
WHERE estado = 'reservado' AND id_boleto = 7;
