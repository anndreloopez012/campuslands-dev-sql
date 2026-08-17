-- Ejercicio 01: CineMax SQLite
-- Operaciones sobre los datos base

-- 2 INSERT adicionales
INSERT INTO peliculas (titulo, genero, duracion_min, clasificacion) VALUES
    ('Mundo perdido', 'Aventura', 120, 'B');

INSERT INTO boletos (id_funcion, asiento, precio_pagado, estado, fecha_compra) VALUES
    (3, 'C2', 32.50, 'reservado', '2026-08-09');

-- 2 UPDATE validos
UPDATE boletos
SET estado = 'pagado'
WHERE id_boleto = 9;

UPDATE funciones
SET precio_base = 37.50
WHERE id_funcion = 1;

-- 2 DELETE controlados con WHERE
DELETE FROM boletos
WHERE estado = 'cancelado';

DELETE FROM boletos
WHERE id_boleto = 4;

