PRAGMA foreign_keys = ON;

-- Ejercicio 071: Battle Royale Ranking
-- Datos base: 5 jugadores, 1 temporada, 5 partidas (3 jugadas,
-- 1 programada, 1 cancelada), estadisticas de las partidas jugadas y
-- de la cancelada (para demostrar el DELETE controlado), y el
-- ranking inicial de la temporada en 0.

INSERT INTO jugadores (nickname, region) VALUES
    ('ShadowKill', 'Norte'),
    ('NightFury', 'Sur'),
    ('QuickScope', 'Centro'),
    ('IronWolf', 'Oeste'),
    ('PixelQueen', 'Centro');

INSERT INTO temporadas (nombre_temporada, fecha_inicio, fecha_fin) VALUES
    ('Temporada 1 - Verano 2026', '2026-07-01', '2026-08-31');

INSERT INTO partidas (id_temporada, fecha_partida, mapa, estado) VALUES
    (1, '2026-08-01', 'Isla Tormenta', 'jugada'),
    (1, '2026-08-03', 'Desierto Rojo', 'jugada'),
    (1, '2026-08-05', 'Bosque Nocturno', 'jugada'),
    (1, '2026-08-08', 'Isla Tormenta', 'programada');

-- Partida 5: se cargo como 'jugada' con sus estadisticas, pero el
-- servidor se cayo a la mitad de la partida y el resultado se anulo
-- despues. Se corrige el estado con UPDATE en dml/operaciones.sql.
INSERT INTO partidas (id_temporada, fecha_partida, mapa, estado) VALUES
    (1, '2026-08-02', 'Desierto Rojo', 'jugada');

-- Estadisticas de la partida 1 (Isla Tormenta, jugada por los 5).
INSERT INTO estadisticas (id_partida, id_jugador, kills, posicion_final) VALUES
    (1, 1, 5, 1),
    (1, 2, 3, 2),
    (1, 3, 1, 4),
    (1, 4, 0, 8),
    (1, 5, 2, 3);

-- Estadisticas de la partida 2 (Desierto Rojo, PixelQueen no jugo).
INSERT INTO estadisticas (id_partida, id_jugador, kills, posicion_final) VALUES
    (2, 1, 2, 3),
    (2, 2, 6, 1),
    (2, 3, 4, 2),
    (2, 4, 1, 6);

-- Estadisticas de la partida 3 (Bosque Nocturno, jugada por los 5).
INSERT INTO estadisticas (id_partida, id_jugador, kills, posicion_final) VALUES
    (3, 1, 1, 5),
    (3, 2, 2, 4),
    (3, 3, 7, 1),
    (3, 4, 3, 2),
    (3, 5, 0, 10);

-- Estadisticas de la partida 5, cargadas antes de saber que el
-- servidor se habia caido. Quedaran huerfanas cuando la partida se
-- marque 'cancelada' en dml/operaciones.sql, y se eliminan ahi mismo.
INSERT INTO estadisticas (id_partida, id_jugador, kills, posicion_final) VALUES
    (5, 1, 4, 2),
    (5, 2, 1, 6);

-- Ranking inicial de la temporada: una fila por jugador, en 0. Se
-- recalcula con UPDATE en dml/operaciones.sql a partir de las
-- estadisticas de las partidas 'jugada'.
INSERT INTO ranking (id_temporada, id_jugador, puntos_totales) VALUES
    (1, 1, 0),
    (1, 2, 0),
    (1, 3, 0),
    (1, 4, 0),
    (1, 5, 0);

-- Caso comentado que debe fallar (queda comentado): cargar de nuevo a
-- ShadowKill en la partida 1 es justo el problema que describio el
-- cliente (dato duplicado en la hoja de calculo); el UNIQUE
-- (id_partida, id_jugador) lo bloquea.
-- INSERT INTO estadisticas (id_partida, id_jugador, kills, posicion_final) VALUES (1, 1, 5, 1);
