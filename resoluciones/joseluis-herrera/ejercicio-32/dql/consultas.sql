-- 1. Reconstruir una vista similar al archivo original

SELECT
    m.numero_mesa AS mesa,
    me.nombre_completo AS mesero,
    GROUP_CONCAT(p.nombre, ', ') AS platos,
    GROUP_CONCAT(c.nombre, ', ') AS categorias,
    GROUP_CONCAT(dp.precio_unitario, ', ') AS precios,
    GROUP_CONCAT(dp.cantidad, ', ') AS cantidades,
    pe.fecha_pedido
FROM pedidos pe
JOIN mesas m
    ON pe.id_mesa = m.id_mesa
JOIN meseros me
    ON pe.id_mesero = me.id_mesero
JOIN detalle_pedido dp
    ON pe.id_pedido = dp.id_pedido
JOIN platos p
    ON dp.id_plato = p.id_plato
JOIN categorias c
    ON p.id_categoria = c.id_categoria
GROUP BY pe.id_pedido
ORDER BY pe.fecha_pedido;

-- 2. Listar entidades principales sin duplicados

SELECT DISTINCT
    numero_mesa AS mesa
FROM mesas
ORDER BY numero_mesa;

SELECT DISTINCT
    nombre_completo AS mesero
FROM meseros
ORDER BY nombre_completo;

SELECT DISTINCT
    nombre AS categoria
FROM categorias
ORDER BY nombre;

-- 3. Contar registros por categoria

SELECT
    c.nombre AS categoria,
    COUNT(p.id_plato) AS cantidad_platos
FROM categorias c
LEFT JOIN platos p
    ON c.id_categoria = p.id_categoria
GROUP BY c.id_categoria, c.nombre
ORDER BY cantidad_platos DESC;

-- 4. Calcular un total por transaccion

SELECT
    pe.id_pedido,
    ROUND(SUM(dp.cantidad * dp.precio_unitario), 2) AS total_pedido
FROM pedidos pe
JOIN detalle_pedido dp
    ON pe.id_pedido = dp.id_pedido
GROUP BY pe.id_pedido
ORDER BY pe.id_pedido;

-- 5. Calcular promedio, minimo y maximo

SELECT
    ROUND(AVG(precio), 2) AS precio_promedio,
    MIN(precio) AS precio_minimo,
    MAX(precio) AS precio_maximo
FROM platos;

-- 6. Buscar registros por texto con LIKE

SELECT
    id_plato,
    nombre,
    precio
FROM platos
WHERE nombre LIKE '%hamburguesa%'
ORDER BY nombre;

-- 7. Filtrar por fecha y rango numerico

SELECT
    id_pedido,
    fecha_pedido,
    estado
FROM pedidos
WHERE date(fecha_pedido) BETWEEN '2026-08-01' AND '2026-08-05'
ORDER BY fecha_pedido;

SELECT
    id_plato,
    nombre,
    precio
FROM platos
WHERE precio BETWEEN 15000 AND 30000
ORDER BY precio;

-- 8. Top 5 por cantidad

SELECT
    p.nombre AS plato,
    SUM(dp.cantidad) AS unidades_vendidas
FROM detalle_pedido dp
JOIN platos p
    ON dp.id_plato = p.id_plato
GROUP BY p.id_plato, p.nombre
ORDER BY unidades_vendidas DESC
LIMIT 5;

-- 9. Detectar pedidos relacionados sin detalle

SELECT
    pe.id_pedido,
    pe.fecha_pedido,
    pe.estado
FROM pedidos pe
LEFT JOIN detalle_pedido dp
    ON pe.id_pedido = dp.id_pedido
WHERE dp.id_pedido IS NULL;

-- 10. Reporte final

SELECT
    pe.id_pedido AS pedido,
    m.numero_mesa AS mesa,
    me.nombre_completo AS mesero,
    pe.fecha_pedido AS fecha,
    pe.estado AS estado_pedido,
    COUNT(dp.id_plato) AS tipos_de_plato,
    SUM(dp.cantidad) AS unidades,
    ROUND(SUM(dp.cantidad * dp.precio_unitario), 2) AS total
FROM pedidos pe
JOIN mesas m
    ON pe.id_mesa = m.id_mesa
JOIN meseros me
    ON pe.id_mesero = me.id_mesero
JOIN detalle_pedido dp
    ON pe.id_pedido = dp.id_pedido
GROUP BY
    pe.id_pedido,
    m.numero_mesa,
    me.nombre_completo,
    pe.fecha_pedido,
    pe.estado
ORDER BY pe.fecha_pedido;

-- Consulta adicional para validar pedidos por estado

SELECT
    estado,
    COUNT(*) AS cantidad_pedidos
FROM pedidos
GROUP BY estado
ORDER BY cantidad_pedidos DESC;