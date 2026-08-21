PRAGMA foreign_keys = ON;

-- =========================================================
-- 1. Listar todos los registros principales
-- Entidad central: pedidos
-- =========================================================

SELECT
    id_pedido,
    id_mesa,
    fecha_pedido,
    estado
FROM pedidos;

-- =========================================================
-- 2. Mostrar solo dos columnas relevantes
-- =========================================================

SELECT
    fecha_pedido,
    estado
FROM pedidos;

-- =========================================================
-- 3. Filtrar por condición de fecha
-- Pedidos realizados desde el 5 de agosto.
-- =========================================================

SELECT
    id_pedido,
    id_mesa,
    fecha_pedido,
    estado
FROM pedidos
WHERE fecha_pedido >= '2026-08-05';

-- =========================================================
-- 4. Ordenar resultados por fecha
-- =========================================================

SELECT
    id_pedido,
    id_mesa,
    fecha_pedido,
    estado
FROM pedidos
ORDER BY fecha_pedido DESC;

-- =========================================================
-- 5. Top 5 platos según cantidad vendida
-- =========================================================

SELECT
    p.nombre,
    SUM(dp.cantidad) AS cantidad_vendida
FROM platos AS p
INNER JOIN detalle_pedido AS dp
    ON p.id_plato = dp.id_plato
GROUP BY
    p.id_plato,
    p.nombre
ORDER BY cantidad_vendida DESC
LIMIT 5;

-- =========================================================
-- 6. Contar registros totales
-- =========================================================

SELECT
    COUNT(*) AS total_pedidos
FROM pedidos;

-- =========================================================
-- 7. Promedio, mínimo y máximo del precio de los platos
-- =========================================================

SELECT
    ROUND(AVG(precio), 2) AS precio_promedio,
    MIN(precio) AS precio_minimo,
    MAX(precio) AS precio_maximo
FROM platos;

-- =========================================================
-- 8. Agrupar pedidos por estado
-- =========================================================

SELECT
    estado,
    COUNT(*) AS cantidad_pedidos
FROM pedidos
GROUP BY estado;

-- =========================================================
-- 9. Relacionar mínimo dos tablas con JOIN
-- =========================================================

SELECT
    pe.id_pedido,
    me.numero AS numero_mesa,
    pe.fecha_pedido,
    pe.estado
FROM pedidos AS pe
INNER JOIN mesas AS me
    ON pe.id_mesa = me.id_mesa;

-- =========================================================
-- 10. WHERE + ORDER BY + LIMIT
-- Últimos pedidos pagados.
-- =========================================================

SELECT
    id_pedido,
    id_mesa,
    fecha_pedido,
    estado
FROM pedidos
WHERE estado = 'PAGADO'
ORDER BY fecha_pedido DESC
LIMIT 5;

-- =========================================================
-- 11. Reporte con alias legibles
-- Detalle completo del consumo.
-- =========================================================

SELECT
    pe.id_pedido AS 'ID Pedido',
    me.numero AS 'Mesa',
    pl.nombre AS 'Plato',
    dp.cantidad AS 'Cantidad',
    dp.precio_unitario AS 'Precio Unitario',
    ROUND(dp.cantidad * dp.precio_unitario, 2) AS 'Subtotal',
    pe.fecha_pedido AS 'Fecha Pedido',
    pe.estado AS 'Estado'
FROM detalle_pedido AS dp
INNER JOIN pedidos AS pe
    ON dp.id_pedido = pe.id_pedido
INNER JOIN mesas AS me
    ON pe.id_mesa = me.id_mesa
INNER JOIN platos AS pl
    ON dp.id_plato = pl.id_plato
ORDER BY pe.fecha_pedido DESC;

-- =========================================================
-- 12. Consulta para apoyar una decisión de negocio
-- Identificar los platos más vendidos para priorizar
-- inventario y preparación.
-- =========================================================

SELECT
    pl.nombre AS 'Plato',
    SUM(dp.cantidad) AS 'Unidades Vendidas',
    ROUND(
        SUM(dp.cantidad * dp.precio_unitario),
        2
    ) AS 'Ingresos Generados',
    CASE
        WHEN SUM(dp.cantidad) >= 4
            THEN 'Priorizar preparacion e inventario'
        WHEN SUM(dp.cantidad) >= 2
            THEN 'Mantener disponibilidad'
        ELSE 'Evaluar demanda'
    END AS 'Decision'
FROM detalle_pedido AS dp
INNER JOIN platos AS pl
    ON dp.id_plato = pl.id_plato
GROUP BY
    pl.id_plato,
    pl.nombre
ORDER BY
    SUM(dp.cantidad) DESC;