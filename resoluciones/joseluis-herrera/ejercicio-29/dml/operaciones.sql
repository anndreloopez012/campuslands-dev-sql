BEGIN TRANSACTION;

INSERT INTO usuarios (
    id_usuario,
    nombre_completo,
    email,
    telefono,
    fecha_registro
) VALUES (
    6,
    'Sofia Morales',
    'sofia.morales@email.com',
    '55510006',
    '2026-02-01'
);

INSERT INTO reservas (
    id_reserva,
    id_usuario,
    id_recurso,
    fecha_reserva,
    hora_inicio,
    hora_fin,
    cantidad_horas,
    total,
    estado
) VALUES (
    11,
    6,
    1,
    '2026-09-11',
    '08:00',
    '11:00',
    3,
    240.00,
    'confirmada'
);

UPDATE reservas
SET estado = 'finalizada'
WHERE id_reserva = 4;

UPDATE recursos
SET precio_hora = 90.00
WHERE id_recurso = 1;

DELETE FROM reservas
WHERE id_reserva = 11;

DELETE FROM usuarios
WHERE id_usuario = 6;

COMMIT;

BEGIN TRANSACTION;

INSERT INTO reservas (
    id_reserva,
    id_usuario,
    id_recurso,
    fecha_reserva,
    hora_inicio,
    hora_fin,
    cantidad_horas,
    total,
    estado
) VALUES (
    12,
    1,
    1,
    '2026-09-12',
    '08:00',
    '10:00',
    2,
    180.00,
    'confirmada'
);

UPDATE reservas
SET total = 180.00
WHERE id_reserva = 12;

COMMIT;

-- INSERT que falla por UNIQUE
-- INSERT INTO usuarios (
--     id_usuario,
--     nombre_completo,
--     email,
--     telefono,
--     fecha_registro
-- ) VALUES (
--     7,
--     'Usuario Duplicado',
--     'jose.perez@email.com',
--     '55510007',
--     '2026-02-05'
-- );

-- INSERT que falla por CHECK
-- INSERT INTO reservas (
--     id_reserva,
--     id_usuario,
--     id_recurso,
--     fecha_reserva,
--     hora_inicio,
--     hora_fin,
--     cantidad_horas,
--     total,
--     estado
-- ) VALUES (
--     13,
--     1,
--     1,
--     '2026-09-13',
--     '08:00',
--     '10:00',
--     0,
--     0,
--     'confirmada'
-- );