PRAGMA foreign_keys = ON;

-- Ejercicio 078: Torneo Esports
-- Datos base: 3 equipos, 9 jugadores, 4 partidas (2 jugadas, 1
-- jugada-por-error que se corrige despues, 1 programada = caso
-- pendiente), estadisticas de las partidas jugadas (incluye la
-- erronea) y el ranking inicial de los 3 equipos en 0.

INSERT INTO equipos (nombre_equipo, region) VALUES
    ('Titanes Cyber', 'Norte'),
    ('Fenix Digital', 'Sur'),
    ('Lobos Binarios', 'Centro');

INSERT INTO jugadores (nickname, id_equipo) VALUES
    ('TitanBlaze', 1),
    ('CyberFrost', 1),
    ('IronCircuit', 1),
    ('PhoenixArc', 2),
    ('EmberCode', 2),
    ('SolarFlux', 2),
    ('WolfByte', 3),
    ('ShadowLoop', 3),
    ('NightHash', 3);

-- Partida 1: Titanes Cyber (local) vs Fenix Digital (visitante),
-- jugada.
INSERT INTO partidas (id_equipo_local, id_equipo_visitante, fecha_partida, estado) VALUES
    (1, 2, '2026-08-01', 'jugada');

-- Partida 2: Fenix Digital (local) vs Lobos Binarios (visitante),
-- jugada.
INSERT INTO partidas (id_equipo_local, id_equipo_visitante, fecha_partida, estado) VALUES
    (2, 3, '2026-08-03', 'jugada');

-- Partida 3: Titanes Cyber vs Lobos Binarios. Se marco 'jugada' y se
-- cargaron estadisticas, pero el servidor de la plataforma fallo y el
-- resultado se anulo despues. Se corrige en dml/operaciones.sql.
INSERT INTO partidas (id_equipo_local, id_equipo_visitante, fecha_partida, estado) VALUES
    (1, 3, '2026-08-05', 'jugada');

-- Partida 4: caso pendiente (programada), todavia no se juega.
INSERT INTO partidas (id_equipo_local, id_equipo_visitante, fecha_partida, estado) VALUES
    (3, 1, '2026-08-08', 'programada');

-- Estadisticas de la partida 1.
INSERT INTO estadisticas (id_partida, id_jugador, puntos) VALUES
    (1, 1, 10),
    (1, 2, 8),
    (1, 3, 6),
    (1, 4, 7),
    (1, 5, 5),
    (1, 6, 4);

-- Estadisticas de la partida 2.
INSERT INTO estadisticas (id_partida, id_jugador, puntos) VALUES
    (2, 4, 9),
    (2, 5, 6),
    (2, 6, 5),
    (2, 7, 12),
    (2, 8, 10),
    (2, 9, 8);

-- Estadisticas cargadas por error para la partida 3, antes de saber
-- que el servidor habia fallado. Quedaran huerfanas cuando la partida
-- se marque 'cancelada' en dml/operaciones.sql, y se eliminan ahi
-- mismo.
INSERT INTO estadisticas (id_partida, id_jugador, puntos) VALUES
    (3, 1, 5),
    (3, 2, 3);

-- Ranking inicial de los 3 equipos, en 0. Se recalcula con UPDATE en
-- dml/operaciones.sql a partir de las estadisticas de las partidas
-- 'jugada'.
INSERT INTO ranking (id_equipo, puntos_totales) VALUES
    (1, 0),
    (2, 0),
    (3, 0);

-- Caso comentado que debe fallar (queda comentado): cargar de nuevo a
-- TitanBlaze en la partida 1, exactamente el problema que este UNIQUE
-- esta disenado para evitar.
-- INSERT INTO estadisticas (id_partida, id_jugador, puntos) VALUES (1, 1, 10);
