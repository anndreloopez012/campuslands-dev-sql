PRAGMA foreign_keys = ON;

-- Ejercicio 023: Clanes Shooter
-- Datos de prueba.

INSERT INTO clanes (nombre_clan, region) VALUES
    ('Lobos Nocturnos', 'LATAM'),
    ('Fenix Squad', 'NA'),
    ('Serpientes Negras', 'EU'),
    ('Aguilas de Fuego', 'LATAM'),
    ('Titanes del Norte', 'ASIA');

INSERT INTO jugadores (id_clan, gamertag, rol) VALUES
    (1, 'NightWolf', 'igl'),
    (1, 'SilentBlade', 'sniper'),
    (2, 'PhoenixRise', 'entry'),
    (3, 'VenomStrike', 'support'),
    (4, 'FireHawk', 'entry'),
    (5, 'IronTitan', 'sniper');

-- El scrim 9 es una duplicada por error de digitacion (mismos clanes,
-- mapa, marcador y fecha que el scrim 1): se corrige en
-- dml/operaciones.sql.
INSERT INTO scrims (id_clan_local, id_clan_rival, mapa, marcador_local, marcador_rival, fecha_scrim, estado) VALUES
    (1, 2, 'bunker', 13, 9, '2026-08-01 18:00', 'jugado'),
    (3, 4, 'puerto', 10, 13, '2026-08-02 19:00', 'jugado'),
    (1, 5, 'ciudad', 13, 11, '2026-08-03 20:00', 'disputado'),
    (2, 3, 'desierto', 13, 7, '2026-08-04 18:30', 'jugado'),
    (4, 1, 'bunker', 8, 13, '2026-08-05 19:00', 'jugado'),
    (5, 2, 'puerto', 14, 12, '2026-08-06 20:00', 'jugado'),
    (3, 1, 'ciudad', 6, 13, '2026-08-07 18:00', 'jugado'),
    (4, 5, 'desierto', 13, 10, '2026-08-08 19:00', 'jugado'),
    (1, 2, 'bunker', 13, 9, '2026-08-01 18:00', 'jugado');

-- Caso comentado que debe fallar (no ser recomendable), dejar comentado:
-- un clan no puede enfrentarse a si mismo, viola el CHECK de scrims.
-- INSERT INTO scrims (id_clan_local, id_clan_rival, mapa, marcador_local, marcador_rival) VALUES (1, 1, 'bunker', 13, 5);
