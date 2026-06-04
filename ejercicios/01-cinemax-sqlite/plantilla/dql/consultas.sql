.headers on
.mode column

-- 1. Mostrar todas las peliculas registradas con todos sus atributos.
select * from Peliculas;

-- 2. Mostrar unicamente el nombre y la duracion de todas las peliculas.
select Nombre, Duracion from Peliculas;

-- 3. Mostrar las peliculas cuya duracion sea superior a 120 minutos.
select * from Peliculas where Duracion > 120;

-- 4. Mostrar las peliculas ordenadas alfabeticamente por nombre.
select * from Peliculas order by Nombre;

-- 5. Mostrar las tres peliculas con mayor duracion.
select * from Peliculas order by Duracion desc limit 3;

-- 6. Contar cuantas peliculas existen registradas.
select count(*) as TotalPeliculas from Peliculas;

-- 7. Mostrar la duracion promedio de las peliculas.
select avg(Duracion) as DuracionPromedio from Peliculas;

-- 8. Mostrar la pelicula con la mayor duracion.
select * from Peliculas order by Duracion desc limit 1;

-- 9. Mostrar todas las funciones programadas despues de una fecha especifica definida por usted.
select * from Funciones where FechaFuncion > '2026-06-05';

-- 10. Contar cuantas funciones existen para cada sala utilizando GROUP BY.
select ID_Sala, count(*) as TotalFunciones from Funciones group by ID_Sala;


