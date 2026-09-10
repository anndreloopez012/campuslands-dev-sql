PRAGMA foreign_keys = ON;

-- Ejercicio 108: Indices Nivel Intermedio
-- Datos de prueba: 3 equipos, 6 jugadores, 10 partidas.

INSERT INTO equipos (nombre_equipo) VALUES
    ('Dragones Digitales'),
    ('Halcones Nocturnos'),
    ('Fenix Cibernetico');

INSERT INTO jugadores (id_equipo, nombre_jugador, gamer_tag) VALUES
    (1, 'Manuel Estrada',      'M-Blaze'),
    (1, 'Alejandra Chinchilla','AleShadow'),
    (2, 'Byron Xicay',         'ByroWolf'),
    (2, 'Sofia Martinez',      'SofiStorm'),
    (3, 'Cristina Barrios',    'CrisFrost'),
    (3, 'Pedro Ramirez',       'PedroFlame');

INSERT INTO partidas (id_equipo, puntaje, fecha_partida, resultado) VALUES
    (1, 80, '2026-08-10', 'victoria'),
    (1, 60, '2026-08-12', 'derrota'),
    (1, 90, '2026-08-14', 'victoria'),
    (2, 70, '2026-08-10', 'victoria'),
    (2, 55, '2026-08-13', 'derrota'),
    (2, 65, '2026-08-15', 'empate'),
    (3, 40, '2026-08-11', 'derrota'),
    (3, 75, '2026-08-13', 'victoria'),
    (3, 50, '2026-08-16', 'derrota'),
    (1, 85, '2026-08-17', 'victoria');

-- Caso comentado que no se debe hacer, dejar comentado: registrar una
-- partida con puntaje negativo. El CHECK (puntaje >= 0) lo rechaza.
-- INSERT INTO partidas (id_equipo, puntaje, fecha_partida, resultado) VALUES (1, -10, '2026-08-18', 'derrota');
