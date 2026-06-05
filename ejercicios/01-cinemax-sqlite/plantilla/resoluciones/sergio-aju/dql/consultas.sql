SELECT * FROM peliculas;

SELECT titulo FROM peliculas;

SELECT nombre_sala, capacidad FROM salas WHERE tipo_proyeccion = '2D';

SELECT * peliculas WHERE duracion_minutos > 150;

SELECT * FROM funciones WHERE precio_base = 45.00;

SELECT * FROM funciones WHERE fecha_hora BETWEEN '2026-06-15 00:00' AND '2026-06-15 23:59';

SELECT * FROM peliculas ORDER BY duracion_minutos ASC;

SELECT * FROM peliculas ORDER BY duracion_minutos DESC;

SELECT COUNT(*) FROM peliculas;

SELECT COUNT(*) FROM funciones WHERE precio_base > 40.00;

SELECT * FROM boletos WHERE fecha_compra = '2026-06-15 17:30';

SELECT p.titulo, s.nombre_sala, f.fecha_hora FROM funciones f
INNER JOIN peliculas p ON p.id_pelicula = f.id_pelicula
INNER JOIN salas s ON s.id_sala = f.id_sala;