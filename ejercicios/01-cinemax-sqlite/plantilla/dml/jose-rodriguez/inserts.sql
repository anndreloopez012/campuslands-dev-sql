PRAGMA foreign_keys = ON;

INSERT INTO peliculas (id_pelicula, titulo, genero, duracion_minutos, clasificacion) VALUES (1, 'Oppenheimer', 'Drama Historico', 180, 'B');
INSERT INTO peliculas (id_pelicula, titulo, genero, duracion_minutos, clasificacion) VALUES (2, 'Barbie', 'Comedia', 114, 'A');
INSERT INTO peliculas (id_pelicula, titulo, genero, duracion_minutos, clasificacion) VALUES (3, 'Dune: Part Two', 'Ciencia Ficcion', 166, 'B');
INSERT INTO peliculas (id_pelicula, titulo, genero, duracion_minutos, clasificacion) VALUES (4, 'Inside Out 2', 'Animacion', 96, 'A');
INSERT INTO peliculas (id_pelicula, titulo, genero, duracion_minutos, clasificacion) VALUES (5, 'Mission: Impossible - Dead Reckoinhg', 'Accion', 163, 'B15');

INSERT INTO salas (id_sala, nombre, capacidad) VALUES (1, 'Sala 1', 120);
INSERT INTO salas (id_sala, nombre, capacidad) VALUES (2, 'Sala 2', 150);
INSERT INTO salas (id_sala, nombre, capacidad) VALUES (3, 'Sala 3', 100);
INSERT INTO salas (id_sala, nombre, capacidad) VALUES (4, 'Sala 4', 80);
INSERT INTO salas (id_sala, nombre, capacidad) VALUES (5, 'Sala VIP', 60);

INSERT INTO funciones (id_funcion, id_pelicula, id_sala, fecha_hora, precio) VALUES (1, 1, 1, '2026-06-10 18:00', 85.00);
INSERT INTO funciones (id_funcion, id_pelicula, id_sala, fecha_hora, precio) VALUES (2, 2, 2, '2026-06-10 16:00', 75.00);
INSERT INTO funciones (id_funcion, id_pelicula, id_sala, fecha_hora, precio) VALUES (3, 3, 3, '2026-06-10 20:00', 90.00);
INSERT INTO funciones (id_funcion, id_pelicula, id_sala, fecha_hora, precio) VALUES (4, 4, 4, '2026-06-11 14:00', 70.00);
INSERT INTO funciones (id_funcion, id_pelicula, id_sala, fecha_hora, precio) VALUES (5, 5, 5, '2026-06-11 21:00', 120.00);

INSERT INTO boletos (id_boleto, id_funcion, asiento, fecha_compra) VALUES (1, 1, 'A1', '2026-06-08');
INSERT INTO boletos (id_boleto, id_funcion, asiento, fecha_compra) VALUES (2, 1, 'A2', '2026-06-08');
INSERT INTO boletos (id_boleto, id_funcion, asiento, fecha_compra) VALUES (3, 2, 'B1', '2026-06-08');
INSERT INTO boletos (id_boleto, id_funcion, asiento, fecha_compra) VALUES (4, 2, 'B2', '2026-06-08');
INSERT INTO boletos (id_boleto, id_funcion, asiento, fecha_compra) VALUES (5, 3, 'C1', '2026-06-09'); 
INSERT INTO boletos (id_boleto, id_funcion, asiento, fecha_compra) VALUES (6, 3, 'C2', '2026-06-09'); 
 