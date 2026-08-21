PRAGMA foreign_keys = ON;

-- Ejercicio 01: CineMax SQLite
-- Inserción de datos iniciales válidos

-- Insertar Salas
INSERT INTO salas (nombre_sala, capacidad, tipo_pantalla) VALUES 
('Sala 1', 100, 'IMAX'),
('Sala 2', 80, '3D'),
('Sala 3', 50, '2D');

-- Insertar Películas
INSERT INTO peliculas (titulo, genero, duracion_minutos, clasificacion) VALUES 
('Interestelar', 'Ciencia Ficción', 169, 'PG-13'),
('El Padrino', 'Drama', 175, 'R'),
('Toy Story', 'Animación', 81, 'G');

-- Insertar Funciones
INSERT INTO funciones (pelicula_id, sala_id, fecha_hora, precio) VALUES 
(1, 1, '2026-08-25 18:30:00', 15.50),
(2, 2, '2026-08-25 21:00:00', 12.00),
(3, 3, '2026-08-26 15:00:00', 10.00);

-- Insertar Boletos
INSERT INTO boletos (funcion_id, numero_asiento, estado) VALUES 
(1, 'A1', 'vendido'),
(1, 'A2', 'vendido'),
(2, 'B5', 'reservado');