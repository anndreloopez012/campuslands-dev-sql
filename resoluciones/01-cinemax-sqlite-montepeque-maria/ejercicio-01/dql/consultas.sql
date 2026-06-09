.headers on
.mode column

-- 1. Mostrar todas las peliculas registradas con todos sus atributos.

-- 2. Mostrar unicamente el nombre y la duracion de todas las peliculas.

-- 3. Mostrar las peliculas cuya duracion sea superior a 120 minutos.

-- 4. Mostrar las peliculas ordenadas alfabeticamente por nombre.

-- 5. Mostrar las tres peliculas con mayor duracion.

-- 6. Contar cuantas peliculas existen registradas.

-- 7. Mostrar la duracion promedio de las peliculas.

-- 8. Mostrar la pelicula con la mayor duracion.

-- 9. Mostrar todas las funciones programadas despues de una fecha especifica definida por usted.

-- 10. Contar cuantas funciones existen para cada sala utilizando GROUP BY.

-- ============================================================
-- CineMax - Consultas (DQL)
-- Autor: Maria Montepeque
-- Motor: SQLite
-- ============================================================

.headers on .mode column

-- 1. Mostrar todas las peliculas registradas con todos sus atributos.
SELECT * FROM peliculas;

-- 2. Mostrar unicamente el nombre y la duracion de todas las peliculas.
SELECT nombre, duracion FROM peliculas;

-- 3. Mostrar las peliculas cuya duracion sea superior a 120 minutos.
SELECT * FROM peliculas WHERE duracion > 120;

-- 4. Mostrar las peliculas ordenadas alfabeticamente por nombre.
SELECT * FROM peliculas ORDER BY nombre ASC;

-- 5. Mostrar las tres peliculas con mayor duracion.
SELECT * FROM peliculas ORDER BY duracion DESC LIMIT 3;

-- 6. Contar cuantas peliculas existen registradas.
SELECT COUNT(*) AS total_peliculas FROM peliculas;

-- 7. Mostrar la duracion promedio de las peliculas.
SELECT ROUND(AVG(duracion), 2) AS duracion_promedio FROM peliculas;

-- 8. Mostrar la pelicula con la mayor duracion.
SELECT * FROM peliculas ORDER BY duracion DESC LIMIT 1;

-- 9. Mostrar todas las funciones programadas despues de una fecha especifica.
SELECT * FROM funciones WHERE fecha > '2026-06-11';

-- 10. Contar cuantas funciones existen para cada sala usando GROUP BY.
SELECT id_sala, COUNT(*) AS total_funciones
FROM funciones
GROUP BY
    id_sala;