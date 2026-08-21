PRAGMA foreign_keys = ON;

-- INSERTS ADICIONALES

INSERT INTO conductores (
    id_conductor,
    nombre_completo,
    documento,
    licencia,
    telefono,
    estado
) VALUES
(6, 'Miguel Torres Sanchez', 'CON-1006', 'LIC-2006', '5551-1006', 'Activo');

INSERT INTO viajes (
    id_viaje,
    id_ruta,
    id_bus,
    id_conductor,
    fecha_hora,
    pasajeros_registrados,
    estado
) VALUES
(11, 1, 1, 6, '2026-08-23 07:00', 22, 'Programado');

-- UPDATES

UPDATE buses
SET estado = 'Mantenimiento'
WHERE id_bus = 5;

UPDATE viajes
SET pasajeros_registrados = 40
WHERE id_viaje = 2;

-- DELETES

DELETE FROM viajes
WHERE id_viaje = 11;

DELETE FROM conductores
WHERE id_conductor = 6;

-- OPERACIONES INVALIDAS

-- UNIQUE: placa duplicada
-- INSERT INTO buses (
--     id_bus,
--     placa,
--     modelo,
--     capacidad,
--     anio,
--     estado
-- ) VALUES (
--     6,
--     'BUS-1001',
--     'Modelo Duplicado',
--     30,
--     2024,
--     'Disponible'
-- );

-- FOREIGN KEY: ruta inexistente
-- INSERT INTO viajes (
--     id_viaje,
--     id_ruta,
--     id_bus,
--     id_conductor,
--     fecha_hora,
--     pasajeros_registrados,
--     estado
-- ) VALUES (
--     12,
--     99,
--     1,
--     1,
--     '2026-08-23 08:00',
--     20,
--     'Programado'
-- );