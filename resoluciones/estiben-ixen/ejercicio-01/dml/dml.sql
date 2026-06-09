-- database: :memory:
INSERT INTO pelicula (nombre_pelicula) VALUES
('The Batman'),
('Spider-Man: No Way Home'),
('Doctor Strange in the Multiverse of Madness'),
('Thor: Love and Thunder'),
('Black Panther: Wakanda Forever'),
('Avatar: The Way of Water'),
('Jurassic World: Dominion'),
('Peaky Blinders: The Movie'),
('The Flash'),
('Aquaman and the Lost Kingdom');

INSERT INTO sala (numero_sala) VALUES
(1),
(2),
(3),
(4),
(5),
(6),
(7);    

INSERT INTO boletos_vendidos (numero_boleto, id_funciones) VALUES
(100, 1),
(150, 2),
(200, 3),
(250, 4),
(300, 5),
(350, 6),
(400, 7),
(450, 8),
(500, 9),
(550, 10);


INSERT INTO funciones (id_pelicula, id_sala, hora_funcion, fecha_funcion) VALUES
(1, 1, '18:00', '2024-07-01'),
(2, 2, '20:00', '2024-07-01'),
(3, 3, '22:00', '2024-07-01'),
(4, 4, '18:00', '2024-07-02'),
(5, 5, '20:00', '2024-07-02'),
(6, 1, '22:00', '2024-07-02'),
(7, 2, '18:00', '2024-07-03'),
(8, 3, '20:00', '2024-07-03'),
(9, 4, '22:00', '2024-07-03'),
(10, 5, '18:00', '2024-07-04');