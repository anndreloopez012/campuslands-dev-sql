.headers on
.mode column

PRAGMA foreign_keys=ON;

-- 1. Mostrar todas las peliculas registradas con todos sus atributos.
SELECT * FROM peliculas;
-- 2. Mostrar unicamente el nombre y la duracion de todas las peliculas.
SELECT nombre, duracion FROM peliculas;
-- 3. Mostrar las peliculas cuya duracion sea superior a 120 minutos.
SELECT * FROM peliculas WHERE duracion > 120 ;
-- 4. Mostrar las peliculas ordenadas alfabeticamente por nombre.
SELECT * FROM peliculas ORDER BY nombre ASC
-- 5. Mostrar las tres peliculas con mayor duracion.
SELECT * FROM peliculas ORDER BY duracion DESC LIMIT 3;
-- 6. Contar cuantas peliculas existen registradas.
SELECT count(*) AS total_peliculas FROM peliculas;

-- 7. Mostrar la duracion promedio de las peliculas.
SELECT AVG(duracion) AS promedios_minutos FROM peliculas;

-- 8. Mostrar la pelicula con la mayor duracion.
SELECT * FROM peliculas WHERE duracion = (SELECT max(duracion) FROM peliculas)

-- 9. Mostrar todas las funciones programadas despues de una fecha especifica definida por usted.
SELECT * FROM funcion WHERE fecha > '2026-12-05';
-- 10. Contar cuantas funciones existen para cada sala utilizando GROUP BY.
SELECT id_sala, count(*) AS total_funcion FROM funcion GROUP BY id_sala;