-- Ejercicio 31: Normalizacion Ventas Campus

-- 1. Reconstruir una vista similar al archivo original usando JOIN
-- (una fila por cada producto de cada venta, como quedaria "aplanado" el CSV original)
SELECT
    v.id_venta,
    c.nombre AS cliente_nombre,
    c.email AS cliente_email,
    p.nombre AS producto,
    dv.precio_unitario AS precio,
    dv.cantidad AS cantidad,
    ve.nombre AS vendedor,
    ve.sucursal AS sucursal
FROM ventas v
JOIN clientes c ON c.id_cliente = v.id_cliente
JOIN vendedores ve ON ve.id_vendedor = v.id_vendedor
JOIN detalle_venta dv ON dv.id_venta = v.id_venta
JOIN productos p ON p.id_producto = dv.id_producto
ORDER BY v.id_venta;

-- 2. Listar entidades principales sin duplicados
SELECT DISTINCT nombre, email FROM clientes;
SELECT DISTINCT nombre FROM productos;
SELECT DISTINCT nombre, sucursal FROM vendedores;

-- 3. Contar registros por categoria o estado (ventas por sucursal)
SELECT ve.sucursal, COUNT(DISTINCT v.id_venta) AS cantidad_ventas
FROM ventas v
JOIN vendedores ve ON ve.id_vendedor = v.id_vendedor
GROUP BY ve.sucursal;

-- 4. Calcular un total por transaccion (venta)
SELECT v.id_venta, SUM(dv.cantidad * dv.precio_unitario) AS total_venta
FROM ventas v
JOIN detalle_venta dv ON dv.id_venta = v.id_venta
GROUP BY v.id_venta;

-- 5. Calcular promedio, minimo y maximo del total por venta
SELECT
    AVG(total_venta) AS promedio,
    MIN(total_venta) AS minimo,
    MAX(total_venta) AS maximo
FROM (
    SELECT v.id_venta, SUM(dv.cantidad * dv.precio_unitario) AS total_venta
    FROM ventas v
    JOIN detalle_venta dv ON dv.id_venta = v.id_venta
    GROUP BY v.id_venta
);

-- 6. Buscar registros por texto con LIKE
SELECT * FROM productos WHERE nombre LIKE '%Gamer%';
SELECT * FROM clientes WHERE nombre LIKE 'Ana%';

-- 7. Filtrar por fecha o rango numerico
SELECT * FROM ventas WHERE fecha >= '2026-07-03';
SELECT * FROM productos WHERE precio_unitario BETWEEN 100 AND 500;

-- 8. Mostrar top 5 por cantidad o monto (productos con mas unidades vendidas)
SELECT p.nombre, SUM(dv.cantidad) AS unidades_vendidas
FROM detalle_venta dv
JOIN productos p ON p.id_producto = dv.id_producto
GROUP BY p.nombre
ORDER BY unidades_vendidas DESC
LIMIT 5;

-- 9. Detectar registros relacionados sin detalle (clientes sin ventas registradas)
SELECT c.id_cliente, c.nombre
FROM clientes c
LEFT JOIN ventas v ON v.id_cliente = c.id_cliente
WHERE v.id_venta IS NULL;

-- 10. Reporte final con alias legibles
SELECT
    c.nombre AS cliente,
    ve.nombre AS vendedor,
    ve.sucursal AS sucursal,
    p.nombre AS producto,
    dv.cantidad AS cantidad_comprada,
    dv.precio_unitario AS precio_unitario,
    (dv.cantidad * dv.precio_unitario) AS subtotal_linea,
    v.fecha AS fecha_venta
FROM ventas v
JOIN clientes c ON c.id_cliente = v.id_cliente
JOIN vendedores ve ON ve.id_vendedor = v.id_vendedor
JOIN detalle_venta dv ON dv.id_venta = v.id_venta
JOIN productos p ON p.id_producto = dv.id_producto
ORDER BY v.id_venta;
