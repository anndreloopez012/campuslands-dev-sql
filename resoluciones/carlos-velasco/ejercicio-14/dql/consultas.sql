PRAGMA foreign_keys = ON;

-- 1. LISTAR TODOS LOS REGISTROS DE LA ENTIDAD CENTRAL

SELECT
    id_orden,
    id_vendedor,
    id_producto,
    id_comprador,
    cantidad,
    precio_unitario,
    fecha_orden,
    estado
FROM ordenes;

-- 2. MOSTRAR DOS COLUMNAS RELEVANTES

SELECT
    fecha_orden,
    estado
FROM ordenes;

-- 3. FILTRAR ORDENES POR VALOR TOTAL

SELECT
    id_orden,
    cantidad,
    precio_unitario,
    cantidad * precio_unitario AS total_orden
FROM ordenes
WHERE cantidad * precio_unitario >= 1000
ORDER BY total_orden DESC;

-- 4. ORDENAR ORDENES POR FECHA

SELECT
    id_orden,
    fecha_orden,
    estado
FROM ordenes
ORDER BY fecha_orden DESC;

-- 5. CINCO ORDENES DE MAYOR VALOR

SELECT
    id_orden,
    cantidad,
    precio_unitario,
    cantidad * precio_unitario AS total_orden
FROM ordenes
ORDER BY total_orden DESC
LIMIT 5;

-- 6. CONTAR ORDENES TOTALES

SELECT
    COUNT(*) AS total_ordenes
FROM ordenes;

-- 7. PROMEDIO, MINIMO Y MAXIMO DEL VALOR DE LAS ORDENES

SELECT
    ROUND(AVG(cantidad * precio_unitario), 2) AS promedio_orden,
    MIN(cantidad * precio_unitario) AS orden_minima,
    MAX(cantidad * precio_unitario) AS orden_maxima
FROM ordenes;

-- 8. AGRUPAR VENTAS POR ESTADO

SELECT
    estado,
    COUNT(*) AS cantidad_ordenes,
    ROUND(SUM(cantidad * precio_unitario), 2) AS ventas_totales
FROM ordenes
GROUP BY estado
ORDER BY ventas_totales DESC;

-- 9. RELACIONAR VENDEDORES Y PRODUCTOS

SELECT
    v.nombre_completo,
    p.nombre,
    p.categoria,
    p.precio,
    p.stock
FROM vendedores AS v
INNER JOIN productos AS p
    ON p.id_vendedor = v.id_vendedor
ORDER BY v.nombre_completo ASC;

-- 10. WHERE, ORDER BY Y LIMIT

SELECT
    id_orden,
    id_vendedor,
    cantidad,
    precio_unitario,
    cantidad * precio_unitario AS total_orden
FROM ordenes
WHERE estado IN ('Pagada', 'Enviada', 'Entregada')
ORDER BY total_orden DESC
LIMIT 5;

-- 11. REPORTE CON ALIAS LEGIBLES

SELECT
    o.id_orden AS "Orden",
    v.nombre_completo AS "Vendedor",
    p.nombre AS "Producto",
    b.nombre_completo AS "Comprador",
    o.cantidad AS "Cantidad",
    o.precio_unitario AS "Precio Unitario",
    o.cantidad * o.precio_unitario AS "Total Venta",
    o.estado AS "Estado",
    o.fecha_orden AS "Fecha"
FROM ordenes AS o
INNER JOIN vendedores AS v
    ON v.id_vendedor = o.id_vendedor
INNER JOIN productos AS p
    ON p.id_producto = o.id_producto
INNER JOIN compradores AS b
    ON b.id_comprador = o.id_comprador
ORDER BY o.fecha_orden DESC;

-- 12. DECISION DE NEGOCIO: VENDEDORES CON MAYOR RENDIMIENTO

SELECT
    v.nombre_completo AS "Vendedor",
    COUNT(o.id_orden) AS "Ordenes",
    ROUND(COALESCE(SUM(o.cantidad * o.precio_unitario), 0), 2) AS "Ventas Totales",
    ROUND(COALESCE(AVG(o.cantidad * o.precio_unitario), 0), 2) AS "Venta Promedio",
    CASE
        WHEN SUM(o.cantidad * o.precio_unitario) >= 5000
            THEN 'Vendedor de alto rendimiento'
        WHEN SUM(o.cantidad * o.precio_unitario) >= 2500
            THEN 'Vendedor de rendimiento medio'
        ELSE 'Vendedor por debajo del objetivo'
    END AS "Clasificacion"
FROM vendedores AS v
LEFT JOIN ordenes AS o
    ON o.id_vendedor = v.id_vendedor
GROUP BY
    v.id_vendedor,
    v.nombre_completo
ORDER BY
    "Ventas Totales" DESC;