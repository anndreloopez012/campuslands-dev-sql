.headers on
.mode column

-- Ejercicio 036: Delivery de Comida
-- Consultas de validacion.

-- 1. Que registros principales existen (con JOIN doble para mostrar el
--    cliente y el platillo en vez de solo los id).
SELECT
    p.id_pedido,
    c.nombre_cliente,
    m.nombre_platillo,
    p.repartidor,
    p.fecha_pedido,
    p.monto_pagado,
    p.estado,
    p.calificacion
FROM pedidos p
JOIN clientes c ON c.id_cliente = p.id_cliente
JOIN menus m ON m.id_menu = p.id_menu;

-- 2. Que pedidos no estan entregados todavia.
SELECT id_pedido, id_cliente, id_menu, monto_pagado, estado
FROM pedidos
WHERE estado <> 'entregado';

-- 3. Que cliente tiene mas pedidos.
SELECT c.nombre_cliente, COUNT(*) AS total_pedidos
FROM clientes c
JOIN pedidos p ON p.id_cliente = c.id_cliente
GROUP BY c.id_cliente, c.nombre_cliente
ORDER BY total_pedidos DESC, c.nombre_cliente;

-- 4. Pedidos ordenados por fecha.
SELECT c.nombre_cliente, m.nombre_platillo, p.fecha_pedido
FROM pedidos p
JOIN clientes c ON c.id_cliente = p.id_cliente
JOIN menus m ON m.id_menu = p.id_menu
ORDER BY p.fecha_pedido;

-- 5. Calificacion promedio por repartidor (solo pedidos ya
--    calificados), para decidir a quien asignar mas pedidos.
SELECT
    repartidor,
    ROUND(AVG(calificacion), 2) AS promedio_calificacion,
    COUNT(calificacion) AS pedidos_calificados
FROM pedidos
WHERE calificacion IS NOT NULL
GROUP BY repartidor
ORDER BY promedio_calificacion DESC;
