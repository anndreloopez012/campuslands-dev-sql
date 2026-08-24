SELECT
    id_compra,
    id_cliente,
    id_producto,
    cantidad,
    fecha_compra
FROM compras;


SELECT
    id_compra,
    fecha_compra
FROM compras;

SELECT
    id_compra,
    id_cliente,
    cantidad,
    fecha_compra
FROM compras
WHERE fecha_compra >= '2026-02-15';

SELECT
    id_compra,
    id_cliente,
    fecha_compra
FROM compras
ORDER BY fecha_compra ASC;

SELECT
    id_compra,
    id_producto,
    cantidad,
    fecha_compra
FROM compras
ORDER BY cantidad DESC
LIMIT 5;

SELECT
    COUNT(*) AS total_compras
FROM compras;


SELECT
    ROUND(AVG(cantidad), 2) AS cantidad_promedio,
    MIN(cantidad) AS cantidad_minima,
    MAX(cantidad) AS cantidad_maxima
FROM compras;

SELECT
    id_producto,
    SUM(cantidad) AS unidades_vendidas
FROM compras
GROUP BY id_producto
ORDER BY unidades_vendidas DESC;


SELECT
    c.id_compra,
    cl.nombre_completo AS cliente,
    p.nombre AS producto,
    c.cantidad,
    c.fecha_compra
FROM compras AS c
JOIN clientes AS cl
    ON c.id_cliente = cl.id_cliente
JOIN productos AS p
    ON c.id_producto = p.id_producto;

SELECT
    id_compra,
    id_producto,
    cantidad,
    fecha_compra
FROM compras
WHERE cantidad >= 2
ORDER BY fecha_compra DESC
LIMIT 5;

SELECT
    c.id_compra AS "ID Compra",
    cl.nombre_completo AS "Cliente",
    p.nombre AS "Producto",
    cat.nombre AS "Categoria",
    c.cantidad AS "Cantidad",
    p.precio AS "Precio Unitario",
    ROUND(c.cantidad * p.precio, 2) AS "Total Compra",
    c.fecha_compra AS "Fecha de Compra"
FROM compras AS c
JOIN clientes AS cl
    ON c.id_cliente = cl.id_cliente
JOIN productos AS p
    ON c.id_producto = p.id_producto
JOIN categorias AS cat
    ON p.id_categoria = cat.id_categoria
ORDER BY c.fecha_compra;


SELECT
    p.nombre AS producto,
    p.stock AS stock_actual,
    COALESCE(SUM(c.cantidad), 0) AS unidades_vendidas,
    CASE
        WHEN p.stock <= 10 THEN 'REABASTECER'
        WHEN COALESCE(SUM(c.cantidad), 0) >= 4 THEN 'MONITOREAR DEMANDA'
        ELSE 'STOCK NORMAL'
    END AS decision
FROM productos AS p
LEFT JOIN compras AS c
    ON p.id_producto = c.id_producto
GROUP BY
    p.id_producto,
    p.nombre,
    p.stock
ORDER BY unidades_vendidas DESC;