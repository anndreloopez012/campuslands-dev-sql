.headers on
.mode column

-- 1. Mostrar todas las peliculas registradas con todos sus atributos.
SELECT * FROM movies;

-- 2. Mostrar unicamente el nombre y la duracion de todas las peliculas.
SELECT title, duration_minutes FROM movies;

-- 3. Mostrar las peliculas cuya duracion sea superior a 120 minutos.
SELECT * FROM movies WHERE duration_minutes > 120;

-- 4. Mostrar las peliculas ordenadas alfabeticamente por nombre.
SELECT * FROM movies ORDER BY title ASC;

-- 5. Mostrar las tres peliculas con mayor duracion.
SELECT * FROM movies ORDER BY duration_minutes DESC LIMIT 3;

-- 6. Contar cuantas peliculas existen registradas.
SELECT COUNT(*) AS total_movies FROM movies;

-- 7. Mostrar la duracion promedio de las peliculas.
SELECT AVG(duration_minutes) AS average_duration FROM movies;

-- 8. Mostrar la pelicula con la mayor duracion.
SELECT * FROM movies WHERE duration_minutes = (SELECT MAX(duration_minutes) FROM movies);

-- 9. Mostrar todas las funciones programadas despues de una fecha especifica definida por usted.
SELECT * FROM screenings WHERE start_time > '2024-05-01 00:00:00';

-- 10. Contar cuantas funciones existen para cada sala utilizando GROUP BY.
SELECT r.room_name, COUNT(s.screening_id) AS total_screenings
FROM screenings s
JOIN rooms r ON s.room_id = r.room_id
GROUP BY r.room_id, r.room_name;
