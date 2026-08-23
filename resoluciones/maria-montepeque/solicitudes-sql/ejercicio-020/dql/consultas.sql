.headers on
.mode column

-- Ejercicio 020: Soldadura Industrial
-- Consultas de validacion.

-- 1. Que registros principales existen.
SELECT * FROM ordenes;

-- 2. Que ordenes no estan aprobadas todavia.
SELECT id_orden, codigo_orden, id_tecnico, fecha_orden, estado
FROM ordenes
WHERE estado <> 'aprobada';

-- 3. Que tecnico tiene mas ordenes.
SELECT t.nombre_tecnico, COUNT(*) AS total_ordenes
FROM tecnicos t
JOIN ordenes o ON o.id_tecnico = t.id_tecnico
GROUP BY t.id_tecnico, t.nombre_tecnico
ORDER BY total_ordenes DESC;

-- 4. Ordenes ordenadas por fecha.
SELECT id_orden, codigo_orden, fecha_orden, estado
FROM ordenes
ORDER BY fecha_orden;

-- 5. Cuanto genera cada tecnico en costo total (sin ordenes rechazadas),
--    para decisiones de carga de trabajo.
SELECT
    t.nombre_tecnico,
    t.certificacion,
    SUM(o.costo) AS costo_total
FROM tecnicos t
JOIN ordenes o ON o.id_tecnico = t.id_tecnico
WHERE o.estado <> 'rechazada'
GROUP BY t.id_tecnico, t.nombre_tecnico, t.certificacion
ORDER BY costo_total DESC;
