INSERT INTO equipos (
    id_equipo,
    nombre,
    ciudad,
    fecha_creacion,
    estado
) VALUES (
    6,
    'Centellas Gaming',
    'Mixco',
    '2026-01-15',
    'ACTIVO'
);

INSERT INTO jugadores (
    id_jugador,
    id_equipo,
    nombre_completo,
    nickname,
    edad
) VALUES (
    6,
    6,
    'Jorge Herrera',
    'CentellaX',
    21
);

UPDATE equipos
SET ciudad = 'Mixco'
WHERE id_equipo = 1;

UPDATE jugadores
SET edad = 22
WHERE id_jugador = 1;

DELETE FROM jugadores
WHERE id_jugador = 6;

DELETE FROM equipos
WHERE id_equipo = 6;

-- Operacion invalida: UNIQUE
-- INSERT INTO equipos (id_equipo, nombre, ciudad, fecha_creacion, estado)
-- VALUES (7, 'Titanes Gaming', 'Guatemala', '2026-08-01', 'ACTIVO');

-- Operacion invalida: CHECK
-- INSERT INTO partidas (id_partida, id_equipo_1, id_equipo_2, fecha_partida, ronda, estado)
-- VALUES (11, 1, 1, '2026-08-01 18:00', 'FINAL', 'PROGRAMADA');