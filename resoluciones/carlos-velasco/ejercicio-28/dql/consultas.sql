PRAGMA foreign_keys = ON;

-- 1. LISTAR TODOS LOS REGISTROS PRINCIPALES

SELECT
    id_venta,
    id_cliente,
    id_vendedor,
    total,
    fecha_venta,
    estado
FROM ventas;

-- 2. MOSTRAR DOS COLUMNAS RELEVANTES

SELECT
    id_venta,
    total
FROM ventas;

-- 3. FILTRAR POR CONDICION NUMERICA

SELECT
    id_venta,
    id_cliente,
    total,
    fecha_venta
FROM ventas
WHERE total >= 1000.00;

-- 4. ORDENAR POR FECHA

SELECT
    id_venta,
    total,
    fecha_venta
FROM ventas
ORDER BY fecha_venta ASC;

-- 5. MOSTRAR LAS 5 VENTAS MAS IMPORTANTES

SELECT
    id_venta,
    id_cliente,
    id_vendedor,
    total,
    fecha_venta
FROM ventas
ORDER BY total DESC
LIMIT 5;

-- 6. CONTAR REGISTROS TOTALES

SELECT
    COUNT(*) AS total_ventas
FROM ventas;

-- 7. CALCULAR PROMEDIO, MINIMO Y MAXIMO

SELECT
    AVG(total) AS venta_promedio,
    MIN(total) AS venta_minima,
    MAX(total) AS venta_maxima
FROM ventas;

-- 8. AGRUPAR REGISTROS

SELECT
    id_vendedor,
    COUNT(*) AS cantidad_ventas,
    SUM(total) AS monto_total
FROM ventas
GROUP BY id_vendedor
ORDER BY monto_total DESC;

-- 9. RELACIONAR TABLAS CON JOIN

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
ORDER BY v.fecha_venta ASC;

-- 10. WHERE + ORDER BY + LIMIT

SELECT
    id_venta,
    id_cliente,
    total,
    fecha_venta
FROM ventas
WHERE estado = 'Completada'
ORDER BY total DESC
LIMIT 5;

-- 11. REPORTE CON ALIAS LEGIBLES

SELECT
    v.id_venta AS 'ID Venta',
    c.nombre_completo AS 'Cliente',
    ven.nombre_completo AS 'Vendedor',
    v.total AS 'Total Venta',
    v.fecha_venta AS 'Fecha Venta',
    v.estado AS 'Estado'
FROM ventas AS v
INNER JOIN clientes AS c
    ON c.id_cliente = v.id_cliente
INNER JOIN vendedores AS ven
    ON ven.id_vendedor = v.id_vendedor
ORDER BY v.fecha_venta ASC;

-- 12. DECISION DE NEGOCIO

SELECT
    ven.nombre_completo AS vendedor,
    COUNT(v.id_venta) AS total_ventas,
    SUM(v.total) AS monto_vendido,
    CASE
        WHEN SUM(v.total) >= 3000 THEN 'Alto rendimiento'
        WHEN SUM(v.total) >= 1500 THEN 'Rendimiento medio'
        ELSE 'Bajo rendimiento'
    END AS nivel_rendimiento,
    CASE
        WHEN SUM(v.total) >= 3000 THEN 'Mantener estrategia comercial'
        WHEN SUM(v.total) >= 1500 THEN 'Incrementar seguimiento'
        ELSE 'Revisar estrategia de ventas'
    END AS decision
FROM vendedores AS ven
LEFT JOIN ventas AS v
    ON v.id_vendedor = ven.id_vendedor
    AND v.estado = 'Completada'
GROUP BY
    ven.id_vendedor,
    ven.nombre_completo
ORDER BY monto_vendido DESC;

-- VISTAS PARA REPORTES

SELECT
    id_venta,
    cliente,
    vendedor,
    total,
    fecha_venta,
    estado
FROM vw_resumen_ventas
ORDER BY fecha_venta ASC;

SELECT
    id_venta,
    cliente,
    total_venta,
    total_pagado,
    saldo_pendiente
FROM vw_estado_pagos
ORDER BY saldo_pendiente DESC;

SELECT
    id_vendedor,
    vendedor,
    total_ventas,
    monto_vendido,
    ticket_promedio
FROM vw_ventas_vendedores
ORDER BY monto_vendido DESC;

-- REPORTE DE PAGOS POR METODO

SELECT
    metodo_pago AS 'Metodo de Pago',
    COUNT(*) AS 'Cantidad de Pagos',
    SUM(monto) AS 'Monto Total'
FROM pagos
WHERE estado = 'Confirmado'
GROUP BY metodo_pago
ORDER BY 'Monto Total' DESC;

-- REPORTE DE VENTAS PENDIENTES DE PAGO

SELECT
    r.id_venta AS 'ID Venta',
    r.cliente AS 'Cliente',
    r.total_venta AS 'Total Venta',
    r.total_pagado AS 'Total Pagado',
    r.saldo_pendiente AS 'Saldo Pendiente'
FROM vw_estado_pagos AS r
WHERE r.saldo_pendiente > 0
ORDER BY r.saldo_pendiente DESC;