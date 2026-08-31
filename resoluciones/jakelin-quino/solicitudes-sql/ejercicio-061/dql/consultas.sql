.headers on
.mode column

-- Ejercicio 061: Delivery de Comida
-- 1. Menu por restaurante
SELECT r.nombre AS restaurante, p.nombre AS plato, p.precio FROM platos p JOIN restaurantes r ON r.id = p.restaurante_id;

-- 2. Pedidos en camino
SELECT pe.id, pe.cliente, pl.nombre AS plato, pe.cantidad FROM pedidos pe JOIN platos pl ON pl.id = pe.plato_id WHERE pe.estado = 'en_camino';

-- 3. Ventas por plato
SELECT pl.nombre, SUM(pe.cantidad * pl.precio) AS total_vendido FROM pedidos pe JOIN platos pl ON pl.id = pe.plato_id WHERE pe.estado = 'entregado' GROUP BY pl.id, pl.nombre;