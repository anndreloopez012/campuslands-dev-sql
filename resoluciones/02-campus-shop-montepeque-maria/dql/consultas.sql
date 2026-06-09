.headers on .mode column

SELECT * FROM productos;

SELECT nombre, precio FROM productos;

SELECT * FROM pedidos WHERE fecha >= '2025-05-01';

SELECT nombre, precio FROM productos ORDER BY precio DESC;

SELECT nombre, stock FROM productos ORDER BY stock DESC LIMIT 5;

SELECT COUNT(*) AS total_productos FROM productos;

SELECT
    AVG(precio) AS precio_promedio,
    MIN(precio) AS mas_barato,
    MAX(precio) AS mas_caro
FROM productos;

SELECT
    c.nombre AS categoria,
    COUNT(p.id) AS cantidad_productos
FROM categorias c
    JOIN productos p ON p.categoria_id = c.id
GROUP BY
    c.nombre;

SELECT p.nombre AS producto, c.nombre AS categoria, p.precio
FROM productos p
    JOIN categorias c ON p.categoria_id = c.id;

SELECT nombre, precio
FROM productos
WHERE
    precio > 30000
ORDER BY precio ASC
LIMIT 3;

SELECT
    pe.id AS numero_pedido,
    cl.nombre AS cliente,
    SUM(
        dp.cantidad * dp.precio_unitario
    ) AS total_pedido
FROM
    pedidos pe
    JOIN clientes cl ON pe.cliente_id = cl.id
    JOIN detalle_pedidos dp ON dp.pedido_id = pe.id
GROUP BY
    pe.id,
    cl.nombre;

SELECT p.nombre AS producto, SUM(dp.cantidad) AS unidades_vendidas
FROM
    detalle_pedidos dp
    JOIN productos p ON dp.producto_id = p.id
GROUP BY
    p.nombre
ORDER BY unidades_vendidas DESC
LIMIT 5;