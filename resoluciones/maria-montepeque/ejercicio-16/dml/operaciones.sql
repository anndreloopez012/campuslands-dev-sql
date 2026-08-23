-- Ejercicio 16: Aerolinea Vuelos
-- Operaciones sobre los datos base

-- 2 INSERT adicionales
INSERT INTO aeropuertos (codigo, nombre, ciudad) VALUES
    ('LIM', 'Jorge Chavez', 'Lima');

INSERT INTO reservas (id_vuelo, pasajero, asiento, precio_pagado, estado) VALUES
    (3, 'Douglas Pineda', '3C', 350.00, 'pendiente');

-- 2 UPDATE validos
UPDATE reservas
SET estado = 'confirmada'
WHERE id_reserva = 4;

UPDATE vuelos
SET precio_base = 260.00
WHERE id_vuelo = 1;

-- 2 DELETE controlados con WHERE
DELETE FROM reservas
WHERE id_reserva = 6;

DELETE FROM reservas
WHERE estado = 'pendiente' AND id_reserva = 8;
