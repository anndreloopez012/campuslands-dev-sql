-- Ejercicio 11: Transporte Rutas
-- Operaciones sobre los datos base

-- 2 INSERT adicionales
INSERT INTO conductores (nombre, licencia) VALUES
    ('Marvin Us', 'LIC-2006');

INSERT INTO viajes (id_ruta, id_bus, id_conductor, fecha_hora, pasajeros, estado) VALUES
    (2, 5, 6, '2026-08-07 07:00', 25, 'programado');

-- 2 UPDATE validos
UPDATE viajes
SET estado = 'finalizado'
WHERE id_viaje = 3;

UPDATE buses
SET capacidad = 42
WHERE id_bus = 3;

-- 2 DELETE controlados con WHERE
DELETE FROM viajes
WHERE estado = 'cancelado';

DELETE FROM viajes
WHERE id_viaje = 11;
