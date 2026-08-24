PRAGMA foreign_keys = ON;

-- Ejercicio 072: Liga MOBA
-- Datos base: 3 equipos, 15 jugadores (5 por equipo, un rol de cada
-- tipo), 10 heroes, 3 partidas (2 jugadas, 1 programada) y 20 filas
-- de estadisticas (10 por cada partida jugada).

INSERT INTO equipos (nombre_equipo, region) VALUES
    ('Dragones Electricos', 'Norte'),
    ('Fenix Cibernetico', 'Sur'),
    ('Lobos de Neon', 'Centro');

INSERT INTO jugadores (nickname, id_equipo, rol) VALUES
    ('VoltStrike', 1, 'top'),
    ('JungleFox', 1, 'jungla'),
    ('MidGlitch', 1, 'medio'),
    ('SniperByte', 1, 'tirador'),
    ('GuardianPix', 1, 'soporte'),
    ('IronClad', 2, 'top'),
    ('ShadowLynx', 2, 'jungla'),
    ('PulseWave', 2, 'medio'),
    ('RapidFire', 2, 'tirador'),
    ('AegisCore', 2, 'soporte'),
    ('NeonFang', 3, 'top'),
    ('MoonHowl', 3, 'jungla'),
    ('GlitchMind', 3, 'medio'),
    ('StormArrow', 3, 'tirador'),
    ('WardenLuna', 3, 'soporte');

INSERT INTO heroes (nombre_heroe, rol_principal) VALUES
    ('Draven', 'tirador'),
    ('Lux', 'medio'),
    ('Yasuo', 'medio'),
    ('Thresh', 'soporte'),
    ('LeeSin', 'jungla'),
    ('Jinx', 'tirador'),
    ('Zed', 'medio'),
    ('Braum', 'soporte'),
    ('Ahri', 'medio'),
    ('Vayne', 'tirador');

-- Partida 1: Dragones Electricos (local) vs Fenix Cibernetico
-- (visitante), ya jugada. El ganador se confirma despues con UPDATE
-- en dml/operaciones.sql (id_equipo_ganador empieza en NULL).
INSERT INTO partidas (id_equipo_local, id_equipo_visitante, fecha_partida, estado) VALUES
    (1, 2, '2026-08-01', 'jugada');

-- Partida 2: Fenix Cibernetico (local) vs Lobos de Neon (visitante),
-- ya jugada. Mismo caso: ganador pendiente de confirmar.
INSERT INTO partidas (id_equipo_local, id_equipo_visitante, fecha_partida, estado) VALUES
    (2, 3, '2026-08-03', 'jugada');

-- Partida 3: Dragones Electricos vs Lobos de Neon, todavia no se
-- juega.
INSERT INTO partidas (id_equipo_local, id_equipo_visitante, fecha_partida, estado) VALUES
    (1, 3, '2026-08-08', 'programada');

-- Estadisticas de la partida 1 (10 jugadores, 10 heroes distintos).
INSERT INTO estadisticas (id_partida, id_jugador, id_heroe, kills, muertes, asistencias, oro_conseguido) VALUES
    (1, 1, 1, 4, 2, 5, 12500),
    (1, 2, 5, 3, 1, 8, 11800),
    (1, 3, 7, 6, 2, 4, 13200),
    (1, 4, 6, 5, 3, 6, 12900),
    (1, 5, 8, 0, 1, 10, 9800),
    (1, 6, 3, 2, 4, 3, 9500),
    (1, 7, 9, 1, 3, 5, 9200),
    (1, 8, 2, 3, 3, 4, 10100),
    (1, 9, 10, 4, 2, 3, 11200),
    (1, 10, 4, 0, 2, 9, 8700);

-- Estadisticas de la partida 2 (10 jugadores, heroes reutilizados en
-- otra partida distinta: eso si esta permitido).
INSERT INTO estadisticas (id_partida, id_jugador, id_heroe, kills, muertes, asistencias, oro_conseguido) VALUES
    (2, 6, 1, 3, 3, 4, 10800),
    (2, 7, 5, 2, 2, 6, 10200),
    (2, 8, 7, 4, 3, 3, 11500),
    (2, 9, 6, 5, 4, 2, 12100),
    (2, 10, 8, 0, 3, 8, 8900),
    (2, 11, 3, 5, 2, 4, 13400),
    (2, 12, 9, 4, 1, 7, 12800),
    (2, 13, 2, 6, 2, 5, 14100),
    (2, 14, 10, 7, 3, 3, 14900),
    (2, 15, 4, 1, 1, 12, 10200);

-- Estadistica cargada por error para la partida 3, que todavia esta
-- 'programada' (no se ha jugado). Alguien la registro pensando que ya
-- habia terminado; se corrige en dml/operaciones.sql cuando se
-- descubre el error y la partida se cancela.
INSERT INTO estadisticas (id_partida, id_jugador, id_heroe, kills, muertes, asistencias, oro_conseguido) VALUES
    (3, 1, 7, 2, 1, 3, 9000);

-- Caso comentado que debe fallar (queda comentado): cargar de nuevo a
-- NeonFang en la partida 2, exactamente el problema que este UNIQUE
-- esta disenado para evitar.
-- INSERT INTO estadisticas (id_partida, id_jugador, id_heroe, kills, muertes, asistencias, oro_conseguido) VALUES (2, 11, 2, 5, 2, 4, 13400);
