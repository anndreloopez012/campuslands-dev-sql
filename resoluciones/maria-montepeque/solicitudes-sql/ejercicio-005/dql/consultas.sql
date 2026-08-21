.headers on
.mode column

-- Ejercicio 005: Cine Horror Nights
-- Consultas de validacion.

-- 1. Que registros principales existen.
SELECT * FROM boletos;

-- 2. Que registros estan activos, pendientes o finalizados (aqui:
--    boletos que ya no son una venta activa normal: usados o
--    reembolsados).
SELECT id_boleto, id_pelicula, nombre_cliente, asiento, estado
FROM boletos
WHERE estado <> 'vendido';

-- 3. Que pelicula vende mas boletos.
SELECT p.titulo, COUNT(*) AS total_boletos
FROM peliculas p
JOIN boletos b ON b.id_pelicula = p.id_pelicula
GROUP BY p.id_pelicula, p.titulo
ORDER BY total_boletos DESC;

-- 4. Boletos ordenados por fecha de compra.
SELECT id_boleto, nombre_cliente, asiento, fecha_compra, estado
FROM boletos
ORDER BY fecha_compra;

-- 5. Reporte util para el cine: ingresos por pelicula, excluyendo
--    boletos reembolsados, para decidir que extender en cartelera.
SELECT
    p.titulo,
    p.sala_asignada,
    SUM(b.precio_pagado) AS ingresos,
    COUNT(*) AS boletos_validos
FROM peliculas p
JOIN boletos b ON b.id_pelicula = p.id_pelicula
WHERE b.estado <> 'reembolsado'
GROUP BY p.id_pelicula, p.titulo, p.sala_asignada
ORDER BY ingresos DESC;
