SELECT
    id_pedido,
    id_mesa,
    fecha_pedido,
    estado
FROM pedidos;

SELECT
    id_pedido,
    fecha_pedido
FROM pedidos;

SELECT
    id_pedido,
    id_mesa,
    fecha_pedido,
    estado
FROM pedidos
WHERE id_mesa >= 3;

SELECT
    id_pedido,
    id_mesa,
    fecha_pedido,
    estado
FROM pedidos
ORDER BY fecha_pedido ASC;

SELECT
    p.id_plato,
    p.nombre AS plato,
    SUM(d.cantidad) AS unidades_vendidas
FROM platos AS p
JOIN detalle_pedido AS d
    ON p.id_plato = d.id_plato
GROUP BY p.id_plato, p.nombre
ORDER BY unidades_vendidas DESC
LIMIT 5;

SELECT COUNT(*) AS total_pedidos
FROM pedidos;

SELECT
    ROUND(AVG(precio_unitario), 2) AS precio_promedio,
    MIN(precio_unitario) AS precio_minimo,
    MAX(precio_unitario) AS precio_maximo
FROM detalle_pedido;

SELECT
    estado,
    COUNT(*) AS cantidad_pedidos
FROM pedidos
GROUP BY estado;

SELECT
    pe.id_pedido,
    m.numero_mesa,
    pe.fecha_pedido,
    pe.estado
FROM pedidos AS pe
JOIN mesas AS m
    ON pe.id_mesa = m.id_mesa;

SELECT
    id_pedido,
    id_mesa,
    fecha_pedido,
    estado
FROM pedidos
WHERE estado IN ('ABIERTO', 'SERVIDO')
ORDER BY fecha_pedido DESC
LIMIT 5;

SELECT
    pe.id_pedido AS "Pedido",
    m.numero_mesa AS "Mesa",
    pe.fecha_pedido AS "Fecha",
    pe.estado AS "Estado",
    ROUND(SUM(d.cantidad * d.precio_unitario), 2) AS "Total"
FROM pedidos AS pe
JOIN mesas AS m
    ON pe.id_mesa = m.id_mesa
JOIN detalle_pedido AS d
    ON pe.id_pedido = d.id_pedido
GROUP BY pe.id_pedido, m.numero_mesa, pe.fecha_pedido, pe.estado
ORDER BY pe.fecha_pedido;

SELECT
    p.nombre AS plato,
    p.disponible AS disponible,
    COALESCE(SUM(d.cantidad), 0) AS unidades_vendidas,
    CASE
        WHEN p.disponible = 0 THEN 'NO DISPONIBLE'
        WHEN COALESCE(SUM(d.cantidad), 0) >= 5 THEN 'AUMENTAR PREPARACION'
        WHEN COALESCE(SUM(d.cantidad), 0) >= 3 THEN 'MANTENER INVENTARIO'
        ELSE 'BAJA DEMANDA'
    END AS decision
FROM platos AS p
LEFT JOIN detalle_pedido AS d
    ON p.id_plato = d.id_plato
GROUP BY p.id_plato, p.nombre, p.disponible
ORDER BY unidades_vendidas DESC;