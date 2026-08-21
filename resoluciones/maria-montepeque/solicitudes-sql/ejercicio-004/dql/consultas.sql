.headers on
.mode column

-- Ejercicio 004: Tienda Sneakers
-- Consultas de validacion.

-- 1. Que registros principales existen.
SELECT * FROM pedidos;

-- 2. Que registros estan activos, pendientes o finalizados (aqui:
--    pedidos que todavia no llegan al cliente).
SELECT id_pedido, nombre_cliente, precio_total, fecha_pedido, estado
FROM pedidos
WHERE estado <> 'entregado';

-- 3. Que cliente tiene mas actividad (mas pedidos en la semana).
SELECT nombre_cliente, COUNT(*) AS total_pedidos
FROM pedidos
GROUP BY nombre_cliente
ORDER BY total_pedidos DESC;

-- 4. Pedidos ordenados por fecha, para revisar la semana dia a dia.
SELECT id_pedido, nombre_cliente, fecha_pedido, estado
FROM pedidos
ORDER BY fecha_pedido;

-- 5. Reporte semanal para el cliente: ingresos por dia (solo pedidos
--    entregados), para decidir que reabastecer al final de la semana.
SELECT
    date(fecha_pedido) AS dia,
    SUM(precio_total) AS ingresos_del_dia,
    COUNT(*) AS pedidos_entregados
FROM pedidos
WHERE estado = 'entregado'
GROUP BY date(fecha_pedido)
ORDER BY dia;
