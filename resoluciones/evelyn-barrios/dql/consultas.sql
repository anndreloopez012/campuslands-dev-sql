-- =========================================================================
-- PARTE 4: CONSULTAS CON DQL - CINEMAX
.headers on
.mode column

-- =========================================================================

-- 1. Mostrar todas las películas registradas con todos sus atributos.
SELECT * FROM peliculas;

-- 2. Mostrar únicamente el nombre y la duración de todas las películas.
SELECT titulo, duracion FROM peliculas;

-- 3. Mostrar las películas cuya duración sea superior a 120 minutos.
SELECT * FROM peliculas 
WHERE duracion > 120;

-- 4. Mostrar las películas ordenadas alfabéticamente por nombre.
SELECT * FROM peliculas 
ORDER BY titulo ASC;

-- 5. Mostrar las tres películas con mayor duración.
SELECT * FROM peliculas 
ORDER BY duracion DESC 
LIMIT 3;

-- 6. Contar cuántas películas existen registradas.
SELECT COUNT(*) AS total_peliculas FROM peliculas;

-- 7. Mostrar la duración promedio de las películas.
SELECT AVG(duracion) AS duracion_promedio FROM peliculas;

-- 8. Mostrar la película con la mayor duración.
SELECT * FROM peliculas 
ORDER BY duracion DESC 
LIMIT 1;

-- 9. Mostrar todas las funciones programadas después de una fecha específica (ej. '2026-06-10').
SELECT * FROM funciones 
WHERE fecha > '2026-06-10';

-- 10. Contar cuántas funciones existen para cada sala utilizando GROUP BY.
SELECT id_sala, COUNT(*) AS total_funciones 
FROM funciones 
GROUP BY id_sala;
