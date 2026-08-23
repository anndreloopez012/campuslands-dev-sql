PRAGMA foreign_keys = ON;

-- Ejercicio 053: Torneo Esports
-- Datos de prueba.

INSERT INTO equipos (nombre_equipo, region) VALUES
    ('Quetzal Esports', 'LATAM'),
    ('Kraken Digital', 'NA'),
    ('Aurora Gaming', 'EU'),
    ('Jade Command', 'APAC'),
    ('Titan Frontier', 'LATAM'),
    ('Nova Syndicate', 'NA');

-- Todos los jugadores pertenecen a Quetzal Esports (id_equipo = 1);
-- los demas equipos son los rivales que aparecen en partidas.
INSERT INTO jugadores (nombre_jugador, id_equipo, rol) VALUES
    ('ZeroPixel', 1, 'titular'),
    ('LunaStrike', 1, 'titular'),
    ('KaijuByte', 1, 'suplente'),
    ('NyxRunner', 1, 'capitan'),
    ('EchoWave', 1, 'titular');

-- La partida 10 es un duplicado por error de digitacion (mismo
-- rival, fecha, resultado y estado que la partida 1): se corrige en
-- dml/operaciones.sql. La partida 8 se pospuso antes de generar
-- ninguna estadistica: se borrara de forma controlada.
INSERT INTO partidas (id_equipo_rival, fecha_partida, resultado, estado) VALUES
    (2, '2026-08-01', 'victoria', 'jugada'),
    (3, '2026-08-03', 'derrota', 'jugada'),
    (4, '2026-08-05', 'victoria', 'jugada'),
    (2, '2026-08-07', 'victoria', 'jugada'),
    (5, '2026-08-09', 'derrota', 'jugada'),
    (6, '2026-08-11', 'victoria', 'jugada'),
    (3, '2026-08-13', 'victoria', 'programada'),
    (4, '2026-08-15', 'derrota', 'pospuesta'),
    (2, '2026-08-17', 'victoria', 'programada'),
    (2, '2026-08-01', 'victoria', 'jugada');

INSERT INTO estadisticas (id_jugador, id_partida, puntos, asistencias) VALUES
    (1, 1, 15, 3),
    (2, 1, 12, 5),
    (4, 1, 10, 8),
    (1, 2, 8, 2),
    (3, 2, 6, 4),
    (2, 3, 18, 6),
    (4, 3, 14, 7),
    (5, 3, 9, 3),
    (1, 4, 20, 4),
    (2, 4, 11, 5),
    (3, 5, 7, 2),
    (4, 5, 13, 6),
    (1, 6, 16, 5),
    (5, 6, 19, 4);

-- Casos comentados que deben fallar (no ser recomendables), dejar
-- comentados:

-- 1) Registro repetido: nombre_equipo ya existe, viola el UNIQUE.
-- INSERT INTO equipos (nombre_equipo, region) VALUES ('Kraken Digital', 'NA');

-- 2) Valor fuera de rango: puntos negativo, viola el CHECK.
-- INSERT INTO estadisticas (id_jugador, id_partida, puntos, asistencias) VALUES (3, 6, -5, 1);
