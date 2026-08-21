.headers on
.mode column

PRAGMA foreign_keys = ON;

-- 1. Listar todos los registros principales de la entidad central.

SELECT
    id_factura,
    numero_factura,
    id_cliente,
    fecha,
    impuesto,
    estado
FROM facturas;

-- 2. Mostrar dos columnas relevantes de la entidad central.

SELECT
    numero_factura,
    fecha
FROM facturas;

-- 3. Filtrar registros por una condicion de fecha.

SELECT
    numero_factura,
    fecha,
    estado
FROM facturas
WHERE fecha >= '2026-08-03';

-- 4. Ordenar resultados por fecha.

SELECT
    numero_factura,
    fecha,
    estado
FROM facturas
ORDER BY fecha DESC;

-- 5. Mostrar los 5 registros mas importantes segun el subtotal.

SELECT
    f.numero_factura,
    SUM(df.cantidad * df.precio_unitario) AS subtotal
FROM facturas AS f
INNER JOIN detalle_factura AS df
    ON df.id_factura = f.id_factura
GROUP BY f.id_factura, f.numero_factura
ORDER BY subtotal DESC
LIMIT 5;

-- 6. Contar registros totales.

SELECT
    COUNT(*) AS total_facturas
FROM facturas;

-- 7. Calcular promedio, minimo y maximo del precio de productos.

SELECT
    ROUND(AVG(precio), 2) AS precio_promedio,
    MIN(precio) AS precio_minimo,
    MAX(precio) AS precio_maximo
FROM productos;

-- 8. Agrupar facturas por estado.

SELECT
    estado,
    COUNT(*) AS cantidad_facturas
FROM facturas
GROUP BY estado
ORDER BY cantidad_facturas DESC;

-- 9. Relacionar clientes, facturas y detalle de factura.

SELECT
    c.nombre_completo,
    f.numero_factura,
    df.cantidad,
    df.precio_unitario
FROM clientes AS c
INNER JOIN facturas AS f
    ON f.id_cliente = c.id_cliente
INNER JOIN detalle_factura AS df
    ON df.id_factura = f.id_factura
ORDER BY c.nombre_completo;

-- 10. Consulta con WHERE, ORDER BY y LIMIT.

SELECT
    numero_factura,
    fecha,
    estado
FROM facturas
WHERE estado = 'PAGADA'
ORDER BY fecha DESC
LIMIT 3;

-- 11. Reporte con alias legibles.

SELECT
    f.numero_factura AS "Numero de factura",
    c.nombre_completo AS "Cliente",
    f.fecha AS "Fecha de emision",
    ROUND(SUM(df.cantidad * df.precio_unitario), 2) AS "Subtotal",
    ROUND(
        SUM(df.cantidad * df.precio_unitario) * f.impuesto,
        2
    ) AS "Impuesto",
    ROUND(
        SUM(df.cantidad * df.precio_unitario) * (1 + f.impuesto),
        2
    ) AS "Total"
FROM facturas AS f
INNER JOIN clientes AS c
    ON c.id_cliente = f.id_cliente
INNER JOIN detalle_factura AS df
    ON df.id_factura = f.id_factura
GROUP BY
    f.id_factura,
    f.numero_factura,
    c.nombre_completo,
    f.fecha,
    f.impuesto
ORDER BY f.fecha;

-- 12. Consulta para apoyar una decision de negocio.

SELECT
    p.nombre AS producto,
    SUM(df.cantidad) AS unidades_vendidas,
    ROUND(SUM(df.cantidad * df.precio_unitario), 2) AS ingresos_generados,
    p.stock AS stock_actual,
    CASE
        WHEN p.stock < 20 THEN 'REABASTECER'
        WHEN SUM(df.cantidad) >= 3 THEN 'PRIORIZAR'
        ELSE 'MANTENER'
    END AS decision
FROM productos AS p
INNER JOIN detalle_factura AS df
    ON df.id_producto = p.id_producto
GROUP BY
    p.id_producto,
    p.nombre,
    p.stock
ORDER BY ingresos_generados DESC;