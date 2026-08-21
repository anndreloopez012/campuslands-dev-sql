.headers on
.mode column

-- Ejercicio 045: Soldadura Industrial
-- Consultas de validacion.

-- 1. Que registros principales existen (con JOIN doble para mostrar el
--    cliente y el tecnico en vez de solo los id).
SELECT
    o.id_orden,
    cl.nombre_cliente,
    t.nombre_tecnico,
    o.descripcion,
    o.fecha_orden,
    o.costo_total,
    o.estado
FROM ordenes o
JOIN clientes cl ON cl.id_cliente = o.id_cliente
JOIN tecnicos t ON t.id_tecnico = o.id_tecnico;

-- 2. Que ordenes no estan entregadas todavia.
SELECT id_orden, id_cliente, id_tecnico, fecha_orden, estado
FROM ordenes
WHERE estado <> 'entregada';

-- 3. Que tecnico tiene mas ordenes asignadas.
SELECT t.nombre_tecnico, COUNT(*) AS total_ordenes
FROM tecnicos t
JOIN ordenes o ON o.id_tecnico = t.id_tecnico
GROUP BY t.id_tecnico, t.nombre_tecnico
ORDER BY total_ordenes DESC, t.nombre_tecnico;

-- 4. Ordenes ordenadas por fecha.
SELECT cl.nombre_cliente, t.nombre_tecnico, o.descripcion, o.fecha_orden
FROM ordenes o
JOIN clientes cl ON cl.id_cliente = o.id_cliente
JOIN tecnicos t ON t.id_tecnico = o.id_tecnico
ORDER BY o.fecha_orden;

-- 5. Costo final de cada orden (mano de obra + materiales), para
--    decidir cuales priorizar al cobrar.
SELECT
    o.id_orden,
    cl.nombre_cliente,
    o.descripcion,
    o.costo_total AS mano_de_obra,
    ROUND(COALESCE(SUM(m.cantidad * m.costo_unitario), 0), 2) AS costo_materiales,
    ROUND(o.costo_total + COALESCE(SUM(m.cantidad * m.costo_unitario), 0), 2) AS costo_final
FROM ordenes o
JOIN clientes cl ON cl.id_cliente = o.id_cliente
LEFT JOIN materiales m ON m.id_orden = o.id_orden
GROUP BY o.id_orden, cl.nombre_cliente, o.descripcion, o.costo_total
ORDER BY costo_final DESC;
