PRAGMA foreign_keys = ON;

-- Ejercicio 56: CHECK Nivel Basico
-- Datos de prueba para validar el tema CHECK.

-- Casos validos: region dentro de la lista permitida.
INSERT INTO equipos (nombre_equipo, region) VALUES
    ('Dragones Rojos', 'Norteamerica'),
    ('Lobos del Norte', 'Sudamerica'),
    ('Fenix Gaming', 'Europa'),
    ('Aguilas Negras', 'Asia');

-- Casos validos: edad dentro del rango 14-45.
INSERT INTO jugadores (id_equipo, nombre, edad) VALUES
    (1, 'Andres Lopez', 22),
    (1, 'Marta Vega', 19),
    (2, 'Carlos Ruiz', 17),
    (3, 'Pedro Gomez', 30),
    (4, 'Sofia Reyes', 24);

-- Casos validos: estado dentro de la lista permitida, puntajes >= 0 y
-- ningun equipo jugando contra si mismo.
INSERT INTO partidas (id_equipo_local, id_equipo_visitante, fecha_partida, estado, puntaje_local, puntaje_visitante) VALUES
    (1, 2, '2026-08-10 18:00', 'jugada', 3, 1),
    (3, 4, '2026-08-10 20:00', 'jugada', 0, 2),
    (2, 3, '2026-08-11 18:00', 'programada', NULL, NULL),
    (4, 1, '2026-08-12 18:00', 'cancelada', NULL, NULL);

-- Caso comentado que debe fallar (no ser recomendable), dejar comentado:
-- region fuera de la lista permitida por el CHECK de equipos.
-- INSERT INTO equipos (nombre_equipo, region) VALUES ('Titanes FC', 'Antartida');

-- Otro caso comentado que debe fallar: edad fuera del rango CHECK (14-45)
-- de jugadores.
-- INSERT INTO jugadores (id_equipo, nombre, edad) VALUES (1, 'Nino Prodigio', 10);

-- Otro caso comentado que debe fallar: puntaje negativo, viola el CHECK de
-- rango numerico en partidas.
-- INSERT INTO partidas (id_equipo_local, id_equipo_visitante, fecha_partida, estado, puntaje_local, puntaje_visitante) VALUES (1, 2, '2026-08-13 18:00', 'jugada', -1, 2);

-- Otro caso comentado que debe fallar: un equipo no puede jugar contra si
-- mismo, viola el CHECK a nivel de tabla en partidas.
-- INSERT INTO partidas (id_equipo_local, id_equipo_visitante, fecha_partida) VALUES (1, 1, '2026-08-14 18:00');
