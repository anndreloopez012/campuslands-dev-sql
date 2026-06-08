-- Activar soporte de llaves foráneas para esta sesión de inserciones
PRAGMA foreign_keys = ON;


-- SECCIÓN 1: INSERCIONES VÁLIDAS (Mínimo: 5 películas, 5 salas, 8 funciones, 10 boletos)
-- =========================================================================

-- 1. Insertar Películas
INSERT INTO peliculas (titulo, duracion, director, genero) VALUES 
('Inception', 148, 'Christopher Nolan', 'Ciencia Ficción'),
('The Dark Knight', 152, 'Christopher Nolan', 'Acción'),
('Interstellar', 169, 'Christopher Nolan', 'Ciencia Ficción'),
('Toy Story', 81, 'John Lasseter', 'Animación'),
('Spirited Away', 125, 'Hayao Miyazaki', 'Animación');

-- 2. Insertar Salas
INSERT INTO salas (tipo, capacidad) VALUES 
('2D Estándar', 100),
('3D Max', 80),
('IMAX', 150),
('VIP', 40),
('Macro XE', 120);

-- 3. Insertar Funciones (Precios y formatos de fecha )
INSERT INTO funciones (id_pelicula, id_sala, horario, precio, fecha) VALUES 
(1, 1, '14:30', 12.50, '2026-06-10'),
(1, 3, '18:00', 18.00, '2026-06-10'),
(2, 2, '21:00', 15.00, '2026-06-10'),
(3, 3, '15:00', 20.00, '2026-06-11'),
(4, 1, '10:00', 10.00, '2026-06-11'),
(4, 4, '12:30', 22.00, '2026-06-11'),
(5, 5, '16:00', 14.00, '2026-06-12'),
(2, 3, '23:00', 20.00, '2026-06-12');

-- 4. Insertar Boletos Vendidos 10 boletos usando códigos únicos y asientos
INSERT INTO boletos_vendidos (numero_serie, id_funcion, fecha_compra, numero_asiento) VALUES 
('BOL-0001', 1, '2026-06-07 10:15:00', 'A1'),
('BOL-0002', 1, '2026-06-07 10:20:00', 'A2'),
('BOL-0003', 2, '2026-06-07 11:00:00', 'F10'),
('BOL-0004', 3, '2026-06-07 14:30:00', 'C5'),
('BOL-0005', 3, '2026-06-07 14:35:00', 'C6'),
('BOL-0006', 4, '2026-06-08 09:00:00', 'H8'),
('BOL-0007', 5, '2026-06-08 09:15:00', 'B3'),
('BOL-0008', 6, '2026-06-08 10:00:00', 'A1'),
('BOL-0009', 7, '2026-06-09 16:20:00', 'D4'),
('BOL-0010', 8, '2026-06-09 19:40:00', 'M12');


-- SECCIÓN 2: CASOS DE PRUEBA QUE GENERAN ERROR 
-- =========================================================================

-- Caso de Error 1: Violación de Llave Foránea
-- crear función para una película con ID 99 que no existe en la tabla de películas.
INSERT INTO funciones (id_pelicula, id_sala, horario, precio, fecha) VALUES 
(99, 1, '19:00', 12.00, '2026-06-15');
-- lanza: FOREIGN KEY constraint failed


-- Caso de Error 2: Violación de Restricción ÚNICA 
-- registrar un boleto con el número de serie BOL-0001 que ya fue insertado arriba.
INSERT INTO boletos_vendidos (numero_serie, id_funcion, fecha_compra, numero_asiento) VALUES
('BOL-0001', 2, '2026-06-07 12:00:00', 'B5');


-- Caso de Error 3: Violación de Restricción de Validación CHECK
-- insertar una película con duración negativa
INSERT INTO peliculas (titulo, duracion, director, genero) VALUES 
('Flash', -10, 'Andy Muschietti', 'Acción');
-- lanza: CHECK constraint failed: duracion > 0
