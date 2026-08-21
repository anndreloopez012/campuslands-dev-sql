PRAGMA foreign_keys = ON;

-- Ejercicio 021: Battle Royale Ranking
-- Datos de prueba.

INSERT INTO jugadores (gamertag, equipo, nivel) VALUES
    ('ShadowFox', 'Dragones', 12),
    ('NightHunter', 'Lobos', 15),
    ('BlazeStorm', 'Dragones', 8),
    ('IceQueen', 'Fenix', 20),
    ('GhostRider', 'Lobos', 10);

INSERT INTO partidas (mapa, fecha_partida, total_jugadores) VALUES
    ('desierto', '2026-08-10 18:00', 50),
    ('isla', '2026-08-11 19:00', 60),
    ('urbano', '2026-08-12 20:00', 45),
    ('nieve', '2026-08-13 18:30', 55);

-- La estadistica 9 es una entrada duplicada por error de digitacion
-- (mismo jugador, misma partida, mismos kills y posicion que la
-- estadistica 1): se corrige en dml/operaciones.sql. La estadistica 3
-- entra en revision porque el numero de kills parece sospechosamente
-- alto para el nivel del jugador.
INSERT INTO estadisticas (id_jugador, id_partida, kills, posicion_final, estado) VALUES
    (1, 1, 8, 1, 'confirmada'),
    (2, 1, 5, 4, 'confirmada'),
    (3, 2, 12, 1, 'en_revision'),
    (4, 2, 3, 10, 'confirmada'),
    (1, 3, 6, 2, 'confirmada'),
    (5, 3, 2, 15, 'confirmada'),
    (2, 4, 9, 1, 'confirmada'),
    (4, 4, 4, 5, 'confirmada'),
    (1, 1, 8, 1, 'confirmada');

-- Caso comentado que debe fallar (no ser recomendable), dejar comentado:
-- posicion_final en cero, viola el CHECK de estadisticas.
-- INSERT INTO estadisticas (id_jugador, id_partida, kills, posicion_final) VALUES (3, 4, 2, 0);
