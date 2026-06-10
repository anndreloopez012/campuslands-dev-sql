.headers on
.mode column
-- Ejercicio 32: Normalizacion Pedidos Restaurante

-- 1. Reconstruir una vista parecida al CSV original usando JOIN.
SELECT
    p.id_pedido,
    'Mesa ' || m.numero AS mesa,
    me.nombre AS mesero,
    group_concat(pl.nombre, '|') AS platos,
    group_concat(c.nombre, '|') AS categorias,
    group_concat(pl.precio, '|') AS precios,
    group_concat(d.cantidad, '|') AS cantidades,
    p.fecha_pedido
FROM
    pedido p
    JOIN mesa m ON m.id_mesa = p.id_mesa
    JOIN mesero me ON me.id_mesero = p.id_mesero
    JOIN detalle_pedido d ON d.id_pedido = p.id_pedido
    JOIN plato pl ON pl.id_plato = d.id_plato
    JOIN categoria c ON c.id_categoria = pl.id_categoria
GROUP BY
    p.id_pedido
ORDER BY p.id_pedido;

-- 2. Listar entidades principales sin duplicados.
SELECT id_mesero, nombre FROM mesero ORDER BY nombre;

-- 3. Contar platos por categoria.
SELECT c.nombre AS categoria, COUNT(*) AS total_platos
FROM plato pl
    JOIN categoria c ON c.id_categoria = pl.id_categoria
GROUP BY
    c.nombre
ORDER BY total_platos DESC, categoria;

-- 4. Calcular el total por transaccion (pedido).
SELECT p.id_pedido, SUM(pl.precio * d.cantidad) AS total
FROM
    pedido p
    JOIN detalle_pedido d ON d.id_pedido = p.id_pedido
    JOIN plato pl ON pl.id_plato = d.id_plato
GROUP BY
    p.id_pedido
ORDER BY total DESC;

-- 5. Promedio, minimo y maximo del total de los pedidos.
SELECT
    ROUND(AVG(total), 2) AS promedio_pedido,
    MIN(total) AS minimo_pedido,
    MAX(total) AS maximo_pedido
FROM (
        SELECT p.id_pedido, SUM(pl.precio * d.cantidad) AS total
        FROM
            pedido p
            JOIN detalle_pedido d ON d.id_pedido = p.id_pedido
            JOIN plato pl ON pl.id_plato = d.id_plato
        GROUP BY
            p.id_pedido
    );

-- 6. Buscar platos cuyo nombre empieza con 'P' (LIKE).
SELECT nombre, precio
FROM plato
WHERE
    nombre LIKE 'P%'
ORDER BY nombre;

-- 7. Filtrar pedidos por rango de fechas.
SELECT id_pedido, fecha_pedido
FROM pedido
WHERE
    fecha_pedido BETWEEN '2026-06-01' AND '2026-06-02'
ORDER BY fecha_pedido, id_pedido;

-- 8. Top 5 platos mas vendidos por unidades.
SELECT pl.nombre, SUM(d.cantidad) AS unidades
FROM detalle_pedido d
    JOIN plato pl ON pl.id_plato = d.id_plato
GROUP BY
    pl.nombre
ORDER BY unidades DESC, pl.nombre
LIMIT 5;

-- 9. Detectar pedidos sin detalle (cabecera sin lineas) con LEFT JOIN.
SELECT p.id_pedido, p.fecha_pedido
FROM pedido p
    LEFT JOIN detalle_pedido d ON d.id_pedido = p.id_pedido
WHERE
    d.id_pedido IS NULL
ORDER BY p.id_pedido;

-- 10. Reporte final con alias legibles.
SELECT
    p.id_pedido AS "No Pedido",
    p.fecha_pedido AS "Fecha",
    'Mesa ' || m.numero AS "Mesa",
    me.nombre AS "Atendido por",
    COUNT(d.id_plato) AS "Lineas",
    COALESCE(SUM(d.cantidad), 0) AS "Unidades",
    COALESCE(
        SUM(pl.precio * d.cantidad),
        0
    ) AS "Total Q"
FROM
    pedido p
    JOIN mesa m ON m.id_mesa = p.id_mesa
    JOIN mesero me ON me.id_mesero = p.id_mesero
    LEFT JOIN detalle_pedido d ON d.id_pedido = p.id_pedido
    LEFT JOIN plato pl ON pl.id_plato = d.id_plato
GROUP BY
    p.id_pedido
ORDER BY p.id_pedido;