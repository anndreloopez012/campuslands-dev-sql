-- Insertar datos en la tabla Peliculas
INSERT INTO Peliculas (titulo, duracion_minutos) VALUES 
('Avengers: Endgame', 181),
('Inception', 148),
('Toy Story', 81);

-- Insertar datos en la tabla Salas
INSERT INTO Salas (nombre_sala, capacidad) VALUES 
('Sala IMAX', 200),
('Sala 3D', 150);

-- Insertar datos en la tabla Funciones
INSERT INTO Funciones (id_pelicula, id_sala, fecha_hora) VALUES 
(1, 1, '2026-06-05 14:00:00'),
(2, 2, '2026-06-05 16:00:00');