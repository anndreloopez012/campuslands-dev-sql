PRAGMA foreign_keys = ON;

-- INSERT ADICIONALES

INSERT INTO eventos (
    id_evento,
    id_lugar,
    nombre,
    fecha,
    categoria,
    estado
) VALUES (
    6,
    1,
    'Conferencia Innovacion Campus',
    '2026-11-05 09:00',
    'Tecnologia',
    'programado'
);

INSERT INTO asistentes (
    id_asistente,
    nombre_completo,
    correo,
    telefono
) VALUES (
    6,
    'Mariana Castillo',
    'mariana.castillo@example.com',
    '55510006'
);

-- UPDATE

UPDATE eventos
SET fecha = '2026-09-13 18:00'
WHERE id_evento = 1;

UPDATE boletos
SET precio = 210.00
WHERE id_boleto = 6;

-- DELETE

DELETE FROM eventos
WHERE id_evento = 6;

DELETE FROM asistentes
WHERE id_asistente = 6;

-- OPERACIONES INVALIDAS

-- CHECK: precio no puede ser menor o igual a cero.
-- INSERT INTO boletos (
--     id_boleto,
--     id_evento,
--     id_asistente,
--     tipo,
--     precio,
--     fecha_compra,
--     estado
-- ) VALUES (
--     11,
--     1,
--     6,
--     'general',
--     0,
--     '2026-08-11 10:00',
--     'activo'
-- );

-- UNIQUE: no se permite registrar el mismo correo dos veces.
-- INSERT INTO asistentes (
--     id_asistente,
--     nombre_completo,
--     correo,
--     telefono
-- ) VALUES (
--     7,
--     'Pedro Castillo',
--     'carlos.velasco@example.com',
--     '55510007'
-- );