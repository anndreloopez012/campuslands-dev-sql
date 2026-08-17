-- Ejercicio 15: Taller de Motos
-- Operaciones sobre los datos base

-- 2 INSERT adicionales
INSERT INTO clientes (nombre, telefono, correo) VALUES
    ('Ingrid Say', '5022-1006', 'ingrid.say@correo.com');

INSERT INTO ordenes_servicio (id_moto, id_servicio, fecha, estado, costo) VALUES
    (2, 5, '2026-07-28', 'pendiente', 250.00);

-- 2 UPDATE validos
UPDATE ordenes_servicio
SET estado = 'completado'
WHERE id_orden = 4;

UPDATE servicios
SET precio = 275.00
WHERE id_servicio = 5;

-- 2 DELETE controlados con WHERE
DELETE FROM ordenes_servicio
WHERE id_orden = 8;

DELETE FROM ordenes_servicio
WHERE estado = 'en_proceso' AND id_orden = 10;
