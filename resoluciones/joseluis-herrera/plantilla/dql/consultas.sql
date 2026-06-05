.headers on
.mode column

-- 1. Mostrar todas las peliculas registradas con todos sus atributos.
    Select * FROM Peliculas;
-- 2. Mostrar unicamente el nombre y la duracion de todas las peliculas.
    Select titulo, duracion FROM Peliculas;
-- 3. Mostrar las peliculas cuya duracion sea superior a 120 minutos.
    Select * FROM Peliculas WHERE duracion > 120;
-- 4. Mostrar las peliculas ordenadas alfabeticamente por nombre.
    Select titulo FROM Peliculas ORDER BY titulo ASC;
-- 5. Mostrar las tres peliculas con mayor duracion.
    Select * FROM Peliculas ORDER BY duracion DESC LIMIT 3;
-- 6. Contar cuantas peliculas existen registradas.
    SELECT COUNT(*) AS total_peliculas FROM Peliculas;
-- 7. Mostrar la duracion promedio de las peliculas.
    SELECT AVG(duracion) AS promedio_duracion FROM Peliculas;
-- 8. Mostrar la pelicula con la mayor duracion.
    SELECT * FROM Peliculas ORDER BY duracion DESC LIMIT 1;
-- 9. Mostrar todas las funciones programadas despues de una fecha especifica definida por usted.
    SELECT * FROM Funciones WHERE hora > '2023-01-01 00:00:00';
-- 10. Contar cuantas funciones existen para cada sala utilizando GROUP BY.
    SELECT id_sala, COUNT(*) AS total_funciones FROM Funciones GROUP BY id_sala;

