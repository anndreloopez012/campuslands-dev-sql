.headers on
.mode column

-- Ejercicio 02: Campus Shop
-- Escriba aqui las consultas obligatorias del README.

-- 1. Listar todos los registros principales.
SELECT id,nombre, apellido, email, telefono
FROM clientes
WHERE nombre LIKE '%M%';

-- 2. Mostrar solo dos columnas relevantes.
SELECT nombre_producto, precio 
FROM productos
ORDER BY nombre_producto, precio ASC;

-- 3. Filtrar por condicion numerica o de fecha.

SELECT V.id_venta, P.nombre_producto, V.total 
FROM ventas V INNER JOIN productos P
ON V.id_producto = P.id
WHERE V.total > 1000
GROUP BY V.id_venta, P.nombre_producto, V.total;

-- 4. Ordenar resultados.
SELECT * FROM clientes ORDER BY apellido ASC;

-- 5. Mostrar top 5 por una metrica.
SELECT * FROM ventas WHERE total > 3 ORDER BY total DESC LIMIT 2;

-- 6. Contar registros totales.
SELECT COUNT(*) FROM clientes;


-- 7. Calcular promedio, minimo o maximo.
SELECT AVG(total) FROM ventas;

SELECT MIN(precio) AS precio_minimo, MAX(precio) AS precio_maximo
FROM productos;

-- 8. Agrupar con GROUP BY.
SELECT id_venta, id_producto, total FROM ventas
WHERE total > 2000
GROUP BY id_venta, id_producto, total;

-- 9. Relacionar minimo dos tablas con JOIN.
SELECT V.id_venta, P.nombre_producto, V.total 
FROM ventas V INNER JOIN productos P
ON V.id_producto = P.id
WHERE V.total > 1000
GROUP BY V.id_venta, P.nombre_producto, V.total;

-- 10. Usar WHERE, ORDER BY y LIMIT.
SELECT * FROM ventas WHERE total > 3 ORDER BY total DESC LIMIT 2;

-- 11. Crear reporte con alias.
SELECT COUNT(*) AS Total_clientes FROM clientes;

-- 12. Consulta para decision del negocio.

SELECT nombre_producto, precio 
FROM productos
ORDER BY nombre_producto, precio ASC;