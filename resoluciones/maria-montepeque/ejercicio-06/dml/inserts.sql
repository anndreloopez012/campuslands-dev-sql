-- Ejercicio 06: Torneo Esports
-- Datos base: 5 equipos, 5 jugadores, 6 partidas, 10 resultados

INSERT INTO equipos (nombre) VALUES
    ('Dragones Rojos'),
    ('Lobos Nocturnos'),
    ('Fenix Gaming'),
    ('Tigres Blancos'),
    ('Halcones Negros');

INSERT INTO jugadores (id_equipo, nickname, rol) VALUES
    (1, 'RedDragon', 'igl'),
    (2, 'NightWolf', 'entry'),
    (3, 'PhoenixX', 'sniper'),
    (4, 'WhiteTiger', 'support'),
    (5, 'BlackHawk', 'duelist');

INSERT INTO partidas (equipo_local, equipo_visitante, fecha_partida, mapa) VALUES
    (1, 2, '2026-07-01 18:00', 'Dust'),
    (3, 4, '2026-07-01 20:00', 'Mirage'),
    (5, 1, '2026-07-02 18:00', 'Inferno'),
    (2, 3, '2026-07-02 20:00', 'Nuke'),
    (4, 5, '2026-07-03 18:00', 'Dust'),
    (1, 3, '2026-07-03 20:00', 'Mirage');

INSERT INTO resultados (id_partida, id_jugador, kills, muertes, puntos) VALUES
    (1, 1, 20, 12, 85),
    (1, 2, 15, 18, 60),
    (2, 3, 25, 10, 95),
    (2, 4, 18, 15, 70),
    (3, 5, 22, 14, 88),
    (3, 1, 12, 20, 55),
    (4, 2, 19, 16, 72),
    (4, 3, 21, 13, 80),
    (5, 4, 17, 17, 65),
    (5, 5, 24, 11, 92);
