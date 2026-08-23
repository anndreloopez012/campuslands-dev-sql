PRAGMA foreign_keys = ON;

-- INSERTS ADICIONALES

INSERT INTO huespedes (
    id_huesped,
    nombre_completo,
    documento,
    telefono,
    correo,
    fecha_registro
) VALUES
(6, 'Miguel Torres Sanchez', 'HSP-1006', '5551-1006', 'miguel.torres@email.com', '2026-08-20');

INSERT INTO reservas (
    id_reserva,
    id_huesped,
    id_habitacion,
    fecha_entrada,
    fecha_salida,
    cantidad_huespedes,
    estado
) VALUES
(11, 6, 1, '2026-08-26', '2026-08-28', 1, 'Confirmada');

-- UPDATES

UPDATE huespedes
SET telefono = '5551-9001'
WHERE id_huesped = 1;

UPDATE reservas
SET estado = 'Confirmada'
WHERE id_reserva = 10;

-- DELETES

DELETE FROM reservas
WHERE id_reserva = 11;

DELETE FROM huespedes
WHERE id_huesped = 6;

-- OPERACIONES INVALIDAS

-- UNIQUE: documento duplicado
-- INSERT INTO huespedes (
--     id_huesped,
--     nombre_completo,
--     documento,
--     telefono,
--     correo,
--     fecha_registro
-- ) VALUES (
--     7,
--     'Huesped Documento Duplicado',
--     'HSP-1001',
--     '5551-1007',
--     'duplicado@email.com',
--     '2026-08-20'
-- );

-- FOREIGN KEY: habitacion inexistente
-- INSERT INTO reservas (
--     id_reserva,
--     id_huesped,
--     id_habitacion,
--     fecha_entrada,
--     fecha_salida,
--     cantidad_huespedes,
--     estado
-- ) VALUES (
--     12,
--     1,
--     99,
--     '2026-08-26',
--     '2026-08-28',
--     1,
--     'Confirmada'
-- );