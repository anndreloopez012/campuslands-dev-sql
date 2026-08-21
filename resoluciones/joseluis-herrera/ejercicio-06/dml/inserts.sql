INSERT INTO equipos (
    id_equipo,
    nombre,
    ciudad,
    fecha_creacion,
    estado
) VALUES
    (1, 'Titanes Gaming', 'Ciudad de Guatemala', '2025-01-10', 'ACTIVO'),
    (2, 'Dragones Elite', 'Quetzaltenango', '2025-02-15', 'ACTIVO'),
    (3, 'Halcones Pro', 'Escuintla', '2025-03-20', 'ACTIVO'),
    (4, 'Lobos Digital', 'Antigua Guatemala', '2025-04-05', 'ACTIVO'),
    (5, 'Fenix Squad', 'Guatemala', '2025-05-12', 'ACTIVO');

INSERT INTO jugadores (
    id_jugador,
    id_equipo,
    nombre_completo,
    nickname,
    edad
) VALUES
    (1, 1, 'Carlos Mendoza', 'CarlosM', 21),
    (2, 2, 'Diego Ramirez', 'DragonX', 23),
    (3, 3, 'Luis Castillo', 'HawkPro', 20),
    (4, 4, 'Miguel Torres', 'WolfKing', 24),
    (5, 5, 'Andres Lopez', 'FenixAce', 22);

INSERT INTO partidas (
    id_partida,
    id_equipo_1,
    id_equipo_2,
    fecha_partida,
    ronda,
    estado
) VALUES
    (1, 1, 2, '2026-07-01 18:00', 'CUARTOS', 'FINALIZADA'),
    (2, 3, 4, '2026-07-01 20:00', 'CUARTOS', 'FINALIZADA'),
    (3, 5, 1, '2026-07-02 18:00', 'CUARTOS', 'FINALIZADA'),
    (4, 2, 3, '2026-07-02 20:00', 'CUARTOS', 'FINALIZADA'),
    (5, 4, 5, '2026-07-03 18:00', 'SEMIFINAL', 'FINALIZADA'),
    (6, 1, 3, '2026-07-03 20:00', 'SEMIFINAL', 'FINALIZADA'),
    (7, 2, 5, '2026-07-04 18:00', 'SEMIFINAL', 'FINALIZADA'),
    (8, 3, 5, '2026-07-05 20:00', 'FINAL', 'FINALIZADA'),
    (9, 1, 4, '2026-07-06 18:00', 'TERCER_PUESTO', 'FINALIZADA'),
    (10, 5, 1, '2026-07-06 20:00', 'FINAL', 'FINALIZADA');

INSERT INTO resultados (
    id_resultado,
    id_partida,
    puntos_equipo_1,
    puntos_equipo_2,
    ganador
) VALUES
    (1, 1, 16, 12, 'EQUIPO_1'),
    (2, 2, 10, 16, 'EQUIPO_2'),
    (3, 3, 8, 16, 'EQUIPO_2'),
    (4, 4, 18, 14, 'EQUIPO_1'),
    (5, 5, 20, 15, 'EQUIPO_1'),
    (6, 6, 11, 17, 'EQUIPO_2'),
    (7, 7, 13, 16, 'EQUIPO_2'),
    (8, 8, 21, 18, 'EQUIPO_1'),
    (9, 9, 14, 17, 'EQUIPO_2'),
    (10, 10, 19, 16, 'EQUIPO_1');