.headers on
.mode column

-- Ejercicio 011: Delivery de Comida
-- Consultas de validacion.

-- 1. Que registros principales existen.
SELECT * FROM pedidos;

-- 2. Que pedidos no estan entregados todavia.
SELECT id_pedido, nombre_cliente, repartidor, fecha_pedido, estado
FROM pedidos
WHERE estado <> 'entregado';

-- 3. Que cliente tiene mas pedidos.
SELECT nombre_cliente, COUNT(*) AS total_pedidos
FROM pedidos
GROUP BY nombre_cliente
ORDER BY total_pedidos DESC;

-- 4. Pedidos ordenados por fecha.
SELECT id_pedido, nombre_cliente, fecha_pedido, estado
FROM pedidos
ORDER BY fecha_pedido;

-- 5. Que repartidor tiene mas entregas completadas, para decisiones de
--    desempeno.
SELECT repartidor, COUNT(*) AS entregas_completadas
FROM pedidos
WHERE estado = 'entregado'
GROUP BY repartidor
ORDER BY entregas_completadas DESC;
