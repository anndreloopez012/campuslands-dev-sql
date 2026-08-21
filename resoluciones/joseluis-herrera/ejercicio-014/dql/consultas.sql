SELECT
    id_orden,
    id_comprador,
    id_producto,
    fecha,
    cantidad,
    precio_unitario,
    estado,
    cantidad * precio_unitario AS total
FROM ordenes;

SELECT
    id_orden,
    fecha
FROM ordenes;

SELECT
    id_orden,
    fecha,
    cantidad,
    precio_unitario
FROM ordenes
WHERE cantidad >= 2;

SELECT
    id_orden,
    fecha,
    estado
FROM ordenes
ORDER BY fecha DESC;

SELECT
    id_orden,
    cantidad * precio_unitario AS total_orden
FROM ordenes
ORDER BY total_orden DESC
LIMIT 5;

SELECT COUNT(*) AS total_ordenes
FROM ordenes;

SELECT
    AVG(precio_unitario) AS precio_promedio,
    MIN(precio_unitario) AS precio_minimo,
    MAX(precio_unitario) AS precio_maximo
FROM ordenes;

SELECT
    estado,
    COUNT(*) AS cantidad_ordenes
FROM ordenes
GROUP BY estado;

SELECT
    o.id_orden,
    c.nombre AS comprador,
    p.nombre AS producto,
    o.fecha,
    o.cantidad,
    o.precio_unitario,
    o.cantidad * o.precio_unitario AS total
FROM ordenes AS o
JOIN compradores AS c
    ON o.id_comprador = c.id_comprador
JOIN productos AS p
    ON o.id_producto = p.id_producto;

SELECT
    o.id_orden,
    c.nombre AS comprador,
    o.fecha,
    o.cantidad * o.precio_unitario AS total
FROM ordenes AS o
JOIN compradores AS c
    ON o.id_comprador = c.id_comprador
WHERE o.estado IN ('pagada', 'enviada', 'entregada')
ORDER BY total DESC
LIMIT 5;

SELECT
    v.nombre AS vendedor,
    COUNT(o.id_orden) AS total_ordenes,
    SUM(o.cantidad * o.precio_unitario) AS ventas_totales
FROM vendedores AS v
JOIN productos AS p
    ON v.id_vendedor = p.id_vendedor
JOIN ordenes AS o
    ON p.id_producto = o.id_producto
GROUP BY v.id_vendedor, v.nombre
ORDER BY ventas_totales DESC;

SELECT
    p.nombre AS producto,
    p.stock AS stock_actual,
    CASE
        WHEN p.stock = 0 THEN 'Sin stock'
        WHEN p.stock <= 10 THEN 'Stock bajo'
        ELSE 'Stock suficiente'
    END AS decision_inventario
FROM productos AS p
ORDER BY p.stock ASC;

SELECT
    v.nombre AS vendedor,
    COUNT(o.id_orden) AS ordenes,
    SUM(o.cantidad * o.precio_unitario) AS ventas_totales,
    CASE
        WHEN SUM(o.cantidad * o.precio_unitario) >= 4000
            THEN 'Vendedor de alto rendimiento'
        WHEN SUM(o.cantidad * o.precio_unitario) >= 2000
            THEN 'Vendedor de rendimiento medio'
        ELSE 'Vendedor de bajo rendimiento'
    END AS clasificacion
FROM vendedores AS v
JOIN productos AS p
    ON v.id_vendedor = p.id_vendedor
JOIN ordenes AS o
    ON p.id_producto = o.id_producto
GROUP BY v.id_vendedor, v.nombre
ORDER BY ventas_totales DESC;