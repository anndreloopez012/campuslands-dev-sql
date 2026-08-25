.headers on
.mode column

-- Ejercicio 079: Tienda Sneakers
-- Consultas que responden preguntas reales del cliente.

-- 1. Que registros principales existen: todas las lineas de pedido
-- con su producto, su talla y su cliente.
SELECT dp.id_detalle,
       c.nombre_cliente,
       p.nombre_producto,
       t.numero_talla,
       dp.cantidad,
       dp.precio_unitario,
       (dp.cantidad * dp.precio_unitario) AS subtotal
FROM detalle_pedidos dp
JOIN pedidos ped ON ped.id_pedido = dp.id_pedido
JOIN clientes c ON c.id_cliente = ped.id_cliente
JOIN productos p ON p.id_producto = dp.id_producto
JOIN tallas t ON t.id_talla = dp.id_talla;

-- 2. Que pedidos estan pendientes, confirmados, enviados, entregados
-- o cancelados.
SELECT id_pedido, id_cliente, estado
FROM pedidos
ORDER BY estado;

-- 3. Que cliente tiene mas pedidos (ranking de actividad).
SELECT c.nombre_cliente, COUNT(*) AS total_pedidos
FROM clientes c
JOIN pedidos p ON p.id_cliente = c.id_cliente
GROUP BY c.id_cliente, c.nombre_cliente
ORDER BY total_pedidos DESC, c.nombre_cliente;

-- 4. Lineas de pedido ordenadas por subtotal, de mayor a menor.
SELECT p.nombre_producto, t.numero_talla, dp.cantidad, dp.precio_unitario,
       (dp.cantidad * dp.precio_unitario) AS subtotal
FROM detalle_pedidos dp
JOIN productos p ON p.id_producto = dp.id_producto
JOIN tallas t ON t.id_talla = dp.id_talla
ORDER BY subtotal DESC;

-- 5. Reporte para decision de negocio: productos mas pedidos por
-- cantidad total, para decidir cuales reabastecer primero (GROUP BY
-- + HAVING).
SELECT p.nombre_producto,
       SUM(dp.cantidad) AS unidades_pedidas
FROM detalle_pedidos dp
JOIN productos p ON p.id_producto = dp.id_producto
GROUP BY p.id_producto, p.nombre_producto
HAVING SUM(dp.cantidad) >= 1
ORDER BY unidades_pedidas DESC, p.nombre_producto;
