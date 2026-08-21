.headers on
.mode column

-- Ejercicio 026: Cafeteria Campus
-- Consultas de validacion.

-- 1. Que registros principales existen (con JOIN doble para mostrar el
--    nombre del cliente y del producto en vez de solo los id).
SELECT
    v.id_venta,
    c.nombre_cliente,
    p.nombre_producto,
    v.cantidad,
    v.monto_total,
    v.estado
FROM ventas v
JOIN clientes c ON c.id_cliente = v.id_cliente
JOIN productos p ON p.id_producto = v.id_producto;

-- 2. Que ventas no estan pagadas todavia.
SELECT id_venta, id_cliente, id_producto, monto_total, estado
FROM ventas
WHERE estado <> 'pagada';

-- 3. Que cliente tiene mas actividad (mas compras pagadas).
SELECT c.nombre_cliente, COUNT(*) AS total_compras_pagadas
FROM clientes c
JOIN ventas v ON v.id_cliente = c.id_cliente
WHERE v.estado = 'pagada'
GROUP BY c.id_cliente, c.nombre_cliente
ORDER BY total_compras_pagadas DESC;

-- 4. Ventas ordenadas por fecha.
SELECT c.nombre_cliente, p.nombre_producto, v.fecha_venta
FROM ventas v
JOIN clientes c ON c.id_cliente = v.id_cliente
JOIN productos p ON p.id_producto = v.id_producto
ORDER BY v.fecha_venta;

-- 5. Que producto genera mas ingresos (sin contar canceladas), para
--    decidir que reabastecer.
SELECT
    p.nombre_producto,
    p.categoria,
    SUM(v.monto_total) AS total_recaudado
FROM productos p
JOIN ventas v ON v.id_producto = p.id_producto
WHERE v.estado <> 'cancelada'
GROUP BY p.id_producto, p.nombre_producto, p.categoria
ORDER BY total_recaudado DESC;
