PRAGMA foreign_keys = ON;

-- Ejercicio 022: Liga MOBA
-- Datos de prueba.

INSERT INTO equipos (nombre_equipo, region) VALUES
    ('Titanes Latam', 'LATAM'),
    ('Furia Norte', 'NA'),
    ('Dragones EU', 'EU'),
    ('Samurai Gaming', 'ASIA');

INSERT INTO jugadores (id_equipo, nickname, rol) VALUES
    (1, 'ShadowKing', 'medio'),
    (1, 'IronFist', 'top'),
    (2, 'NightBlade', 'jungla'),
    (3, 'FrostQueen', 'soporte'),
    (4, 'StormRider', 'tirador'),
    (2, 'VoidWalker', 'medio');

-- El registro 9 es una duplicada por error de digitacion (mismo
-- jugador, heroe, fecha, resultado y premio que el registro 1): se
-- corrige en dml/operaciones.sql.
INSERT INTO partidas_jugadas (id_jugador, heroe_usado, fecha_partida, resultado, premio_ganado, estado) VALUES
    (1, 'Zeratul', '2026-08-01 18:00', 'victoria', 500.00, 'confirmado'),
    (3, 'Thrall', '2026-08-01 18:00', 'derrota', 0.00, 'confirmado'),
    (2, 'Muradin', '2026-08-02 19:00', 'victoria', 300.00, 'en_revision'),
    (5, 'Valla', '2026-08-02 19:00', 'derrota', 0.00, 'confirmado'),
    (1, 'Kael Thas', '2026-08-03 20:00', 'victoria', 500.00, 'confirmado'),
    (4, 'Lucio', '2026-08-03 20:00', 'derrota', 0.00, 'confirmado'),
    (6, 'Li Ming', '2026-08-04 18:30', 'victoria', 400.00, 'confirmado'),
    (5, 'Valla', '2026-08-04 18:30', 'derrota', 0.00, 'confirmado'),
    (1, 'Zeratul', '2026-08-01 18:00', 'victoria', 500.00, 'confirmado');

-- Caso comentado que debe fallar (no ser recomendable), dejar comentado:
-- premio_ganado negativo, viola el CHECK de partidas_jugadas.
-- INSERT INTO partidas_jugadas (id_jugador, heroe_usado, resultado, premio_ganado) VALUES (3, 'Sylvanas', 'victoria', -100);
