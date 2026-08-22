SELECT * FROM pedidos;

SELECT id_pedido, total
FROM pedidos;

SELECT id_pedido, fecha_pedido, total
FROM pedidos
WHERE total >= 100;

SELECT id_pedido, fecha_pedido, estado
FROM pedidos
ORDER BY fecha_pedido DESC;

SELECT id_pedido, total
FROM pedidos
ORDER BY total DESC
LIMIT 5;

SELECT COUNT(*) AS total_pedidos
FROM pedidos;

SELECT
AVG(total) AS promedio,
MIN(total) AS minimo,
MAX(total) AS maximo
FROM pedidos;

SELECT
estado,
COUNT(*) AS cantidad
FROM pedidos
GROUP BY estado;

SELECT
p.id_pedido,
c.nombre AS cliente,
r.nombre AS restaurante,
rep.nombre AS repartidor,
p.estado,
p.total
FROM pedidos p
JOIN clientes c ON p.id_cliente = c.id_cliente
JOIN restaurantes r ON p.id_restaurante = r.id_restaurante
JOIN repartidores rep ON p.id_repartidor = rep.id_repartidor;

SELECT
p.id_pedido,
c.nombre,
p.total
FROM pedidos p
JOIN clientes c ON p.id_cliente = c.id_cliente
WHERE p.estado='ENTREGADO'
ORDER BY p.total DESC
LIMIT 5;

SELECT
r.nombre AS restaurante,
COUNT(p.id_pedido) AS pedidos,
SUM(p.total) AS ingresos
FROM restaurantes r
LEFT JOIN pedidos p ON r.id_restaurante = p.id_restaurante
GROUP BY r.id_restaurante, r.nombre
ORDER BY ingresos DESC;

SELECT
rep.nombre AS repartidor,
COUNT(p.id_pedido) AS entregas
FROM repartidores rep
LEFT JOIN pedidos p ON rep.id_repartidor = p.id_repartidor
GROUP BY rep.id_repartidor, rep.nombre
ORDER BY entregas DESC;

SELECT
r.nombre AS restaurante,
AVG(p.total) AS ticket_promedio,
CASE
WHEN AVG(p.total) >= 120 THEN 'Alto valor'
WHEN AVG(p.total) >= 90 THEN 'Valor medio'
ELSE 'Valor bajo'
END AS decision
FROM restaurantes r
JOIN pedidos p ON r.id_restaurante = p.id_restaurante
GROUP BY r.id_restaurante, r.nombre
ORDER BY ticket_promedio DESC;