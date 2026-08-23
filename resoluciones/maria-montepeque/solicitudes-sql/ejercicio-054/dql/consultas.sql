.headers on
.mode column

-- Ejercicio 054: Tienda Sneakers
-- Consultas de validacion.

-- 1. Que registros principales existen (con JOIN triple: cliente,
--    talla y producto).
SELECT
    ped.id_pedido,
    cl.nombre_cliente,
    p.nombre_producto,
    t.numero_talla,
    ped.fecha_pedido,
    ped.cantidad,
    ped.estado
FROM pedidos ped
JOIN clientes cl ON cl.id_cliente = ped.id_cliente
JOIN tallas t ON t.id_talla = ped.id_talla
JOIN productos p ON p.id_producto = t.id_producto;

-- 2. Que pedidos no estan enviados todavia.
SELECT id_pedido, id_cliente, id_talla, fecha_pedido, estado
FROM pedidos
WHERE estado <> 'enviado';

-- 3. Que cliente tiene mas pedidos.
SELECT cl.nombre_cliente, COUNT(*) AS total_pedidos
FROM clientes cl
JOIN pedidos ped ON ped.id_cliente = cl.id_cliente
GROUP BY cl.id_cliente, cl.nombre_cliente
ORDER BY total_pedidos DESC, cl.nombre_cliente;

-- 4. Pedidos ordenados por fecha.
SELECT cl.nombre_cliente, p.nombre_producto, t.numero_talla, ped.fecha_pedido
FROM pedidos ped
JOIN clientes cl ON cl.id_cliente = ped.id_cliente
JOIN tallas t ON t.id_talla = ped.id_talla
JOIN productos p ON p.id_producto = t.id_producto
ORDER BY ped.fecha_pedido;

-- 5. Pedidos pendientes o confirmados con menos stock disponible en
--    su talla, para decidir a cuales atender o reabastecer primero
--    (el reporte semanal que pidio el cliente).
SELECT
    cl.nombre_cliente,
    p.nombre_producto,
    t.numero_talla,
    ped.cantidad,
    t.stock AS stock_disponible,
    ped.estado
FROM pedidos ped
JOIN clientes cl ON cl.id_cliente = ped.id_cliente
JOIN tallas t ON t.id_talla = ped.id_talla
JOIN productos p ON p.id_producto = t.id_producto
WHERE ped.estado IN ('pendiente', 'confirmado')
ORDER BY t.stock ASC, ped.fecha_pedido;
