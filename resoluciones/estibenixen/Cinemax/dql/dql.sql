SELECT * FROM peliculas

SELECT nombre_pelicula, duracion_pelicula FROM peliculas;

SELECT nombre_pelicula FROM peliculas WHERE duracion_pelicula > 120;

SELECT nombre_pelicula FROM peliculas ORDER BY nombre_pelicula ASC;

SELECT nombre_pelicula FROM peliculas ORDER BY duracion_pelicula DESC LIMIT 3;

SELECT id_pelicula FROM peliculas;

SELECT avg(duracion_pelicula) AS promedio_duracion FROM peliculas;

SELECT nombre_pelicula FROM peliculas ORDER BY duracion_pelicula DESC LIMIT 1;

SELECT id_funciones, id_pelicula, id_sala, hora_funcion, fecha_funcion FROM funciones
WHERE fecha_funcion = '2026-06-04'
ORDER BY hora_funcion ASC, hora_funcion ASC;

SELECT sala, COUNT(*) AS total_funciones FROM funciones
GROUP BY id_sala
ORDER BY total_funciones DESC;
