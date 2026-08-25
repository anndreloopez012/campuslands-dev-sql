
USE cine;

-- Películas
INSERT INTO peliculas
(nombre_pelicula, duracion, clasificacion, genero, fecha_estreno, estado)
VALUES
('El Último Horizonte', 125, 'B', 'Ciencia ficción', '2026-06-12', 'ACTIVA'),
('La Casa del Bosque', 98, 'B15', 'Terror', '2026-07-03', 'ACTIVA'),
('Aventuras en Marte', 115, 'AA', 'Aventura', '2026-05-20', 'ACTIVA'),
('Código Secreto', 108, 'B', 'Acción', '2026-06-28', 'ACTIVA'),
('Una Historia Inesperada', 102, 'A', 'Drama', '2026-07-15', 'ACTIVA'),
('Risas de Verano', 95, 'A', 'Comedia', '2026-07-25', 'ACTIVA'),
('Guardianes de la Galaxia Perdida', 140, 'B', 'Fantasía', '2026-08-01', 'ACTIVA'),
('El Misterio del Lago', 110, 'B', 'Suspenso', '2026-08-10', 'ACTIVA');

-- Salas
INSERT INTO salas
(nombre_sala, capacidad, tipo_sala, estado)
VALUES
('Sala 1', 100, '2D', 'ACTIVA'),
('Sala 2', 80, '3D', 'ACTIVA'),
('Sala 3', 150, 'IMAX', 'ACTIVA'),
('Sala 4', 60, '2D', 'ACTIVA'),
('Sala 5', 120, '3D', 'ACTIVA'),
('Sala 6', 50, '2D', 'MANTENIMIENTO');

-- Funciones
INSERT INTO funciones
(id_pelicula, id_sala, fecha_funcion, hora_funcion, precio, idioma, formato, estado)
VALUES
(1, 1, '2026-08-25', '15:00:00', 85.00, 'Español', '2D', 'PROGRAMADA'),
(1, 3, '2026-08-25', '19:30:00', 150.00, 'Inglés', 'IMAX', 'PROGRAMADA'),
(2, 4, '2026-08-25', '17:00:00', 80.00, 'Español', '2D', 'PROGRAMADA'),
(3, 2, '2026-08-25', '13:30:00', 110.00, 'Español', '3D', 'PROGRAMADA'),
(4, 5, '2026-08-26', '16:00:00', 120.00, 'Inglés', '3D', 'PROGRAMADA'),
(5, 1, '2026-08-26', '18:00:00', 85.00, 'Español', '2D', 'PROGRAMADA'),
(6, 4, '2026-08-26', '20:30:00', 80.00, 'Español', '2D', 'PROGRAMADA'),
(7, 3, '2026-08-27', '14:00:00', 150.00, 'Inglés', 'IMAX', 'PROGRAMADA'),
(8, 2, '2026-08-27', '19:00:00', 110.00, 'Español', '3D', 'PROGRAMADA'),
(3, 5, '2026-08-28', '21:00:00', 120.00, 'Inglés', '3D', 'PROGRAMADA');

-- Boletos
INSERT INTO boletos
(id_funcion, numero_asiento, precio_pagado, comprador, estado)
VALUES
(1, 'A1', 85.00, 'Carlos Martínez', 'PAGADO'),
(1, 'A2', 85.00, 'Ana López', 'PAGADO'),
(1, 'A3', 85.00, 'Luis Hernández', 'RESERVADO'),

(2, 'B5', 150.00, 'María González', 'PAGADO'),
(2, 'B6', 150.00, 'Pedro Ramírez', 'PAGADO'),
(2, 'B7', 150.00, 'Sofía Torres', 'PAGADO'),

(3, 'C1', 80.00, 'Jorge Sánchez', 'PAGADO'),
(3, 'C2', 80.00, 'Laura Flores', 'RESERVADO'),

(4, 'D4', 110.00, 'Miguel Castro', 'PAGADO'),
(4, 'D5', 110.00, 'Elena Vargas', 'PAGADO'),
(4, 'D6', 110.00, 'Ricardo Mendoza', 'CANCELADO'),

(5, 'E8', 120.00, 'Daniel Romero', 'PAGADO'),
(5, 'E9', 120.00, 'Patricia Silva', 'PAGADO'),

(6, 'A10', 85.00, 'Fernando Cruz', 'PAGADO'),
(6, 'A11', 85.00, 'Gabriela Navarro', 'RESERVADO'),

(7, 'F1', 80.00, 'Alejandro Reyes', 'PAGADO'),
(7, 'F2', 80.00, 'Valeria Ortiz', 'PAGADO'),

(8, 'G10', 150.00, 'Roberto Molina', 'PAGADO'),
(8, 'G11', 150.00, 'Diana Castillo', 'PAGADO'),
(8, 'G12', 150.00, 'Andrés Vega', 'PAGADO'),

(9, 'H3', 110.00, 'Mónica Ríos', 'RESERVADO'),
(9, 'H4', 110.00, 'Héctor Navarro', 'PAGADO'),

(10, 'J1', 120.00, 'Claudia Méndez', 'PAGADO'),
(10, 'J2', 120.00, 'Eduardo Ponce', 'PAGADO');
