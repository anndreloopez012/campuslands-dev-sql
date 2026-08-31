.headers on
.mode column

-- Ejercicio 076: Cafeteria Campus
-- Consultas que responden preguntas reales del cliente.

-- 1. Que registros principales existen: todas las lineas de venta con
-- su producto y su venta.
SELECT dv.id_detalle,
       p.nombre_producto,
       v.id_venta,
       dv.cantidad,
       dv.precio_unitario,
       (dv.cantidad * dv.precio_unitario) AS subtotal
FROM detalle_ventas dv
JOIN productos p ON p.id_producto = dv.id_producto
JOIN ventas v ON v.id_venta = dv.id_venta;

-- 2. Que ventas estan abiertas, cerradas o canceladas.
SELECT id_venta, id_cliente, estado
FROM ventas
ORDER BY estado;

-- 3. Que cliente tiene mas actividad (mas gastado en total).
SELECT c.nombre_cliente,
       SUM(dv.cantidad * dv.precio_unitario) AS total_gastado
FROM clientes c
JOIN ventas v ON v.id_cliente = c.id_cliente
JOIN detalle_ventas dv ON dv.id_venta = v.id_venta
GROUP BY c.id_cliente, c.nombre_cliente
ORDER BY total_gastado DESC, c.nombre_cliente;

-- 4. Lineas de venta ordenadas por subtotal, de mayor a menor.
SELECT p.nombre_producto, dv.cantidad, dv.precio_unitario,
       (dv.cantidad * dv.precio_unitario) AS subtotal
FROM detalle_ventas dv
JOIN productos p ON p.id_producto = dv.id_producto
ORDER BY subtotal DESC;

-- 5. Reporte para decision de negocio: productos mas vendidos por
-- cantidad total, para decidir cuales reabastecer primero (GROUP BY
-- + HAVING).
SELECT p.nombre_producto,
       SUM(dv.cantidad) AS unidades_vendidas
FROM detalle_ventas dv
JOIN productos p ON p.id_producto = dv.id_producto
GROUP BY p.id_producto, p.nombre_producto
HAVING SUM(dv.cantidad) >= 2
ORDER BY unidades_vendidas DESC;
