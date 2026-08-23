-- Ejercicio 36: Normalizacion Hotel Reservas
-- Datos normalizados equivalentes a datos/datos-sin-normalizar.csv
-- (huespedes 1-2, habitaciones 1-2, servicios 1-4 y las reservas 1-3 con su
--  detalle vienen del CSV original; el resto se agrega para cumplir el
--  minimo de datos del ejercicio)
--
-- Nota sobre el CSV original: las filas id_reserva=1 e id_reserva=3 tienen
-- la misma huesped (Elena Soto) y la misma habitacion (Habitacion 204), pero
-- los servicios se consumieron en fechas distintas (2026-07-01/02 vs
-- 2026-07-05/06): son dos estadias reales, no una fila duplicada, asi que se
-- mantienen como dos reservas separadas.

INSERT INTO huespedes (nombre, documento) VALUES
    ('Elena Soto', 'PAS-1'),
    ('Pedro Mora', 'PAS-2'),
    ('Rosa Vega', 'PAS-3'),
    ('Hugo Ical', 'PAS-4'),
    ('Vivian Cux', 'PAS-5');

INSERT INTO habitaciones (numero) VALUES
    ('Habitacion 204'),
    ('Habitacion 105'),
    ('Habitacion 301'),
    ('Habitacion 102'),
    ('Habitacion 210');

INSERT INTO servicios (nombre, costo) VALUES
    ('Desayuno', 60.00),
    ('Spa', 180.00),
    ('Parqueo', 45.00),
    ('Lavanderia', 70.00),
    ('Minibar', 35.00);

INSERT INTO reservas (id_huesped, id_habitacion) VALUES
    (1, 1),   -- reserva 1 del CSV: Elena Soto, Habitacion 204
    (2, 2),   -- reserva 2 del CSV: Pedro Mora, Habitacion 105
    (1, 1),   -- reserva 3 del CSV: Elena Soto, Habitacion 204 (otra estadia)
    (3, 3),   -- reserva adicional
    (4, 4),   -- reserva adicional
    (5, 5);   -- reserva adicional

INSERT INTO detalle_servicio (id_reserva, id_servicio, fecha, costo) VALUES
    -- reserva 1 (CSV): Desayuno|Spa, 60|180, 2026-07-01|2026-07-02
    (1, 1, '2026-07-01', 60.00),
    (1, 2, '2026-07-02', 180.00),
    -- reserva 2 (CSV): Parqueo|Lavanderia, 45|70, 2026-07-03|2026-07-04
    (2, 3, '2026-07-03', 45.00),
    (2, 4, '2026-07-04', 70.00),
    -- reserva 3 (CSV): Desayuno|Parqueo, 60|45, 2026-07-05|2026-07-06
    (3, 1, '2026-07-05', 60.00),
    (3, 3, '2026-07-06', 45.00),
    -- reservas adicionales para completar el minimo de 10 lineas de detalle
    (4, 2, '2026-07-07', 180.00),
    (4, 5, '2026-07-08', 35.00),
    (5, 1, '2026-07-09', 60.00),
    (5, 4, '2026-07-10', 70.00),
    (6, 3, '2026-07-11', 45.00),
    (6, 2, '2026-07-12', 180.00);

-- 2 casos comentados que deben fallar por restricciones
-- Falla por UNIQUE (huespedes.documento): el documento ya existe
-- INSERT INTO huespedes (nombre, documento) VALUES ('Duplicado', 'PAS-1');

-- Falla por CHECK (costo > 0)
-- INSERT INTO detalle_servicio (id_reserva, id_servicio, fecha, costo) VALUES (1, 3, '2026-07-15', -10.00);
