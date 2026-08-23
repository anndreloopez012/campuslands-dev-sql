-- Ejercicio 22: Pedidos Delivery
-- Entidad central: pedidos

-- 1. Listar todos los registros principales de la entidad central
SELECT * FROM pedidos;

-- 2. Mostrar solo dos columnas relevantes
SELECT total, estado FROM pedidos;

-- 3. Filtrar registros por una condicion numerica
SELECT * FROM pedidos WHERE total > 100;

-- 4. Ordenar resultados por fecha
SELECT * FROM pedidos ORDER BY fecha;

-- 5. Mostrar los 5 pedidos de mayor total
SELECT * FROM pedidos ORDER BY total DESC LIMIT 5;

-- 6. Contar registros totales
SELECT COUNT(*) AS total_pedidos FROM pedidos;

-- 7. Promedio, minimo y maximo del total de los pedidos
SELECT
    AVG(total) AS promedio,
    MIN(total) AS minimo,
    MAX(total) AS maximo
FROM pedidos;

-- 8. Agrupar pedidos por estado
SELECT estado, COUNT(*) AS cantidad_pedidos
FROM pedidos
GROUP BY estado;

-- 9. Relacionar pedidos, clientes y restaurantes con JOIN
SELECT p.id_pedido, c.nombre AS cliente, r.nombre AS restaurante
FROM pedidos p
JOIN clientes c ON c.id_cliente = p.id_cliente
JOIN restaurantes r ON r.id_restaurante = p.id_restaurante;

-- 10. WHERE + ORDER BY + LIMIT
SELECT * FROM pedidos
WHERE estado = 'entregado'
ORDER BY total DESC
LIMIT 3;

-- 11. Reporte con alias legibles
SELECT
    c.nombre AS cliente,
    r.nombre AS restaurante,
    rep.nombre AS repartidor,
    p.total AS total_pedido,
    p.estado AS estado_pedido,
    p.fecha AS fecha_pedido
FROM pedidos p
JOIN clientes c ON c.id_cliente = p.id_cliente
JOIN restaurantes r ON r.id_restaurante = p.id_restaurante
JOIN repartidores rep ON rep.id_repartidor = p.id_repartidor;

-- 12. Consulta para decision de negocio: restaurante con mayores ingresos por pedidos entregados
SELECT r.nombre, SUM(p.total) AS total_ingresos
FROM pedidos p
JOIN restaurantes r ON r.id_restaurante = p.id_restaurante
WHERE p.estado = 'entregado'
GROUP BY r.nombre
ORDER BY total_ingresos DESC
LIMIT 1;
