.headers on
.mode column

-- 1. Mostrar todas las peliculas registradas con todos sus atributos.
SELECT * FROM peliculas;

-- 2. Mostrar unicamente el nombre y la duracion de todas las peliculas.
SELECT pelicula_nombre, duracion FROM peliculas;

-- 3. Mostrar las peliculas cuya duracion sea superior a 120 minutos.
SELECT * FROM peliculas WHERE duracion > 120;

-- 4. Mostrar las peliculas ordenadas alfabeticamente por nombre.
SELECT * FROM peliculas ORDER BY pelicula_nombre ASC;

-- 5. Mostrar las tres peliculas con mayor duracion.
SELECT * FROM peliculas ORDER BY duracion DESC LIMIT 3;

-- 6. Contar cuantas peliculas existen registradas.
SELECT COUNT(*) AS total_peliculas FROM peliculas;

-- 7. Mostrar la duracion promedio de las peliculas.
SELECT AVG(duracion) AS duracion_promedio FROM peliculas;

-- 8. Mostrar la pelicula con la mayor duracion.
SELECT * FROM peliculas ORDER BY duracion DESC LIMIT 1;

-- 9. Mostrar todas las funciones programadas despues de una fecha especifica definida por usted.
SELECT * FROM funciones WHERE fecha_hora > '2026-06-10 16:00';

-- 10. Contar cuantas funciones existen para cada sala utilizando GROUP BY.
SELECT sala_id, COUNT(*) AS total_funciones FROM funciones GROUP BY sala_id;
