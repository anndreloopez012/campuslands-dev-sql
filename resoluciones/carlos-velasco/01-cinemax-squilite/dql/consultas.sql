.headers on
.mode column

-- 1. Mostrar todas las peliculas registradas con todos sus atributos.
SELECT * FROM pelicula

-- 2. Mostrar unicamente el nombre y la duracion de todas las peliculas.
SELECT titulo, duracion FROM pelicula

-- 3. Mostrar las peliculas cuya duracion sea superior a 120 minutos.
SELECT * FROM pelicula WHERE duracion > 120

-- 4. Mostrar las peliculas ordenadas alfabeticamente por nombre.
SELECT * FROM pelicula ORDER BY titulo ASC;

-- 5. Mostrar las tres peliculas con mayor duracion.
SELECT * FROM pelicula ORDER BY duracion DESC LIMIT 3;

-- 6. Contar cuantas peliculas existen registradas.
SELECT COUNT(*) FROM pelicula;
-- 7. Mostrar la duracion promedio de las peliculas.
-- Promedio de duracion de todas las peliculas
SELECT AVG(duracion) AS promedio_duracion FROM pelicula;
-- Manera antigua
SELECT SUM(duracion) * 1.0 / COUNT(*) AS promedio_duracion FROM pelicula;
-- 8. Mostrar la pelicula con la mayor duracion.
SELECT titulo FROM pelicula ORDER BY duracion DESC LIMIT 1;
-- 9. Mostrar todas las funciones programadas despues de una fecha especifica definida por usted.
SELECT * FROM funcion WHERE fecha_hora > '2026-06-05 12:00:00';
-- 10. Contar cuantas funciones existen para cada sala utilizando GROUP BY.
SELECT id_sala, COUNT(*) AS total_funciones FROM funcion GROUP BY id_sala;
