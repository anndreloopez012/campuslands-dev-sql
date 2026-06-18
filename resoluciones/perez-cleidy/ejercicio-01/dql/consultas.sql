.headers on
.mode column

-- Ejercicio 01: CineMax SQLite
-- Escriba aqui las consultas obligatorias del README.

-- 1. Listar todos los registros principales.
SELECT * FROM peliculas; 

-- 2. Mostrar solo dos columnas relevantes.
SELECT director, duracion FROM peliculas;

-- 3. Filtrar por condicion numerica o de fecha.
SELECT * FROM funcion WHERE precio > 120;
-- 4. Ordenar resultados.

SELECT * FROM peliculas ORDER BY director ASC;

-- 5. Mostrar top 5 por una metrica.
SELECT * From peliculas ORDER BY duracion DESC LIMIT 5;

-- 6. Contar registros totales.
SELECT count(*) AS total_boletos_vendidos FROM boleto;

-- 7. Calcular promedio, minimo o maximo.
SELECT 
    AVG(precio) AS precio_promedio,
    MIN(precio) AS boleto_mas_barato,
    MAX(precio) AS boleto_mas_caro
FROM funcion;
-- 8. Agrupar con GROUP BY.
SELECT id_funcion, COUNT(*) AS cantidad_asientos
FROM boleto
GROUP BY id_funcion;

-- 9. Relacionar minimo dos tablas con JOIN.
SELECT p.nombre AS pelicula, f.hora, f.fecha 
FROM peliculas p 
INNER JOIN funcion f ON p.id_pelicula = f.id_pelicula;

-- 10. Usar WHERE, ORDER BY y LIMIT.
SELECT * FROM boleto Where fecha_compra = '2026-05-02' ORDER BY id_boleto LIMIT 3;

-- 11. Crear reporte con alias.
SELECT 
    p.nombre As [Titulo de la película],
    s.nombre AS [Sal a de Proyección],
    count(b.id_boleto) As [Total Bolesto Vendidos],
    sum(f.monto_pagado) As [Ingreso Total ($)]
FROM boleto As b
INNER JOIN funcion AS f ON b.id_funcion = f.id_funcion
INNER JOIN peliculas AS p ON f.id_pelicula = p.id_pelicula
INNER JOIN sala AS s ON f.id_sala = s.id_sala
GROUP BY p.nombre, s.nombre;

-- 12. Consulta para decision del negocio.
SELECT 
    s.nombre AS [Sala],
    b.fecha_compra AS [Fecha de Venta],
    SUM(f.precio) AS [Ingreso Diario],
    COUNT(b.id_boleto) AS [Asistencia]
FROM boleto AS b
INNER JOIN funcion AS f ON b.id_funcion = f.id_funcion
INNER JOIN sala AS s ON s.id_sala = s.id_sala
GROUP BY s.nombre, b.fecha_compra
ORDER BY [Ingreso Diario] ASC;
