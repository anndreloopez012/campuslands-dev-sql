PRAGMA foreign_keys = ON;

-- TRANSACCION DE RESERVA Y PAGO

BEGIN TRANSACTION;

INSERT INTO usuarios (
    id_usuario,
    nombre_completo,
    correo,
    telefono
) VALUES (
    6,
    'Miguel Castillo',
    'miguel.castillo@example.com',
    '555-0106'
);

INSERT INTO reservas (
    id_reserva,
    id_usuario,
    id_recurso,
    fecha_inicio,
    fecha_fin,
    estado,
    total
) VALUES (
    11,
    6,
    1,
    '2026-08-11 09:00',
    '2026-08-11 12:00',
    'Confirmada',
    240.00
);

INSERT INTO pagos (
    id_pago,
    id_reserva,
    monto,
    fecha_pago,
    metodo_pago,
    estado
) VALUES (
    11,
    11,
    240.00,
    '2026-08-11',
    'Tarjeta',
    'Confirmado'
);

COMMIT;

-- UPDATES

UPDATE reservas
SET estado = 'Finalizada'
WHERE id_reserva = 11;

UPDATE recursos
SET precio_hora = 85.00
WHERE id_recurso = 1;

-- TRANSACCION CON ROLLBACK

BEGIN TRANSACTION;

UPDATE reservas
SET estado = 'Cancelada'
WHERE id_reserva = 11;

UPDATE pagos
SET estado = 'Rechazado'
WHERE id_pago = 11;

ROLLBACK;

-- DELETES CONTROLADOS

DELETE FROM pagos
WHERE id_pago = 11;

DELETE FROM reservas
WHERE id_reserva = 11;

DELETE FROM usuarios
WHERE id_usuario = 6;

-- OPERACION INVALIDA: UNIQUE

-- INSERT INTO usuarios (
--     id_usuario,
--     nombre_completo,
--     correo,
--     telefono
-- ) VALUES (
--     7,
--     'Usuario Duplicado',
--     'ana.martinez@example.com',
--     '555-0190'
-- );

-- OPERACION INVALIDA: CHECK

-- INSERT INTO recursos (
--     id_recurso,
--     nombre,
--     tipo,
--     capacidad,
--     precio_hora,
--     estado
-- ) VALUES (
--     7,
--     'Recurso Invalido',
--     'Sala',
--     10,
--     -50.00,
--     'Disponible'
-- );