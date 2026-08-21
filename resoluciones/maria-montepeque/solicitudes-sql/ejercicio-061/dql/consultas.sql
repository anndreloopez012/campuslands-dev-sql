.headers on
.mode column

-- Ejercicio 061: Delivery de Comida
-- Consultas que responden preguntas reales del cliente.

-- 1. Que registros principales existen: todos los pedidos con cliente,
-- platillo, repartidor (si tiene) y estado.
SELECT p.id_pedido,
       c.nombre AS cliente,
       m.nombre_platillo AS platillo,
       r.nombre AS repartidor,
       p.cantidad,
       p.estado
FROM pedidos p
JOIN clientes c ON c.id_cliente = p.id_cliente
JOIN menus m ON m.id_menu = p.id_menu
LEFT JOIN repartidores r ON r.id_repartidor = p.id_repartidor;

-- 2. Que registros estan pendientes, en camino o ya entregados.
SELECT id_pedido, estado
FROM pedidos
WHERE estado IN ('pendiente', 'en_camino', 'entregado')
ORDER BY estado;

-- 3. Que repartidor tiene mas actividad (ranking por pedidos entregados).
SELECT r.nombre AS repartidor,
       COUNT(*) AS pedidos_entregados
FROM pedidos p
JOIN repartidores r ON r.id_repartidor = p.id_repartidor
WHERE p.estado = 'entregado'
GROUP BY r.id_repartidor
ORDER BY pedidos_entregados DESC;

-- 4. Pedidos ordenados por fecha, del mas reciente al mas antiguo.
SELECT id_pedido, fecha_pedido, estado
FROM pedidos
ORDER BY fecha_pedido DESC;

-- 5. Reporte para decision de negocio: facturacion por restaurante,
-- solo con pagos ya 'pagado', y restaurantes que superan Q100 en ventas
-- (GROUP BY + HAVING).
SELECT m.restaurante,
       COUNT(*) AS pedidos_pagados,
       SUM(pg.monto) AS total_facturado
FROM pagos pg
JOIN pedidos p ON p.id_pedido = pg.id_pedido
JOIN menus m ON m.id_menu = p.id_menu
WHERE pg.estado_pago = 'pagado'
GROUP BY m.restaurante
HAVING SUM(pg.monto) > 100
ORDER BY total_facturado DESC;
