INSERT INTO asistentes (
    id_asistente,
    nombre_completo,
    documento,
    correo,
    telefono
) VALUES (
    6,
    'Maria Hernandez',
    '30030006',
    'maria.hernandez@email.com',
    '55510006'
);

INSERT INTO boletos (
    id_boleto,
    id_evento,
    id_asistente,
    codigo,
    fecha_compra,
    precio_pagado,
    estado
) VALUES (
    11,
    1,
    6,
    'BOL-0011',
    '2026-08-11 09:00',
    250.00,
    'ACTIVO'
);

UPDATE asistentes
SET telefono = '55519999'
WHERE id_asistente = 6;

UPDATE boletos
SET estado = 'USADO'
WHERE id_boleto = 11;

DELETE FROM boletos
WHERE id_boleto = 11;

DELETE FROM asistentes
WHERE id_asistente = 6;

-- INSERT INTO lugares (
--     id_lugar,
--     nombre,
--     direccion,
--     capacidad,
--     ciudad
-- ) VALUES (
--     6,
--     'Centro de Convenciones Aurora',
--     'Nueva Direccion 100',
--     1000,
--     'Guatemala'
-- );

-- INSERT INTO boletos (
--     id_boleto,
--     id_evento,
--     id_asistente,
--     codigo,
--     fecha_compra,
--     precio_pagado,
--     estado
-- ) VALUES (
--     12,
--     999,
--     1,
--     'BOL-0012',
--     '2026-08-12 10:00',
--     100.00,
--     'ACTIVO'
-- );