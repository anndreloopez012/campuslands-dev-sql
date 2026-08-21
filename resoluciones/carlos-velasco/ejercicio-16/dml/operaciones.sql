PRAGMA foreign_keys = ON;

-- INSERTS ADICIONALES

INSERT INTO reservas (
    id_reserva,
    vuelo_id,
    nombre_pasajero,
    documento,
    asiento,
    fecha_reserva,
    estado
) VALUES
(15, 2, 'Ricardo Alvarez', 'DOC1015', '08D', '2026-08-18', 'CONFIRMADA'),
(16, 6, 'Elena Vargas', 'DOC1016', '14A', '2026-08-19', 'PENDIENTE');

-- UPDATES

UPDATE reservas
SET asiento = '13A',
    estado = 'CONFIRMADA'
WHERE id_reserva = 5;

UPDATE vuelos
SET estado = 'ABORDANDO'
WHERE id_vuelo = 3;

-- DELETES

DELETE FROM reservas
WHERE id_reserva = 15;

DELETE FROM reservas
WHERE id_reserva = 16;

-- OPERACIONES INVALIDAS

-- CHECK
-- INSERT INTO aviones (matricula, modelo, capacidad, estado)
-- VALUES ('N606CA', 'Airbus A330', 0, 'ACTIVO');

-- FOREIGN KEY
-- INSERT INTO reservas (
--     vuelo_id,
--     nombre_pasajero,
--     documento,
--     asiento,
--     fecha_reserva,
--     estado
-- ) VALUES (
--     999,
--     'Pasajero Invalido',
--     'DOC9999',
--     '01A',
--     '2026-08-20',
--     'CONFIRMADA'
-- );