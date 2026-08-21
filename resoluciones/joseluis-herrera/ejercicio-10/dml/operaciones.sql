INSERT INTO huespedes (
    id_huesped,
    nombre_completo,
    documento,
    telefono,
    correo
) VALUES (
    6,
    'Daniel Fernandez',
    'HSP1006',
    '55510006',
    'daniel.fernandez@email.com'
);

INSERT INTO reservas (
    id_reserva,
    id_huesped,
    id_habitacion,
    fecha_entrada,
    fecha_salida,
    cantidad_huespedes,
    estado
) VALUES (
    11,
    6,
    1,
    '2026-09-01',
    '2026-09-03',
    1,
    'CONFIRMADA'
);

UPDATE huespedes
SET telefono = '55510999'
WHERE id_huesped = 6;

UPDATE reservas
SET cantidad_huespedes = 2
WHERE id_reserva = 11;

DELETE FROM reservas
WHERE id_reserva = 11;

DELETE FROM huespedes
WHERE id_huesped = 6;

-- Operacion invalida: UNIQUE
-- INSERT INTO huespedes (
--     id_huesped, nombre_completo, documento, telefono, correo
-- ) VALUES (
--     7, 'Huesped Duplicado', 'HSP1001', '55510007', 'duplicado@email.com'
-- );

-- Operacion invalida: CHECK
-- INSERT INTO habitaciones (
--     id_habitacion, numero, tipo, capacidad, precio_noche, estado
-- ) VALUES (
--     6, 401, 'DOBLE', 0, 120.00, 'DISPONIBLE'
-- );