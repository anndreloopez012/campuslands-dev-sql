PRAGMA foreign_keys = ON;

-- Ejercicio 90: GROUP BY Nivel Intermedio
-- Datos de prueba: 3 equipos, 4 jugadores, 7 partidas.

INSERT INTO equipos (nombre_equipo, region) VALUES
    ('Dragones Digitales', 'GT-Central'),
    ('Halcones Nocturnos', 'GT-Occidente'),
    ('Fenix Cibernetico', 'GT-Oriente');

INSERT INTO jugadores (id_equipo, nombre_jugador, gamer_tag) VALUES
    (1, 'Manuel Estrada', 'M-Blaze'),
    (1, 'Alejandra Chinchilla', 'AleShadow'),
    (2, 'Byron Xicay', 'ByroWolf'),
    (3, 'Cristina Barrios', 'CrisFrost');

INSERT INTO partidas (id_equipo, fecha_partida, puntaje, resultado) VALUES
    (1, '2026-08-10', 85, 'victoria'),
    (1, '2026-08-12', 60, 'derrota'),
    (1, '2026-08-14', 90, 'victoria'),
    (2, '2026-08-10', 70, 'victoria'),
    (2, '2026-08-13', 55, 'derrota'),
    (3, '2026-08-11', 40, 'derrota'),
    (3, '2026-08-15', 65, 'empate');

-- Caso comentado que no se debe hacer, dejar comentado: registrar una
-- partida con puntaje negativo. El CHECK (puntaje >= 0) lo rechaza.
-- INSERT INTO partidas (id_equipo, fecha_partida, puntaje, resultado) VALUES (1, '2026-08-16', -10, 'derrota');
