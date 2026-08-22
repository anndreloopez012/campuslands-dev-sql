SELECT
    id_venta,
    id_cliente,
    id_vendedor,
    fecha_venta,
    total,
    estado
FROM ventas;

SELECT
    fecha_venta,
    total
FROM ventas;

SELECT
    id_venta,
    fecha_venta,
    total,
    estado
FROM ventas
WHERE total >= 800;

SELECT
    id_venta,
    fecha_venta,
    total
FROM ventas
ORDER BY fecha_venta ASC;

SELECT
    id_venta,
    fecha_venta,
    total
FROM ventas
WHERE estado = 'completada'
ORDER BY total DESC
LIMIT 5;

SELECT COUNT(*) AS total_ventas
FROM ventas;

SELECT
    AVG(total) AS promedio_ventas,
    MIN(total) AS venta_minima,
    MAX(total) AS venta_maxima
FROM ventas;

SELECT
    estado,
    COUNT(*) AS cantidad_ventas,
    SUM(total) AS total_estado
FROM ventas
GROUP BY estado
ORDER BY total_estado DESC;

SELECT
    v.id_venta,
    c.nombre_completo AS cliente,
    ven.nombre_completo AS vendedor,
    v.total,
    v.fecha_venta
FROM ventas AS v
INNER JOIN clientes AS c
    ON c.id_cliente = v.id_cliente
INNER JOIN vendedores AS ven
    ON ven.id_vendedor = v.id_vendedor
ORDER BY v.fecha_venta DESC;

SELECT
    id_venta,
    fecha_venta,
    total
FROM ventas
WHERE total >= 500
ORDER BY total DESC
LIMIT 5;

SELECT
    id_venta AS "Venta",
    cliente AS "Cliente",
    vendedor AS "Vendedor",
    total AS "Total",
    estado AS "Estado"
FROM vw_resumen_ventas
ORDER BY total DESC;

SELECT
    vendedor AS "Vendedor",
    cantidad_ventas AS "Ventas Completadas",
    total_vendido AS "Total Vendido",
    comision_generada AS "Comision Generada"
FROM vw_ventas_vendedores
ORDER BY total_vendido DESC;

SELECT
    id_venta AS "Venta",
    cliente AS "Cliente",
    total_venta AS "Total Venta",
    total_pagado AS "Total Pagado",
    saldo_pendiente AS "Saldo Pendiente"
FROM vw_estado_pagos
WHERE saldo_pendiente > 0
ORDER BY saldo_pendiente DESC;

SELECT
    vendedor AS "Vendedor",
    cantidad_ventas AS "Ventas",
    total_vendido AS "Total Vendido",
    CASE
        WHEN total_vendido >= 2000 THEN 'Alto rendimiento'
        WHEN total_vendido >= 1000 THEN 'Rendimiento medio'
        ELSE 'Requiere seguimiento'
    END AS "Nivel de rendimiento"
FROM vw_ventas_vendedores
ORDER BY total_vendido DESC;

SELECT
    c.nombre_completo AS cliente,
    COUNT(v.id_venta) AS cantidad_compras,
    SUM(v.total) AS total_comprado,
    AVG(v.total) AS promedio_compra
FROM clientes AS c
INNER JOIN ventas AS v
    ON v.id_cliente = c.id_cliente
WHERE v.estado = 'completada'
GROUP BY c.id_cliente, c.nombre_completo
ORDER BY total_comprado DESC;