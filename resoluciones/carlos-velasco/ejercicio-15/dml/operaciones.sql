PRAGMA foreign_keys = ON;

-- INSERTS ADICIONALES

INSERT INTO clientes (
    id_cliente,
    nombre_completo,
    telefono,
    correo,
    fecha_registro
) VALUES (
    6,
    'Mariana Lopez',
    '55510006',
    'mariana.lopez@email.com',
    '2026-04-02'
);

INSERT INTO motos (
    id_moto,
    id_cliente,
    placa,
    marca,
    modelo,
    anio,
    kilometraje
) VALUES (
    11,
    6,
    'MOT011',
    'Yamaha',
    'XSR155',
    2024,
    6200
);

-- UPDATES

UPDATE ordenes_servicio
SET estado = 'Completado',
    observaciones = 'Servicio finalizado y entregado al cliente'
WHERE id_orden = 9;

UPDATE motos
SET kilometraje = 19500
WHERE id_moto = 1;

-- DELETES

DELETE FROM ordenes_servicio
WHERE id_orden = 10;

DELETE FROM motos
WHERE id_moto = 11;

-- OPERACIONES INVALIDAS

-- CHECK: kilometraje no puede ser negativo
-- INSERT INTO motos (
--     id_moto,
--     id_cliente,
--     placa,
--     marca,
--     modelo,
--     anio,
--     kilometraje
-- ) VALUES (
--     11,
--     6,
--     'MOT011',
--     'Yamaha',
--     'XSR155',
--     2024,
--     -500
-- );

-- UNIQUE: el correo del cliente debe ser unico
-- INSERT INTO clientes (
--     id_cliente,
--     nombre_completo,
--     telefono,
--     correo,
--     fecha_registro
-- ) VALUES (
--     7,
--     'Cliente Duplicado',
--     '55510007',
--     'carlos.mendoza@email.com',
--     '2026-04-05'
-- );