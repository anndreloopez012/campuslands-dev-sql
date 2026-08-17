-- Ejercicio 02: Campus Shop
-- Entidad central: ventas

-- 1. Listar todos los registros principales de la entidad central
SELECT * FROM ventas;

-- 2. Mostrar solo dos columnas relevantes
SELECT cantidad, precio_unitario FROM ventas;

-- 3. Filtrar registros por una condicion numerica
SELECT * FROM ventas WHERE cantidad > 1;

-- 4. Ordenar resultados por fecha
SELECT * FROM ventas ORDER BY fecha_venta;

-- 5. Mostrar las 5 ventas con mayor monto (cantidad * precio_unitario)
SELECT *, (cantidad * precio_unitario) AS monto
FROM ventas
ORDER BY monto DESC
LIMIT 5;

-- 6. Contar registros totales
SELECT COUNT(*) AS total_ventas FROM ventas;

-- 7. Promedio, minimo y maximo del monto vendido
SELECT
    AVG(cantidad * precio_unitario) AS promedio,
    MIN(cantidad * precio_unitario) AS minimo,
    MAX(cantidad * precio_unitario) AS maximo
FROM ventas;

-- 8. Agrupar ventas por producto
SELECT id_producto, COUNT(*) AS cantidad_ventas
FROM ventas
GROUP BY id_producto;

-- 9. Relacionar ventas, clientes y productos con JOIN
SELECT v.id_venta, c.nombre AS cliente, p.nombre AS producto
FROM ventas v
JOIN clientes c ON c.id_cliente = v.id_cliente
JOIN productos p ON p.id_producto = v.id_producto;

-- 10. WHERE + ORDER BY + LIMIT
SELECT * FROM ventas
WHERE cantidad >= 2
ORDER BY fecha_venta DESC
LIMIT 3;

-- 11. Reporte con alias legibles
SELECT
    c.nombre AS cliente,
    p.nombre AS producto,
    v.cantidad AS unidades,
    v.precio_unitario AS precio,
    (v.cantidad * v.precio_unitario) AS total
FROM ventas v
JOIN clientes c ON c.id_cliente = v.id_cliente
JOIN productos p ON p.id_producto = v.id_producto;

-- 12. Consulta para decision de negocio: producto mas vendido por unidades
SELECT p.nombre, SUM(v.cantidad) AS unidades_vendidas
FROM ventas v
JOIN productos p ON p.id_producto = v.id_producto
GROUP BY p.nombre
ORDER BY unidades_vendidas DESC
LIMIT 1;
