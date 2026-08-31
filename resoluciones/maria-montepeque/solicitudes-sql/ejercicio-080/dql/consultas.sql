.headers on
.mode column

-- Ejercicio 080: Cine Horror Nights
-- Consultas que responden preguntas reales del cliente.

-- 1. Que registros principales existen: todos los boletos con su
-- pelicula, su sala y su funcion.
SELECT b.id_boleto,
       p.titulo,
       s.nombre_sala,
       f.fecha_funcion,
       b.asiento,
       b.precio
FROM boletos b
JOIN funciones f ON f.id_funcion = b.id_funcion
JOIN peliculas p ON p.id_pelicula = f.id_pelicula
JOIN salas s ON s.id_sala = f.id_sala;

-- 2. Que funciones estan programadas, en curso, finalizadas o
-- canceladas.
SELECT id_funcion, fecha_funcion, hora_funcion, estado
FROM funciones
ORDER BY estado;

-- 3. Que pelicula vendio mas boletos (ranking de actividad).
SELECT p.titulo, COUNT(*) AS boletos_vendidos
FROM peliculas p
JOIN funciones f ON f.id_pelicula = p.id_pelicula
JOIN boletos b ON b.id_funcion = f.id_funcion
GROUP BY p.id_pelicula, p.titulo
ORDER BY boletos_vendidos DESC, p.titulo;

-- 4. Boletos ordenados por precio, de mayor a menor.
SELECT p.titulo, b.asiento, b.precio
FROM boletos b
JOIN funciones f ON f.id_funcion = b.id_funcion
JOIN peliculas p ON p.id_pelicula = f.id_pelicula
ORDER BY b.precio DESC;

-- 5. Reporte para decision de negocio: ingresos totales por pelicula,
-- para decidir cual mantener en cartelera (GROUP BY + HAVING).
SELECT p.titulo,
       SUM(b.precio) AS ingresos_totales
FROM peliculas p
JOIN funciones f ON f.id_pelicula = p.id_pelicula
JOIN boletos b ON b.id_funcion = f.id_funcion
GROUP BY p.id_pelicula, p.titulo
HAVING SUM(b.precio) > 0
ORDER BY ingresos_totales DESC;
