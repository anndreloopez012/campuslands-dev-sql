.headers on .mode column

-- Ejercicio 04: Restaurante Campus
SELECT * FROM pedidos;

SELECT id_pedido, fecha_pedido FROM pedidos;

SELECT id_pedido, fecha_pedido, estado
FROM pedidos
WHERE
    fecha_pedido >= '2025-06-02';

SELECT id_pedido, fecha_pedido, estado
FROM pedidos
ORDER BY fecha_pedido DESC;

SELECT p.nombre, SUM(d.cantidad) AS unidades_vendidas
FROM detalle_pedido d
    JOIN platos p ON p.id_plato = d.id_plato
GROUP BY
    p.id_plato,
    p.nombre
ORDER BY unidades_vendidas DESC
LIMIT 5;

SELECT COUNT(*) AS total_pedidos FROM pedidos;

SELECT
    ROUND(AVG(precio), 2) AS precio_promedio,
    MIN(precio) AS precio_minimo,
    MAX(precio) AS precio_maximo
FROM platos;

SELECT id_mesa, COUNT(*) AS cantidad_pedidos
FROM pedidos
GROUP BY
    id_mesa
ORDER BY cantidad_pedidos DESC;

SELECT ped.id_pedido, pl.nombre AS plato, d.cantidad, d.precio_unitario
FROM
    detalle_pedido d
    JOIN pedidos ped ON ped.id_pedido = d.id_pedido
    JOIN platos pl ON pl.id_plato = d.id_plato
ORDER BY ped.id_pedido;

SELECT nombre, precio
FROM platos
WHERE
    categoria = 'fuerte'
ORDER BY precio DESC
LIMIT 3;

SELECT
    d.id_pedido AS "Pedido",
    SUM(
        d.cantidad * d.precio_unitario
    ) AS "Total a pagar (Q)"
FROM detalle_pedido d
GROUP BY
    d.id_pedido
ORDER BY "Total a pagar (Q)" DESC;

SELECT
    pl.nombre AS plato,
    pl.categoria AS categoria,
    SUM(d.cantidad) AS unidades,
    SUM(
        d.cantidad * d.precio_unitario
    ) AS ingreso_total
FROM detalle_pedido d
    JOIN platos pl ON pl.id_plato = d.id_plato
GROUP BY
    pl.id_plato,
    pl.nombre,
    pl.categoria
ORDER BY ingreso_total DESC;