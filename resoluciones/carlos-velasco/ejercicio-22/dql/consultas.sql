PRAGMA foreign_keys = ON;

-- 1. LISTAR TODOS LOS PEDIDOS

SELECT
    id_pedido,
    id_cliente,
    id_restaurante,
    id_repartidor,
    fecha_pedido,
    estado,
    total,
    tiempo_estimado_min
FROM pedidos;

-- 2. DOS COLUMNAS RELEVANTES

SELECT
    id_pedido,
    estado
FROM pedidos;

-- 3. FILTRAR POR CONDICION NUMERICA

SELECT
    id_pedido,
    total,
    estado
FROM pedidos
WHERE total > 100;

-- 4. ORDENAR POR FECHA

SELECT
    id_pedido,
    fecha_pedido,
    total
FROM pedidos
ORDER BY fecha_pedido DESC;

-- 5. CINCO PEDIDOS DE MAYOR VALOR

SELECT
    id_pedido,
    id_restaurante,
    total
FROM pedidos
ORDER BY total DESC
LIMIT 5;

-- 6. CONTAR PEDIDOS

SELECT
    COUNT(*) AS total_pedidos
FROM pedidos;

-- 7. ESTADISTICAS DEL TOTAL

SELECT
    ROUND(AVG(total), 2) AS promedio_pedido,
    MIN(total) AS pedido_minimo,
    MAX(total) AS pedido_maximo
FROM pedidos;

-- 8. AGRUPAR PEDIDOS POR ESTADO

SELECT
    estado,
    COUNT(*) AS cantidad_pedidos
FROM pedidos
GROUP BY estado
ORDER BY cantidad_pedidos DESC;

-- 9. RELACIONAR CLIENTES, RESTAURANTES Y PEDIDOS

SELECT
    c.nombre_completo AS cliente,
    r.nombre AS restaurante,
    p.id_pedido,
    p.estado,
    p.total
FROM pedidos AS p
INNER JOIN clientes AS c
    ON c.id_cliente = p.id_cliente
INNER JOIN restaurantes AS r
    ON r.id_restaurante = p.id_restaurante
ORDER BY p.fecha_pedido;

-- 10. WHERE, ORDER BY Y LIMIT

SELECT
    id_pedido,
    estado,
    total,
    tiempo_estimado_min
FROM pedidos
WHERE estado IN ('PENDIENTE', 'PREPARANDO', 'EN_CAMINO')
ORDER BY total DESC
LIMIT 5;

-- 11. REPORTE CON ALIAS LEGIBLES

SELECT
    p.id_pedido AS "Numero de pedido",
    c.nombre_completo AS "Cliente",
    r.nombre AS "Restaurante",
    d.nombre_completo AS "Repartidor",
    p.fecha_pedido AS "Fecha del pedido",
    p.estado AS "Estado",
    p.total AS "Total",
    p.tiempo_estimado_min AS "Tiempo estimado (min)"
FROM pedidos AS p
INNER JOIN clientes AS c
    ON c.id_cliente = p.id_cliente
INNER JOIN restaurantes AS r
    ON r.id_restaurante = p.id_restaurante
INNER JOIN repartidores AS d
    ON d.id_repartidor = p.id_repartidor
ORDER BY p.fecha_pedido DESC;

-- 12. DECISION DE NEGOCIO: RESTAURANTES CON MAYOR DEMANDA

SELECT
    r.id_restaurante,
    r.nombre,
    r.categoria,
    COUNT(p.id_pedido) AS cantidad_pedidos,
    ROUND(AVG(p.total), 2) AS ticket_promedio
FROM restaurantes AS r
LEFT JOIN pedidos AS p
    ON p.id_restaurante = r.id_restaurante
GROUP BY
    r.id_restaurante,
    r.nombre,
    r.categoria
HAVING COUNT(p.id_pedido) > 0
ORDER BY cantidad_pedidos DESC, ticket_promedio DESC;