.headers on
.mode column

-- Ejercicio 01: CineMax SQLite
-- Escriba aqui las consultas obligatorias del README.

-- 1. Listar todos los registros principales.

SELECT * FROM peliculas;

-- 2. Mostrar solo dos columnas relevantes.

SELECT titulo, genero FROM peliculas;


-- 3. Filtrar por condicion numerica o de fecha.

SELECT titulo, duracion_minutos FROM peliculas WHERE duracion_minutos > 120;

-- 4. Ordenar resultados.

SELECT titulo, genero FROM peliculas ORDER BY titulo ASC;

-- 5. Mostrar top 5 por una metrica.

SELECT f.id_funcion, COUNT(b.id_boleto) AS total_boletos
FROM funciones f
JOIN boletos b ON f.id_funcion = b.id_funcion
GROUP BY f.id_funcion
ORDER BY total_boletos DESC
LIMIT 5;

-- 6. Contar registros totales.

SELECT COUNT(*) AS total_boletos FROM boletos;

-- 7. Calcular promedio, minimo o maximo.

SELECT
	AVG(precio) AS promedio_precio,
	MIN(precio) AS precio_minimo,
	MAX(precio) AS precio_maximo
FROM funciones;

-- 8. Agrupar con GROUP BY.

SELECT p.titulo, COUNT(b.id_boleto) AS total_boletos
FROM peliculas p
JOIN funciones f ON p.id_pelicula = f.id_pelicula
JOIN boletos b ON f.id_funcion = b.id_funcion
GROUP BY p.titulo;

-- 9. Relacionar minimo dos tablas con JOIN.

SELECT f.id_funcion, p.titulo, f.fecha_hora
FROM funciones f
JOIN peliculas p ON f.id_pelicula = p.id_pelicula;

-- 10. Usar WHERE, ORDER BY y LIMIT.

SELECT * FROM funciones WHERE precio > 80 ORDER BY fecha_hora DESC LIMIT 3;

-- 11. Crear reporte con alias.

SELECT p.titulo AS Pelicula, COUNT(b.id_boleto) AS TotalBoletosVendidos
FROM peliculas p
JOIN funciones f ON p.id_pelicula = f.id_pelicula
JOIN boletos b ON f.id_funcion = b.id_funcion
GROUP BY p.titulo; 


-- 12. Consulta para decision del negocio.


SELECT p.titulo, COUNT(b.id_boleto) AS demanda
FROM peliculas p
JOIN funciones f ON p.id_pelicula = f.id_pelicula
JOIN boletos b ON f.id_funcion = b.id_funcion
GROUP BY p.titulo
ORDER BY demanda DESC;
