PRAGMA foreign_keys = ON;

-- Ejercicio 028: Torneo Esports
-- Datos de prueba.

INSERT INTO equipos (nombre_equipo, region) VALUES
    ('Dragones Rojos', 'Norteamerica'),
    ('Lobos del Norte', 'Sudamerica'),
    ('Fenix Gaming', 'Europa'),
    ('Aguilas Negras', 'Asia');

INSERT INTO jugadores (id_equipo, nickname, rol) VALUES
    (1, 'ShadowFox', 'duelist'),
    (1, 'IceQueen', 'support'),
    (2, 'WolfBite', 'entry'),
    (2, 'NightHunter', 'duelist'),
    (3, 'PhoenixX', 'support'),
    (4, 'BlackEagle', 'igl');

-- La partida 9 es una duplicada por error de digitacion (mismo jugador,
-- puntos, resultado y fecha que la partida 1): se corrige en
-- dml/operaciones.sql.
INSERT INTO partidas (id_jugador, puntos_obtenidos, resultado, fecha_partida, estado) VALUES
    (1, 25, 'victoria', '2026-08-01 18:00', 'confirmada'),
    (3, 18, 'derrota', '2026-08-01 18:00', 'confirmada'),
    (2, 15, 'victoria', '2026-08-02 19:00', 'pendiente'),
    (5, 10, 'derrota', '2026-08-02 19:00', 'confirmada'),
    (1, 30, 'victoria', '2026-08-03 20:00', 'confirmada'),
    (4, 22, 'victoria', '2026-08-03 20:00', 'confirmada'),
    (6, 20, 'derrota', '2026-08-04 18:30', 'confirmada'),
    (3, 28, 'victoria', '2026-08-04 18:30', 'confirmada'),
    (1, 25, 'victoria', '2026-08-01 18:00', 'confirmada');

-- Caso comentado que debe fallar (no ser recomendable), dejar comentado:
-- puntos_obtenidos negativo, viola el CHECK de partidas.
-- INSERT INTO partidas (id_jugador, puntos_obtenidos, resultado) VALUES (5, -10, 'derrota');
