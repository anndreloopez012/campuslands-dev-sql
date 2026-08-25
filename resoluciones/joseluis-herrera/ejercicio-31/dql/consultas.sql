-- 1. RECONSTRUIR UNA VISTA SIMILAR AL ARCHIVO ORIGINAL

SELECT
    v.id_venta,
    c.nombre_completo AS cliente_nombre,
    c.email AS cliente_email,
    GROUP_CONCAT(p.nombre_producto, ', ') AS productos_comprados,
    GROUP_CONCAT(d.precio_unitario, ', ') AS precios,
    GROUP_CONCAT(d.cantidad, ', ') AS cantidades,
    ve.nombre_completo AS vendedor,
    s.nombre_sucursal AS sucursal,
    v.fecha_venta
FROM ventas v
JOIN clientes c
    ON c.id_cliente = v.id_cliente
JOIN vendedores ve
    ON ve.id_vendedor = v.id_vendedor
JOIN sucursales s
    ON s.id_sucursal = v.id_sucursal
JOIN detalle_venta d
    ON d.id_venta = v.id_venta
JOIN productos p
    ON p.id_producto = d.id_producto
GROUP BY
    v.id_venta,
    c.nombre_completo,
    c.email,
    ve.nombre_completo,
    s.nombre_sucursal,
    v.fecha_venta
ORDER BY v.id_venta;

-- 2. ENTIDADES PRINCIPALES SIN DUPLICADOS

SELECT DISTINCT
    c.id_cliente,
    c.nombre_completo,
    c.email
FROM clientes c
ORDER BY c.nombre_completo;

-- 3. CONTAR REGISTROS POR CATEGORIA

SELECT
    categoria,
    COUNT(*) AS cantidad_productos
FROM productos
GROUP BY categoria
ORDER BY cantidad_productos DESC, categoria;

-- 4. TOTAL POR TRANSACCION

SELECT
    v.id_venta,
    c.nombre_completo AS cliente,
    ROUND(SUM(d.cantidad * d.precio_unitario), 2) AS total_venta
FROM ventas v
JOIN clientes c
    ON c.id_cliente = v.id_cliente
JOIN detalle_venta d
    ON d.id_venta = v.id_venta
GROUP BY
    v.id_venta,
    c.nombre_completo
ORDER BY v.id_venta;

-- 5. PROMEDIO, MINIMO Y MAXIMO

SELECT
    ROUND(AVG(precio), 2) AS precio_promedio,
    MIN(precio) AS precio_minimo,
    MAX(precio) AS precio_maximo
FROM productos;

-- 6. BUSQUEDA POR TEXTO

SELECT
    id_producto,
    nombre_producto,
    categoria,
    precio
FROM productos
WHERE nombre_producto LIKE '%Logitech%'
   OR categoria LIKE '%Periféricos%'
ORDER BY nombre_producto;

-- 7. FILTRO POR FECHA

SELECT
    id_venta,
    id_cliente,
    id_vendedor,
    id_sucursal,
    fecha_venta
FROM ventas
WHERE fecha_venta BETWEEN '2026-02-01' AND '2026-02-28'
ORDER BY fecha_venta;

-- 8. TOP 5 POR MONTO

SELECT
    v.id_venta,
    c.nombre_completo AS cliente,
    ROUND(SUM(d.cantidad * d.precio_unitario), 2) AS monto_total
FROM ventas v
JOIN clientes c
    ON c.id_cliente = v.id_cliente
JOIN detalle_venta d
    ON d.id_venta = v.id_venta
GROUP BY
    v.id_venta,
    c.nombre_completo
ORDER BY monto_total DESC
LIMIT 5;

-- 9. REGISTROS RELACIONADOS SIN DETALLE

SELECT
    v.id_venta,
    v.fecha_venta
FROM ventas v
LEFT JOIN detalle_venta d
    ON d.id_venta = v.id_venta
WHERE d.id_venta IS NULL
ORDER BY v.id_venta;

-- 10. REPORTE FINAL

SELECT
    v.id_venta AS "Venta",
    c.nombre_completo AS "Cliente",
    ve.nombre_completo AS "Vendedor",
    s.nombre_sucursal AS "Sucursal",
    v.fecha_venta AS "Fecha",
    COUNT(d.id_producto) AS "Productos",
    SUM(d.cantidad) AS "Unidades",
    ROUND(SUM(d.cantidad * d.precio_unitario), 2) AS "Total"
FROM ventas v
JOIN clientes c
    ON c.id_cliente = v.id_cliente
JOIN vendedores ve
    ON ve.id_vendedor = v.id_vendedor
JOIN sucursales s
    ON s.id_sucursal = v.id_sucursal
JOIN detalle_venta d
    ON d.id_venta = v.id_venta
GROUP BY
    v.id_venta,
    c.nombre_completo,
    ve.nombre_completo,
    s.nombre_sucursal,
    v.fecha_venta
ORDER BY v.fecha_venta DESC, v.id_venta DESC;