-- Ejercicio 35: Normalizacion Inventario Proveedores

-- 1. Reconstruir una vista similar al archivo original usando JOIN
-- (entradas y salidas totales por producto y bodega, como quedaba el CSV original)
SELECT
    p.nombre AS producto,
    c.nombre AS categoria,
    pr.nombre AS proveedor,
    pr.telefono AS telefono_proveedor,
    SUM(CASE WHEN m.tipo_movimiento = 'entrada' THEN m.cantidad ELSE 0 END) AS entradas,
    SUM(CASE WHEN m.tipo_movimiento = 'salida' THEN m.cantidad ELSE 0 END) AS salidas,
    b.nombre AS bodega
FROM movimientos m
JOIN productos p ON p.id_producto = m.id_producto
JOIN categorias c ON c.id_categoria = p.id_categoria
JOIN proveedores pr ON pr.id_proveedor = p.id_proveedor
JOIN bodegas b ON b.id_bodega = m.id_bodega
GROUP BY p.nombre, b.nombre
ORDER BY p.nombre;

-- 2. Listar entidades principales sin duplicados
SELECT DISTINCT nombre FROM categorias;
SELECT DISTINCT nombre, telefono FROM proveedores;
SELECT DISTINCT nombre FROM productos;
SELECT DISTINCT nombre FROM bodegas;

-- 3. Contar registros por categoria o estado (movimientos por tipo)
SELECT tipo_movimiento, COUNT(*) AS cantidad_movimientos
FROM movimientos
GROUP BY tipo_movimiento;

-- 4. Calcular un total por transaccion (variacion neta de stock por producto)
SELECT
    p.nombre AS producto,
    SUM(CASE WHEN m.tipo_movimiento = 'entrada' THEN m.cantidad ELSE -m.cantidad END) AS variacion_neta
FROM movimientos m
JOIN productos p ON p.id_producto = m.id_producto
GROUP BY p.nombre;

-- 5. Calcular promedio, minimo y maximo de la cantidad movida
SELECT
    AVG(cantidad) AS promedio,
    MIN(cantidad) AS minimo,
    MAX(cantidad) AS maximo
FROM movimientos;

-- 6. Buscar registros por texto con LIKE
SELECT * FROM productos WHERE nombre LIKE '%Pro%';
SELECT * FROM proveedores WHERE nombre LIKE 'Tecno%';

-- 7. Filtrar por fecha o rango numerico
SELECT * FROM movimientos WHERE fecha_movimiento >= '2026-06-08';
SELECT * FROM movimientos WHERE cantidad BETWEEN 5 AND 30;

-- 8. Mostrar top 5 por cantidad o monto (productos con mas entradas totales)
SELECT p.nombre AS producto, SUM(m.cantidad) AS total_entradas
FROM movimientos m
JOIN productos p ON p.id_producto = m.id_producto
WHERE m.tipo_movimiento = 'entrada'
GROUP BY p.nombre
ORDER BY total_entradas DESC
LIMIT 5;

-- 9. Detectar registros relacionados sin detalle (productos sin movimientos registrados)
SELECT p.id_producto, p.nombre
FROM productos p
LEFT JOIN movimientos m ON m.id_producto = p.id_producto
WHERE m.id_movimiento IS NULL;

-- 10. Reporte final con alias legibles
SELECT
    p.nombre AS producto,
    c.nombre AS categoria,
    pr.nombre AS proveedor,
    b.nombre AS bodega,
    m.tipo_movimiento AS tipo,
    m.cantidad AS cantidad,
    m.fecha_movimiento AS fecha
FROM movimientos m
JOIN productos p ON p.id_producto = m.id_producto
JOIN categorias c ON c.id_categoria = p.id_categoria
JOIN proveedores pr ON pr.id_proveedor = p.id_proveedor
JOIN bodegas b ON b.id_bodega = m.id_bodega
ORDER BY m.fecha_movimiento;
