.headers on .mode column

-- Ejercicio 31: Normalizacion Ventas Campus

-- 1. Reconstruir una vista similar al CSV original usando JOIN.
SELECT
    v.id_venta,
    c.nombre AS cliente_nombre,
    c.email AS cliente_email,
    group_concat(p.nombre, ' | ') AS productos_comprados,
    group_concat(d.precio_unitario, ' | ') AS precios,
    group_concat(d.cantidad, ' | ') AS cantidades,
    ve.nombre AS vendedor,
    s.nombre AS sucursal
FROM
    ventas v
    JOIN clientes c ON c.id_cliente = v.id_cliente
    JOIN vendedores ve ON ve.id_vendedor = v.id_vendedor
    JOIN sucursales s ON s.id_sucursal = ve.id_sucursal
    JOIN detalle_venta d ON d.id_venta = v.id_venta
    JOIN productos p ON p.id_producto = d.id_producto
GROUP BY
    v.id_venta
ORDER BY v.id_venta;

-- 2. Listar entidades principales sin duplicados.
SELECT DISTINCT nombre, email FROM clientes ORDER BY nombre;

-- 3. Contar registros por categoria (ventas por sucursal).
SELECT s.nombre AS sucursal, COUNT(v.id_venta) AS total_ventas
FROM
    sucursales s
    LEFT JOIN vendedores ve ON ve.id_sucursal = s.id_sucursal
    LEFT JOIN ventas v ON v.id_vendedor = ve.id_vendedor
GROUP BY
    s.id_sucursal
ORDER BY total_ventas DESC;

-- 4. Calcular el total por transaccion.
SELECT v.id_venta, SUM(
        d.cantidad * d.precio_unitario
    ) AS total_venta
FROM ventas v
    JOIN detalle_venta d ON d.id_venta = v.id_venta
GROUP BY
    v.id_venta
ORDER BY total_venta DESC;

-- 5. Calcular promedio, minimo y maximo del monto por venta.
SELECT
    ROUND(AVG(total_venta), 2) AS promedio_venta,
    MIN(total_venta) AS venta_minima,
    MAX(total_venta) AS venta_maxima
FROM (
        SELECT id_venta, SUM(cantidad * precio_unitario) AS total_venta
        FROM detalle_venta
        GROUP BY
            id_venta
    );

-- 6. Buscar registros con LIKE
SELECT nombre, precio FROM productos WHERE nombre LIKE '%Mouse%';

-- 7. Filtrar por rango de fecha (ventas de enero 2025).
SELECT id_venta, fecha
FROM ventas
WHERE
    fecha BETWEEN '2025-01-01' AND '2025-01-31'
ORDER BY fecha;

-- 8. Top 5 productos por cantidad vendida.
SELECT p.nombre, SUM(d.cantidad) AS unidades_vendidas
FROM detalle_venta d
    JOIN productos p ON p.id_producto = d.id_producto
GROUP BY
    p.id_producto
ORDER BY unidades_vendidas DESC
LIMIT 5;

-- 9. Detectar registros relacionados sin detalle
SELECT v.id_venta, v.fecha
FROM ventas v
    LEFT JOIN detalle_venta d ON d.id_venta = v.id_venta
WHERE
    d.id_detalle IS NULL;

-- 10. Reporte final con alias legibles.
SELECT
    v.id_venta AS "No. Venta",
    v.fecha AS "Fecha",
    c.nombre AS "Cliente",
    ve.nombre AS "Vendedor",
    s.nombre AS "Sucursal",
    COUNT(d.id_detalle) AS "Lineas",
    SUM(d.cantidad) AS "Articulos",
    SUM(
        d.cantidad * d.precio_unitario
    ) AS "Total (Q)"
FROM
    ventas v
    JOIN clientes c ON c.id_cliente = v.id_cliente
    JOIN vendedores ve ON ve.id_vendedor = v.id_vendedor
    JOIN sucursales s ON s.id_sucursal = ve.id_sucursal
    JOIN detalle_venta d ON d.id_venta = v.id_venta
GROUP BY
    v.id_venta
ORDER BY "Total (Q)" DESC;