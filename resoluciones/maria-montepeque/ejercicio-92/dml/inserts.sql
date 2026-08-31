PRAGMA foreign_keys = ON;

-- Ejercicio 92: HAVING Nivel Basico
-- Datos de prueba: 4 equipos, 10 partidas.

INSERT INTO equipos (nombre_equipo) VALUES
    ('Dragones Digitales'),
    ('Halcones Nocturnos'),
    ('Fenix Cibernetico'),
    ('Titanes de Acero');

INSERT INTO partidas (id_equipo, fecha_partida, resultado) VALUES
    -- Dragones Digitales: 3 victorias
    (1, '2026-08-01', 'victoria'),
    (1, '2026-08-03', 'victoria'),
    (1, '2026-08-05', 'victoria'),
    (1, '2026-08-07', 'derrota'),
    -- Halcones Nocturnos: 1 victoria
    (2, '2026-08-02', 'victoria'),
    (2, '2026-08-06', 'derrota'),
    -- Fenix Cibernetico: 2 victorias
    (3, '2026-08-04', 'victoria'),
    (3, '2026-08-08', 'victoria'),
    (3, '2026-08-09', 'empate'),
    -- Titanes de Acero: 0 victorias
    (4, '2026-08-10', 'derrota');

-- Caso comentado que no se debe hacer, dejar comentado: registrar una
-- partida con un resultado fuera del catalogo permitido. El
-- CHECK (resultado IN (...)) lo rechaza.
-- INSERT INTO partidas (id_equipo, fecha_partida, resultado) VALUES (1, '2026-08-11', 'sabotaje');
