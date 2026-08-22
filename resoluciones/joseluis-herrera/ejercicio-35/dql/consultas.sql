SELECT
    p.nombre AS producto,
    c.nombre AS categoria,
    pr.nombre AS proveedor,
    pr.telefono AS telefono_proveedor,
    b.nombre AS bodega,
    SUM(CASE WHEN m.tipo_movimiento = 'entrada' THEN m.cantidad ELSE 0 END) AS entradas,
    SUM(CASE WHEN m.tipo_movimiento = 'salida' THEN m.cantidad ELSE 0 END) AS salidas
FROM productos p
JOIN categorias c
    ON p.id_categoria = c.id_categoria
JOIN proveedores pr
    ON p.id_proveedor = pr.id_proveedor
JOIN movimientos m
    ON p.id_producto = m.id_producto
JOIN bodegas b
    ON m.id_bodega = b.id_bodega
GROUP BY
    p.id_producto,
    p.nombre,
    c.nombre,
    pr.nombre,
    pr.telefono,
    b.id_bodega,
    b.nombre
ORDER BY p.nombre, b.nombre;

SELECT DISTINCT
    nombre AS producto
FROM productos
ORDER BY nombre;

SELECT DISTINCT
    nombre AS categoria
FROM categorias
ORDER BY nombre;

SELECT DISTINCT
    nombre AS proveedor
FROM proveedores
ORDER BY nombre;

SELECT
    c.nombre AS categoria,
    COUNT(p.id_producto) AS cantidad_productos
FROM categorias c
LEFT JOIN productos p
    ON c.id_categoria = p.id_categoria
GROUP BY c.id_categoria, c.nombre
ORDER BY cantidad_productos DESC;

SELECT
    m.tipo_movimiento AS tipo,
    COUNT(*) AS cantidad_movimientos,
    SUM(m.cantidad) AS unidades
FROM movimientos m
GROUP BY m.tipo_movimiento
ORDER BY unidades DESC;

SELECT
    p.id_producto,
    p.nombre AS producto,
    SUM(
        CASE
            WHEN m.tipo_movimiento = 'entrada' THEN m.cantidad
            WHEN m.tipo_movimiento = 'salida' THEN -m.cantidad
        END
    ) AS stock_actual
FROM productos p
LEFT JOIN movimientos m
    ON p.id_producto = m.id_producto
GROUP BY p.id_producto, p.nombre
ORDER BY p.id_producto;

SELECT
    p.nombre AS producto,
    ROUND(
        SUM(
            CASE
                WHEN m.tipo_movimiento = 'entrada' THEN m.cantidad
                WHEN m.tipo_movimiento = 'salida' THEN -m.cantidad
            END
        ) * p.precio_unitario,
        2
    ) AS valor_stock
FROM productos p
LEFT JOIN movimientos m
    ON p.id_producto = m.id_producto
GROUP BY p.id_producto, p.nombre, p.precio_unitario
ORDER BY valor_stock DESC;

SELECT
    ROUND(AVG(precio_unitario), 2) AS precio_promedio,
    MIN(precio_unitario) AS precio_minimo,
    MAX(precio_unitario) AS precio_maximo
FROM productos;

SELECT
    id_producto,
    nombre,
    precio_unitario
FROM productos
WHERE nombre LIKE '%Monitor%'
   OR nombre LIKE '%Mouse%'
ORDER BY nombre;

SELECT
    id_movimiento,
    id_producto,
    tipo_movimiento,
    cantidad,
    fecha_movimiento
FROM movimientos
WHERE fecha_movimiento BETWEEN '2026-08-01' AND '2026-08-05'
ORDER BY fecha_movimiento;

SELECT
    id_producto,
    nombre,
    precio_unitario
FROM productos
WHERE precio_unitario BETWEEN 300 AND 2000
ORDER BY precio_unitario;

SELECT
    p.nombre AS producto,
    SUM(m.cantidad) AS cantidad_movida
FROM movimientos m
JOIN productos p
    ON m.id_producto = p.id_producto
GROUP BY p.id_producto, p.nombre
ORDER BY cantidad_movida DESC
LIMIT 5;

SELECT
    b.id_bodega,
    b.nombre AS bodega,
    SUM(m.cantidad) AS movimientos_registrados
FROM bodegas b
LEFT JOIN movimientos m
    ON b.id_bodega = m.id_bodega
GROUP BY b.id_bodega, b.nombre
ORDER BY movimientos_registrados DESC;

SELECT
    p.id_producto,
    p.nombre AS producto,
    p.stock_minimo,
    COALESCE(
        SUM(
            CASE
                WHEN m.tipo_movimiento = 'entrada' THEN m.cantidad
                WHEN m.tipo_movimiento = 'salida' THEN -m.cantidad
            END
        ),
        0
    ) AS stock_actual
FROM productos p
LEFT JOIN movimientos m
    ON p.id_producto = m.id_producto
GROUP BY p.id_producto, p.nombre, p.stock_minimo
HAVING stock_actual < p.stock_minimo
ORDER BY stock_actual;

SELECT
    p.nombre AS producto,
    c.nombre AS categoria,
    pr.nombre AS proveedor,
    b.nombre AS bodega,
    SUM(
        CASE
            WHEN m.tipo_movimiento = 'entrada' THEN m.cantidad
            ELSE -m.cantidad
        END
    ) AS stock_actual,
    p.precio_unitario AS precio_unitario,
    ROUND(
        SUM(
            CASE
                WHEN m.tipo_movimiento = 'entrada' THEN m.cantidad
                ELSE -m.cantidad
            END
        ) * p.precio_unitario,
        2
    ) AS valor_inventario
FROM productos p
JOIN categorias c
    ON p.id_categoria = c.id_categoria
JOIN proveedores pr
    ON p.id_proveedor = pr.id_proveedor
LEFT JOIN movimientos m
    ON p.id_producto = m.id_producto
LEFT JOIN bodegas b
    ON m.id_bodega = b.id_bodega
GROUP BY
    p.id_producto,
    p.nombre,
    c.nombre,
    pr.nombre,
    b.id_bodega,
    b.nombre,
    p.precio_unitario
ORDER BY valor_inventario DESC;

SELECT
    b.nombre AS bodega,
    COUNT(m.id_movimiento) AS cantidad_movimientos
FROM bodegas b
LEFT JOIN movimientos m
    ON b.id_bodega = m.id_bodega
GROUP BY b.id_bodega, b.nombre
ORDER BY cantidad_movimientos;