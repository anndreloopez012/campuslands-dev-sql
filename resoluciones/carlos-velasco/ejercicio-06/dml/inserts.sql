PRAGMA foreign_keys = ON;

-- =========================================================
-- EQUIPOS
-- =========================================================

INSERT INTO equipos (
    id_equipo,
    nombre,
    region,
    fecha_fundacion
) VALUES
    (1, 'Nova Gaming', 'LATAM', '2022-02-15'),
    (2, 'Titan Esports', 'LATAM', '2021-06-20'),
    (3, 'Phoenix Squad', 'Norteamerica', '2023-01-10'),
    (4, 'Shadow Wolves', 'Europa', '2020-09-05'),
    (5, 'Cyber Dragons', 'Asia', '2022-11-18');

-- =========================================================
-- JUGADORES
-- =========================================================

INSERT INTO jugadores (
    id_jugador,
    nickname,
    nombre_completo,
    rol,
    id_equipo
) VALUES
    (1, 'NovaX', 'Carlos Mendoza', 'MID', 1),
    (2, 'Blaze', 'Andres Castillo', 'ADC', 1),

    (3, 'TitanZ', 'Miguel Herrera', 'TOP', 2),
    (4, 'Raptor', 'Diego Ramirez', 'JUNGLA', 2),

    (5, 'Phoenix', 'Daniel Torres', 'MID', 3),
    (6, 'Arrow', 'Luis Morales', 'ADC', 3),

    (7, 'Shadow', 'Erik Schneider', 'TOP', 4),
    (8, 'Wolf', 'Leon Weber', 'SOPORTE', 4),

    (9, 'Dragon', 'Kenji Tanaka', 'MID', 5),
    (10, 'Storm', 'Hiro Sato', 'ADC', 5);

-- =========================================================
-- PARTIDAS
-- =========================================================

INSERT INTO partidas (
    id_partida,
    id_equipo_local,
    id_equipo_visitante,
    fecha_partida,
    fase
) VALUES
    (1, 1, 2, '2026-07-01 15:00:00', 'GRUPOS'),
    (2, 3, 4, '2026-07-02 16:00:00', 'GRUPOS'),
    (3, 5, 1, '2026-07-03 17:00:00', 'GRUPOS'),
    (4, 2, 3, '2026-07-04 15:30:00', 'GRUPOS'),
    (5, 4, 5, '2026-07-05 18:00:00', 'GRUPOS'),
    (6, 1, 3, '2026-07-10 16:00:00', 'CUARTOS'),
    (7, 2, 5, '2026-07-11 17:00:00', 'CUARTOS'),
    (8, 3, 5, '2026-07-15 18:00:00', 'SEMIFINAL'),
    (9, 1, 4, '2026-07-16 19:00:00', 'SEMIFINAL'),
    (10, 3, 1, '2026-07-20 20:00:00', 'FINAL');

-- =========================================================
-- RESULTADOS
-- =========================================================

INSERT INTO resultados (
    id_resultado,
    id_partida,
    ganador_id_equipo,
    puntos_local,
    puntos_visitante,
    duracion_minutos
) VALUES
    (1, 1, 1, 18, 12, 32),
    (2, 2, 4, 10, 17, 29),
    (3, 3, 5, 20, 14, 35),
    (4, 4, 2, 16, 11, 31),
    (5, 5, 5, 13, 19, 34),
    (6, 6, 3, 9, 15, 28),
    (7, 7, 5, 11, 18, 36),
    (8, 8, 3, 21, 16, 38),
    (9, 9, 1, 17, 12, 30),
    (10, 10, 3, 14, 20, 41);