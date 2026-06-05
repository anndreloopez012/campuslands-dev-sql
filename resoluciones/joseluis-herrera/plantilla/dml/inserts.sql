PRAGMA foreign_keys = ON;

-- Inserte aqui los datos de prueba.
-- Requisitos minimos:
-- 5 peliculas, 5 salas, 8 funciones y 10 boletos.

-- Casos de error sugeridos:
-- Mantenga comentadas las inserciones que deben fallar para que el script principal ejecute correctamente.
--Peliculas
Insert INTO Peliculas (titulo, genero, descripcion, duracion, idioma) VALUES ('Rendirse Jamas', 'pelea', 'Una pelicula de superacion', 120, 'español');
Insert INTO Peliculas (titulo, genero, descripcion, duracion, idioma) VALUES ('Rapidos y Furiosos', 'accion', 'Una pelicula que trata sobre carreras ilegales', 90, 'español');
Insert INTO Peliculas (titulo, genero, descripcion, duracion, idioma) VALUES ('Titanic', 'romance', 'Dos jóvenes se enamoran a bordo de un famoso barco.', 195, 'español');
Insert INTO Peliculas (titulo, genero, descripcion, duracion, idioma) VALUES ('Parasite', 'drama', 'Una familia pobre se infiltra en la vida de una familia rica', 132, 'español');
Insert INTO Peliculas (titulo, genero, descripcion, duracion, idioma) VALUES ('Coco', 'accion', 'Un niño viaja al mundo de los muertos.', 105, 'español');

--Salas
Insert INTO Salas (nombre, cantidad_asientos) VALUES ('Sala AJ1', 100);
Insert INTO Salas (nombre, cantidad_asientos) VALUES ('Sala AJ2', 80);
Insert INTO Salas (nombre, cantidad_asientos) VALUES ('Sala AJ3', 120);
Insert INTO Salas (nombre, cantidad_asientos) VALUES ('Sala AJ4', 90);
Insert INTO Salas (nombre, cantidad_asientos) VALUES ('Sala AJ5', 110);

--Funciones
Insert INTO Funciones (id_pelicula, id_sala, hora) VALUES (1, 3, '2026-07-01 18:00:00');
Insert INTO Funciones (id_pelicula, id_sala, hora) VALUES (2, 1, '2026-07-01 20:00:00');
Insert INTO Funciones (id_pelicula, id_sala, hora) VALUES (3, 4, '2026-07-02 18:00:00');
Insert INTO Funciones (id_pelicula, id_sala, hora) VALUES (4, 2, '2026-07-02 20:00:00');
Insert INTO Funciones (id_pelicula, id_sala, hora) VALUES (5, 1, '2026-07-03 18:00:00');
Insert INTO Funciones (id_pelicula, id_sala, hora) VALUES (1, 5, '2026-07-03 20:00:00');
Insert INTO Funciones (id_pelicula, id_sala, hora) VALUES (2, 2, '2026-07-04 18:00:00');
Insert INTO Funciones (id_pelicula, id_sala, hora) VALUES (3, 5, '2026-07-04 20:00:00');

--Boletos
Insert INTO Boletos (id_funcion, asiento, precio) VALUES (1, 'A1', 45.00);
Insert INTO Boletos (id_funcion, asiento, precio) VALUES (2, 'A2', 45.00);
Insert INTO Boletos (id_funcion, asiento, precio) VALUES (3, 'B1', 50.00);
Insert INTO Boletos (id_funcion, asiento, precio) VALUES (4, 'B2', 50.00);
Insert INTO Boletos (id_funcion, asiento, precio) VALUES (5, 'C1', 40.00);
Insert INTO Boletos (id_funcion, asiento, precio) VALUES (6, 'C2', 40.00);
Insert INTO Boletos (id_funcion, asiento, precio) VALUES (7, 'D1', 35.00);
Insert INTO Boletos (id_funcion, asiento, precio) VALUES (8, 'D2', 35.00);
Insert INTO Boletos (id_funcion, asiento, precio) VALUES (9, 'E1', 30.00);
Insert INTO Boletos (id_funcion, asiento, precio) VALUES (10, 'E2', 30.00);

--script de errores
-- estos errores si se descomentan aunque ya esten ingresados en la tabla se pueden ingresar de nuevo o se puede cuplicar el dato.
--Insert INTO Peliculas(titulo, genero, descripcion, duracion, idioma) VALUES ('Rendirse Jamas', 'pelea', 'Una pelicula de superacion', 120, 'español');
--Insert INTO Salas(nombre, cantidad_asientos) VALUES ('Sala AJ1', 100);