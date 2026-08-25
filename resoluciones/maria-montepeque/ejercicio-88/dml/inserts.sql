PRAGMA foreign_keys = ON;

-- Ejercicio 88: ORDER BY Nivel Aplicado
-- Datos de prueba.

INSERT INTO equipos (nombre_equipo, region) VALUES
    ('Dragones del Norte', 'Norte'),
    ('Lobos del Sur', 'Sur'),
    ('Halcones del Centro', 'Centro'),
    ('Tigres del Oeste', 'Oeste');

INSERT INTO jugadores (nombre, id_equipo) VALUES
    ('Kevin Us', 1),
    ('Oscar Tzul', 2),
    ('Melissa Ordonez', 3),
    ('Sergio Batz', 4);

-- Partidas jugadas.
INSERT INTO partidas (id_equipo_local, id_equipo_visitante, fecha_partida, puntaje_local, puntaje_visitante, estado) VALUES
    (1, 2, '2026-08-01', 3, 1, 'jugada'),
    (3, 4, '2026-08-02', 2, 2, 'jugada'),
    (2, 3, '2026-08-03', 0, 1, 'jugada'),
    (4, 1, '2026-08-04', 1, 1, 'jugada'),
    (1, 3, '2026-08-05', 2, 0, 'jugada');

-- Partida todavia no jugada.
INSERT INTO partidas (id_equipo_local, id_equipo_visitante, fecha_partida) VALUES
    (2, 4, '2026-08-08');
