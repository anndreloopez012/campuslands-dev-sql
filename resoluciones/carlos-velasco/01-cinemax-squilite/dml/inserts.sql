PRAGMA foreign_keys = ON;

-- Inserte aqui los datos de prueba.
-- Requisitos minimos:
-- 5 peliculas, 5 salas, 8 funciones y 10 boletos.

-- Casos de error sugeridos:
-- Mantenga comentadas las inserciones que deben fallar para que el script principal ejecute correctamente.

INSERT INTO pelicula (titulo, genero, duracion, clasificacion) VALUES 
('Inception', 'Ciencia Ficción', 148, 'B15'),
('Toy Story', 'Animación', 81, 'A'),
('The Dark Knight', 'Acción', 152, 'B15'),
('Pulp Fiction', 'Crimen', 154, 'C'),
('La La Land', 'Musical', 128, 'B');
-- 1. Error de CHECK: Duración negativa
-- INSERT INTO pelicula (titulo, genero, duracion, clasificacion) VALUES ('Fail', 'Drama', -10, 'A');

INSERT INTO sala (nombre_sala, tipo_sala, capacidad) VALUES
('Sala 1', 'Estándar', 100),
('Sala 2', 'Estándar', 100),
('Sala 3', 'VIP', 50),
('Sala 4', 'IMAX', 200),
('Sala 5', 'Estándar', 80);

INSERT INTO funcion (id_pelicula, id_sala, fecha_hora, estado) VALUES
(1, 1, '2026-06-04 15:00:00', 'terminada'),
(2, 2, '2026-06-05 16:00:00', 'proceso'),
(3, 3, '2026-06-05 17:00:00', 'programada'),
(4, 4, '2026-05-05 18:00:00', 'programada'),
(5, 5, '2026-06-05 19:00:00', 'programada'),
(1, 2, '2026-06-05 20:00:00', 'programada'),
(2, 4, '2026-06-05 21:00:00', 'programada'),
(3, 1, '2026-06-05 22:00:00', 'programada');
-- 2. Error de FOREIGN KEY: Sala inexistente 
-- INSERT INTO funcion (id_pelicula, id_sala, fecha_hora, estado) VALUES (1, 99, '2026-06-06 10:00:00', 'programada');

INSERT INTO boleto (id_funcion, numero_asiento, precio, estado) VALUES
(1, 'A1', 80.00, 'vendido'),
(1, 'B2', 80.00, 'vendido'),
(2, 'C3', 95.00, 'vendido'),
(3, 'D4', 120.00, 'disponible'),
(4, 'E5', 150.00, 'vendido'),
(5, 'F6', 80.00, 'disponible'),
(6, 'G7', 80.00, 'vendido'),
(7, 'H8', 120.00, 'vendido'),
(8, 'I9', 80.00, 'disponible'),
(8, 'J10', 80.00, 'vendido');
-- 3. Error de UNIQUE: Título duplicado
-- INSERT INTO pelicula (titulo, genero, duracion, clasificacion) VALUES ('Inception', 'Otro', 100, 'A');