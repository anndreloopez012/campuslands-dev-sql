
-- 1. Ver todas las películas registradas
SELECT * FROM Peliculas;

-- 2. Ver todas las salas disponibles
SELECT * FROM Salas;

-- 3. Ver todas las funciones programadas
SELECT * FROM Funciones;

-- 4. Ver qué película se da en cada función (Uniendo tablas)
SELECT Funciones.id_funcion, Peliculas.titulo, Salas.nombre_sala, Funciones.fecha_hora
FROM Funciones
JOIN Peliculas ON Funciones.id_pelicula = Peliculas.id_pelicula
JOIN Salas ON Funciones.id_sala = Salas.id_sala;