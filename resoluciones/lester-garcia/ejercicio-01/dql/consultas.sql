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

SELECT * FROM Peliculas;
SELECT TITULO, DURACION FROM Peliculas;
SELECT * FROM Peliculas WHERE DURACION > 120;
SELECT * FROM Peliculas ORDER BY TITULO;
SELECT * FROM Peliculas ORDER BY DURACION DESC LIMIT 3;
SELECT COUNT(*) AS Total_Peliculas FROM Peliculas;
SELECT AVG(DURACION) AS Duracion_Promedio FROM Peliculas;
SELECT * FROM Peliculas WHERE DURACION = (SELECT MAX(DURACION) FROM Peliculas);
SELECT * FROM Funcion WHERE FECHA > '2026-06-10';
SELECT ID_SALA, COUNT(*) AS Total_Funciones FROM Funcion GROUP BY ID_SALA;  