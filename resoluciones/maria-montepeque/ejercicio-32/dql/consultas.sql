-- Ejercicio 32: Normalizacion Pedidos Restaurante

-- 1. Reconstruir una vista similar al archivo original usando JOIN
-- (una fila por cada plato de cada pedido, como quedaria "aplanado" el CSV original)
SELECT
    p.id_pedido,
    m.numero AS mesa,
    me.nombre AS mesero,
    pl.nombre AS plato,
    pl.categoria AS categoria,
    dp.precio_unitario AS precio,
    dp.cantidad AS cantidad,
    p.fecha_pedido AS fecha_pedido
FROM pedidos p
JOIN mesas m ON m.id_mesa = p.id_mesa
JOIN meseros me ON me.id_mesero = p.id_mesero
JOIN detalle_pedido dp ON dp.id_pedido = p.id_pedido
JOIN platos pl ON pl.id_plato = dp.id_plato
ORDER BY p.id_pedido;

-- 2. Listar entidades principales sin duplicados
SELECT DISTINCT numero FROM mesas;
SELECT DISTINCT nombre FROM meseros;
SELECT DISTINCT nombre, categoria FROM platos;

-- 3. Contar registros por categoria o estado (platos pedidos por categoria)
SELECT pl.categoria, COUNT(*) AS lineas_pedidas
FROM detalle_pedido dp
JOIN platos pl ON pl.id_plato = dp.id_plato
GROUP BY pl.categoria;

-- 4. Calcular un total por transaccion (pedido)
SELECT p.id_pedido, SUM(dp.cantidad * dp.precio_unitario) AS total_pedido
FROM pedidos p
JOIN detalle_pedido dp ON dp.id_pedido = p.id_pedido
GROUP BY p.id_pedido;

-- 5. Calcular promedio, minimo y maximo del total por pedido
SELECT
    AVG(total_pedido) AS promedio,
    MIN(total_pedido) AS minimo,
    MAX(total_pedido) AS maximo
FROM (
    SELECT p.id_pedido, SUM(dp.cantidad * dp.precio_unitario) AS total_pedido
    FROM pedidos p
    JOIN detalle_pedido dp ON dp.id_pedido = p.id_pedido
    GROUP BY p.id_pedido
);

-- 6. Buscar registros por texto con LIKE
SELECT * FROM platos WHERE nombre LIKE '%Pizza%';
SELECT * FROM mesas WHERE numero LIKE 'Mesa 4';

-- 7. Filtrar por fecha o rango numerico
SELECT * FROM pedidos WHERE fecha_pedido >= '2026-06-02';
SELECT * FROM platos WHERE precio BETWEEN 20 AND 60;

-- 8. Mostrar top 5 por cantidad o monto (platos con mas unidades pedidas)
SELECT pl.nombre, SUM(dp.cantidad) AS unidades_pedidas
FROM detalle_pedido dp
JOIN platos pl ON pl.id_plato = dp.id_plato
GROUP BY pl.nombre
ORDER BY unidades_pedidas DESC
LIMIT 5;

-- 9. Detectar registros relacionados sin detalle (mesas sin pedidos registrados)
SELECT m.id_mesa, m.numero
FROM mesas m
LEFT JOIN pedidos p ON p.id_mesa = m.id_mesa
WHERE p.id_pedido IS NULL;

-- 10. Reporte final con alias legibles
SELECT
    m.numero AS mesa,
    me.nombre AS mesero,
    pl.nombre AS plato,
    pl.categoria AS categoria,
    dp.cantidad AS cantidad_pedida,
    dp.precio_unitario AS precio_unitario,
    (dp.cantidad * dp.precio_unitario) AS subtotal_linea,
    p.fecha_pedido AS fecha_pedido
FROM pedidos p
JOIN mesas m ON m.id_mesa = p.id_mesa
JOIN meseros me ON me.id_mesero = p.id_mesero
JOIN detalle_pedido dp ON dp.id_pedido = p.id_pedido
JOIN platos pl ON pl.id_plato = dp.id_plato
ORDER BY p.id_pedido;
