.headers on
.mode column

-- Ejercicio 070: Soldadura Industrial
-- Consultas que responden preguntas reales del cliente.

-- 1. Que registros principales existen: todas las ordenes con su
-- cliente y su tecnico.
SELECT o.id_orden,
       c.nombre_cliente,
       t.nombre_tecnico,
       o.descripcion,
       o.fecha_orden,
       o.estado
FROM ordenes o
JOIN clientes c ON c.id_cliente = o.id_cliente
JOIN tecnicos t ON t.id_tecnico = o.id_tecnico;

-- 2. Que ordenes estan pendientes, en proceso, finalizadas o
-- canceladas (filtro por estado: ejemplo con las que siguen abiertas).
SELECT id_orden, descripcion, estado
FROM ordenes
WHERE estado IN ('pendiente', 'en_proceso');

-- 3. Que tecnico tiene mas ordenes asignadas (ranking de actividad).
SELECT t.nombre_tecnico, COUNT(*) AS total_ordenes
FROM tecnicos t
JOIN ordenes o ON o.id_tecnico = t.id_tecnico
GROUP BY t.id_tecnico, t.nombre_tecnico
ORDER BY total_ordenes DESC, t.nombre_tecnico;

-- 4. Materiales ordenados por costo total (cantidad x costo unitario),
-- de mayor a menor.
SELECT o.id_orden,
       m.nombre_material,
       m.cantidad,
       m.costo_unitario,
       (m.cantidad * m.costo_unitario) AS costo_total
FROM materiales m
JOIN ordenes o ON o.id_orden = m.id_orden
ORDER BY costo_total DESC;

-- 5. Reporte para decision de negocio: ordenes con al menos una
-- inspeccion rechazada, para saber cuales necesitan corregirse antes
-- de entregarse al cliente (GROUP BY + HAVING).
SELECT o.id_orden,
       o.descripcion,
       COUNT(*) AS inspecciones_rechazadas
FROM inspecciones i
JOIN ordenes o ON o.id_orden = i.id_orden
WHERE i.resultado = 'rechazada'
GROUP BY o.id_orden, o.descripcion
HAVING COUNT(*) >= 1
ORDER BY inspecciones_rechazadas DESC;
