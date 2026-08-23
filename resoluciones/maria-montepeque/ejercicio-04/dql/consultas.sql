-- Ejercicio 04: Restaurante Campus
-- Entidad central: detalle_pedido

-- 1. Listar todos los registros principales de la entidad central
SELECT * FROM detalle_pedido;

-- 2. Mostrar solo dos columnas relevantes
SELECT cantidad, precio_unitario FROM detalle_pedido;

-- 3. Filtrar registros por una condicion numerica
SELECT * FROM detalle_pedido WHERE cantidad > 1;

-- 4. Ordenar resultados por id de pedido
SELECT * FROM detalle_pedido ORDER BY id_pedido;

-- 5. Mostrar los 5 renglones con mayor monto (cantidad * precio_unitario)
SELECT *, (cantidad * precio_unitario) AS monto
FROM detalle_pedido
ORDER BY monto DESC
LIMIT 5;

-- 6. Contar registros totales
SELECT COUNT(*) AS total_lineas FROM detalle_pedido;

-- 7. Promedio, minimo y maximo del monto por linea
SELECT
    AVG(cantidad * precio_unitario) AS promedio,
    MIN(cantidad * precio_unitario) AS minimo,
    MAX(cantidad * precio_unitario) AS maximo
FROM detalle_pedido;

-- 8. Agrupar lineas por plato
SELECT id_plato, COUNT(*) AS veces_pedido
FROM detalle_pedido
GROUP BY id_plato;

-- 9. Relacionar detalle_pedido, pedidos y platos con JOIN
SELECT d.id_detalle, p.id_mesa, pl.nombre AS plato
FROM detalle_pedido d
JOIN pedidos p ON p.id_pedido = d.id_pedido
JOIN platos pl ON pl.id_plato = d.id_plato;

-- 10. WHERE + ORDER BY + LIMIT
SELECT * FROM detalle_pedido
WHERE cantidad >= 2
ORDER BY precio_unitario DESC
LIMIT 3;

-- 11. Reporte con alias legibles
SELECT
    m.numero AS mesa,
    pl.nombre AS plato,
    d.cantidad AS unidades,
    d.precio_unitario AS precio,
    (d.cantidad * d.precio_unitario) AS total
FROM detalle_pedido d
JOIN pedidos p ON p.id_pedido = d.id_pedido
JOIN mesas m ON m.id_mesa = p.id_mesa
JOIN platos pl ON pl.id_plato = d.id_plato;

-- 12. Consulta para decision de negocio: plato mas vendido por unidades
SELECT pl.nombre, SUM(d.cantidad) AS unidades_vendidas
FROM detalle_pedido d
JOIN platos pl ON pl.id_plato = d.id_plato
GROUP BY pl.nombre
ORDER BY unidades_vendidas DESC
LIMIT 1;
