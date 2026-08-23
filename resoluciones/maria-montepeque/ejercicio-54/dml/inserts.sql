PRAGMA foreign_keys = ON;

-- Ejercicio 54: NOT NULL Nivel Intermedio
-- Datos de prueba para validar el tema NOT NULL.

-- logo_url se deja NULL para dos equipos: es un campo opcional, y NOT NULL
-- no lo exige.
INSERT INTO equipos (nombre_equipo, pais, logo_url) VALUES
    ('Dragones Rojos', 'Guatemala', 'https://torneo.example/logos/dragones.png'),
    ('Lobos del Norte', 'Mexico', 'https://torneo.example/logos/lobos.png'),
    ('Fenix Gaming', 'Colombia', NULL),
    ('Aguilas Negras', 'Peru', NULL),
    ('Titanes FC', 'Chile', 'https://torneo.example/logos/titanes.png');

-- apodo se deja NULL para los jugadores que compiten con su propio nombre:
-- es opcional, no todos usan un gamer tag distinto.
INSERT INTO jugadores (id_equipo, nombre, apodo) VALUES
    (1, 'Andres Lopez', 'DragonSlayer'),
    (1, 'Marta Vega', NULL),
    (2, 'Carlos Ruiz', 'LoboAlfa'),
    (2, 'Diana Cruz', NULL),
    (3, 'Pedro Gomez', 'FenixX'),
    (3, 'Laura Ortiz', NULL),
    (4, 'Sofia Reyes', 'BlackEagle'),
    (5, 'Mario Paz', 'TitanKing');

-- puntaje_local y puntaje_visitante se dejan NULL mientras la partida no se
-- juega: son opcionales hasta que hay un resultado real que registrar.
INSERT INTO partidas (id_equipo_local, id_equipo_visitante, fecha_partida, estado, puntaje_local, puntaje_visitante) VALUES
    (1, 2, '2026-08-10 18:00', 'jugada', 3, 1),
    (3, 4, '2026-08-10 20:00', 'jugada', 2, 2),
    (5, 1, '2026-08-11 18:00', 'jugada', 0, 4),
    (2, 3, '2026-08-12 18:00', 'programada', NULL, NULL),
    (4, 5, '2026-08-12 20:00', 'programada', NULL, NULL),
    (1, 4, '2026-08-13 18:00', 'cancelada', NULL, NULL),
    (2, 5, '2026-08-13 20:00', 'programada', NULL, NULL);

-- Caso valido: logo_url y apodo pueden faltar (NULL) sin problema, porque
-- no llevan NOT NULL.
INSERT INTO equipos (nombre_equipo, pais, logo_url) VALUES
    ('Halcones del Sur', 'Ecuador', NULL);

-- Caso comentado que debe fallar (no ser recomendable), dejar comentado:
-- nombre_equipo es NOT NULL en equipos; omitirlo (o pasar NULL explicito)
-- falla.
-- INSERT INTO equipos (nombre_equipo, pais) VALUES (NULL, 'Bolivia');

-- Otro caso comentado que debe fallar: fecha_partida es NOT NULL en
-- partidas; una partida sin fecha no se puede programar y la base la
-- rechaza.
-- INSERT INTO partidas (id_equipo_local, id_equipo_visitante, fecha_partida) VALUES (1, 2, NULL);
