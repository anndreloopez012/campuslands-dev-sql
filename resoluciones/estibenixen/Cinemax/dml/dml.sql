INSERT TO pelicula (nombre_pelicula, duracion_pelicula) VALUES
('The Batman',200),
('peake blenders', 140),
('The Flash', 201),
('Black Adam', 110),
('Shazam! Fury of the Gods', 130),
('The Marvels', 150),
('Guardians of the Galaxy Vol. 3', 160),
('Spider-Man: No Way Home', 180),
('Doctor Strange in the Multiverse of Madness', 120),
('Aquaman and the Lost Kingdom', 200),

INSERT TO sala (numero_sala) VALUES
(1),
(2),
(3),
(4),
(5),
(6),
(7);    

INSERT TO boletos_vendidos (numero_boleto, id_funciones) VALUES
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


INSERT TO funciones (id_pelicula, id_sala, hora_funcion, fecha_funcion) VALUES
(1, 1, '18:00', '2024-07-01'),
(2, 2, '20:00', '2024-07-01'),
(3, 3, '22:00', '2024-07-01'),
(4, 4, '18:00', '2024-07-02'),
(5, 5, '20:00', '2024-07-02');
(6, 1, '22:00', '2024-07-02');
(7, 2, '18:00', '2024-07-03');
(8, 3, '20:00', '2024-07-03');
(9, 4, '22:00', '2024-07-03');
(10, 5, '18:00', '2024-07-04');