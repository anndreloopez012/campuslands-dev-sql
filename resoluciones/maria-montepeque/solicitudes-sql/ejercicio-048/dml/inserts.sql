PRAGMA foreign_keys = ON;

-- Ejercicio 048: Clanes Shooter
-- Datos de prueba.

INSERT INTO clanes (nombre_clan, tag, region) VALUES
    ('Alfa Nocturno', 'ALFN', 'LATAM'),
    ('Furia Escarlata', 'FURE', 'NA'),
    ('Lobos de Acero', 'LOBA', 'EU'),
    ('Sombra Tactica', 'SMBT', 'APAC'),
    ('Vortice Rojo', 'VORT', 'LATAM'),
    ('Trueno Silencioso', 'TRSL', 'NA');

-- Todos los jugadores pertenecen a Alfa Nocturno (id_clan = 1); los
-- demas clanes solo aparecen como rivales en scrims.
INSERT INTO jugadores (nombre_jugador, id_clan, rol) VALUES
    ('RexSnipe', 1, 'sniper'),
    ('BlitzEntry', 1, 'entry'),
    ('GhostSupport', 1, 'support'),
    ('ViperIGL', 1, 'igl'),
    ('FalconRush', 1, 'entry');

INSERT INTO mapas (nombre_mapa, modo) VALUES
    ('Refineria', 'eliminacion_por_equipos'),
    ('Bunker Norte', 'busqueda_y_destruccion'),
    ('Puerto Fantasma', 'dominio'),
    ('Zona Roja', 'busqueda_y_destruccion'),
    ('Complejo Aereo', 'eliminacion_por_equipos');

-- El scrim 11 es un duplicado por error de digitacion (mismo rival,
-- mapa, fecha y rondas que el scrim 1): se corrige en
-- dml/operaciones.sql. El scrim 9 se cancelo antes de jugar ninguna
-- ronda (0/0): se borrara de forma controlada.
INSERT INTO scrims (id_clan_rival, id_mapa, fecha_scrim, rondas_ganadas, rondas_perdidas, estado) VALUES
    (2, 1, '2026-08-01', 13, 7, 'jugado'),
    (3, 2, '2026-08-02', 10, 12, 'jugado'),
    (2, 3, '2026-08-04', 13, 4, 'jugado'),
    (4, 1, '2026-08-05', 9, 13, 'jugado'),
    (5, 4, '2026-08-07', 13, 10, 'jugado'),
    (2, 2, '2026-08-09', 13, 6, 'jugado'),
    (3, 3, '2026-08-11', 6, 13, 'jugado'),
    (6, 5, '2026-08-13', 0, 0, 'programado'),
    (4, 4, '2026-08-15', 0, 0, 'cancelado'),
    (2, 5, '2026-08-17', 0, 0, 'programado'),
    (2, 1, '2026-08-01', 13, 7, 'jugado');

-- Casos comentados que deben fallar (no ser recomendables), dejar
-- comentados:

-- 1) Registro repetido: nombre_clan ya existe, viola el UNIQUE.
-- INSERT INTO clanes (nombre_clan, tag, region) VALUES ('Furia Escarlata', 'FUR2', 'NA');

-- 2) Valor fuera de rango: rondas_ganadas negativo, viola el CHECK.
-- INSERT INTO scrims (id_clan_rival, id_mapa, fecha_scrim, rondas_ganadas, rondas_perdidas) VALUES (3, 1, '2026-08-19', -1, 5);
