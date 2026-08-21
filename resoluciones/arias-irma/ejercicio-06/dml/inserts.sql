PRAGMA foreign_keys = ON;

-- Insertar Equipos (5 registros)
INSERT INTO equipos (nombre, region, anio_fundacion) VALUES 
('Sentinels', 'Norteamérica', 2018),
('Fnatic', 'Europa', 2004),
('Paper Rex', 'Pacífico', 2020),
('Leviatán', 'Latinoamérica', 2020),
('DRX', 'Corea', 2012);

-- Insertar Jugadores (5 registros principales)
INSERT INTO jugadores (equipo_id, gamertag, rol, edad) VALUES 
(1, 'Tenz', 'Duelista', 22),
(2, 'Boaster', 'Iniciador', 28),
(3, 'Jinggg', 'Duelista', 20),
(4, 'King', 'Controlador', 21),
(5, 'Stax', 'Iniciador', 23);

-- Insertar Partidas (5 registros base)
INSERT INTO partidas (fase, fecha_hora, mapa) VALUES 
('Fase de Grupos', '2026-08-01 15:00', 'Ascent'),
('Fase de Grupos', '2026-08-02 17:00', 'Bind'),
('Semifinales', '2026-08-05 16:00', 'Haven'),
('Semifinales', '2026-08-06 18:00', 'Split'),
('Gran Final', '2026-08-10 19:00', 'Lotus');

-- Insertar Resultados (10 registros relacionales)
INSERT INTO resultados (partida_id, equipo_id, puntuacion, resultado) VALUES 
(1, 1, 13, 'victoria'),
(1, 2, 9, 'derrota'),
(2, 3, 13, 'victoria'),
(2, 4, 11, 'derrota'),
(3, 1, 13, 'victoria'),
(3, 5, 8, 'derrota'),
(4, 2, 13, 'victoria'),
(4, 3, 10, 'derrota'),
(5, 1, 3, 'derrota'),
(5, 2, 13, 'victoria');