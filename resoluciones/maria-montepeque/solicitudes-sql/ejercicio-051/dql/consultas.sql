.headers on
.mode column

-- Ejercicio 051: Cafeteria Campus
-- Consultas de validacion.

-- 1. Que registros principales existen (con JOIN al cliente y el
--    total de cada venta calculado desde el detalle).
SELECT
    v.id_venta,
    c.nombre_cliente,
    v.fecha_venta,
    v.estado,
    ROUND(COALESCE(SUM(d.cantidad * d.precio_unitario), 0), 2) AS total_venta
FROM ventas v
JOIN clientes c ON c.id_cliente = v.id_cliente
LEFT JOIN detalle_ventas d ON d.id_venta = v.id_venta
GROUP BY v.id_venta, c.nombre_cliente, v.fecha_venta, v.estado
ORDER BY v.id_venta;

-- 2. Que ventas no estan pagadas todavia.
SELECT id_venta, id_cliente, fecha_venta, estado
FROM ventas
WHERE estado <> 'pagada';

-- 3. Que cliente tiene mas ventas.
SELECT c.nombre_cliente, COUNT(*) AS total_ventas
FROM clientes c
JOIN ventas v ON v.id_cliente = c.id_cliente
GROUP BY c.id_cliente, c.nombre_cliente
ORDER BY total_ventas DESC, c.nombre_cliente;

-- 4. Ventas ordenadas por fecha.
SELECT c.nombre_cliente, v.fecha_venta, v.estado
FROM ventas v
JOIN clientes c ON c.id_cliente = v.id_cliente
ORDER BY v.fecha_venta;

-- 5. Producto mas vendido en unidades (sin contar ventas
--    canceladas), para decidir que reabastecer primero.
SELECT p.nombre_producto, SUM(d.cantidad) AS unidades_vendidas
FROM productos p
JOIN detalle_ventas d ON d.id_producto = p.id_producto
JOIN ventas v ON v.id_venta = d.id_venta
WHERE v.estado <> 'cancelada'
GROUP BY p.id_producto, p.nombre_producto
ORDER BY unidades_vendidas DESC, p.nombre_producto;
