PRAGMA foreign_keys = ON;

-- Inserte aqui los datos de prueba.
-- Requisitos minimos:
-- 5 peliculas, 5 salas, 8 funciones y 10 boletos.

-- Casos de error sugeridos:
-- Mantenga comentadas las inserciones que deben fallar para que el script principal ejecute correctamente.

INSERT INTO peliculas (nombre_pelicula, duracion, categoria) VALUES
('Terminator', 120, 'Accion'),
('Código 8', 128, 'Accion'),
('Annabelle', 98, 'Terror'),
('El Conjuro', 112, 'Terror'),
('Toy Story', 90, 'Animacion');

INSERT INTO salas (nombre_sala, capacidad) VALUES
('Sala 01', 100),
('Sala 02', 80),
('Sala 03', 120),
('Sala 04', 90),
('Sala 05', 110);

INSERT INTO boletos (precio_boleto, asiento, fecha) VALUES
(10.00, 'A1', '2024-07-01'),
(12.50, 'A2', '2024-07-01'),
(8.00, 'B1', '2024-07-02'),
(9.50, 'B2', '2024-07-02'),
(11.00, 'C1', '2024-07-03'),
(13.00, 'C2', '2024-07-03'),
(7.50, 'D1', '2024-07-04'),
(8.50, 'D2', '2024-07-04'),
(9.00, 'E1', '2024-07-05'),
(10.50, 'E2', '2024-07-05');

INSERT INTO funciones (pelicula_id, sala_id, boletos_id, horario, fecha) VALUES
(1, 1, 1, '18:00', '2024-07-01'),
(2, 2, 2, '20:00', '2024-07-01'),
(3, 3, 3, '18:00', '2024-07-02'),
(4, 4, 4, '20:00', '2024-07-02'),
(5, 5, 5, '18:00', '2024-07-03'),
(1, 1, 6, '20:00', '2024-07-03'),
(2, 2, 7, '18:00', '2024-07-04'),
(3, 3, 8, '20:00', '2024-07-04');  

