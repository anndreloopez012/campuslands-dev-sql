PRAGMA foreign_keys = ON;

-- =========================================================
-- 1. INSERT adicional
-- =========================================================

INSERT INTO equipos (
    id_equipo,
    nombre,
    region,
    fecha_fundacion
) VALUES (
    6,
    'Iron Falcons',
    'LATAM',
    '2024-03-12'
);

-- =========================================================
-- 2. INSERT adicional
-- =========================================================

INSERT INTO jugadores (
    id_jugador,
    nickname,
    nombre_completo,
    rol,
    id_equipo
) VALUES (
    11,
    'Falcon',
    'Mateo Ruiz',
    'TOP',
    6
);

-- =========================================================
-- 3. UPDATE válido
-- =========================================================

UPDATE equipos
SET region = 'Centroamerica'
WHERE id_equipo = 6;

-- =========================================================
-- 4. UPDATE válido
-- =========================================================

UPDATE jugadores
SET rol = 'JUNGLA'
WHERE id_jugador = 11;

-- =========================================================
-- 5. DELETE controlado
-- =========================================================

DELETE FROM jugadores
WHERE id_jugador = 11;

-- =========================================================
-- 6. DELETE controlado
-- =========================================================

DELETE FROM equipos
WHERE id_equipo = 6;

-- =========================================================
-- OPERACIONES QUE DEBEN FALLAR
-- Se mantienen comentadas.
-- =========================================================

-- CHECK: los equipos local y visitante deben ser diferentes.
-- INSERT INTO partidas (
--     id_partida,
--     id_equipo_local,
--     id_equipo_visitante,
--     fecha_partida,
--     fase
-- ) VALUES (
--     11,
--     1,
--     1,
--     '2026-08-01 15:00:00',
--     'GRUPOS'
-- );

-- UNIQUE: el nickname NovaX ya existe.
-- INSERT INTO jugadores (
--     id_jugador,
--     nickname,
--     nombre_completo,
--     rol,
--     id_equipo
-- ) VALUES (
--     12,
--     'NovaX',
--     'Jugador Duplicado',
--     'MID',
--     1
-- );

-- FOREIGN KEY: el equipo 999 no existe.
-- INSERT INTO jugadores (
--     id_jugador,
--     nickname,
--     nombre_completo,
--     rol,
--     id_equipo
-- ) VALUES (
--     13,
--     'InvalidPlayer',
--     'Jugador Invalido',
--     'MID',
--     999
-- );