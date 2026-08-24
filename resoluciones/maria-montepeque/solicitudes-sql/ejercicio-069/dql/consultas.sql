.headers on
.mode column

-- Ejercicio 069: Diseno 3D Arquitectura
-- Consultas que responden preguntas reales del cliente.

-- 1. Que registros principales existen: todos los renders con su
-- proyecto y cliente.
SELECT r.id_render,
       pr.nombre AS proyecto,
       c.nombre AS cliente,
       r.nombre_archivo,
       r.estado
FROM renders r
JOIN proyectos pr ON pr.id_proyecto = r.id_proyecto
JOIN clientes c ON c.id_cliente = pr.id_cliente;

-- 2. Que registros estan en proceso, terminados o descartados.
SELECT id_render, nombre_archivo, estado
FROM renders
ORDER BY estado;

-- 3. Que proyecto tiene mas actividad (ranking por numero de
-- revisiones, el historico de auditoria).
SELECT pr.nombre AS proyecto,
       COUNT(*) AS total_revisiones
FROM revisiones rev
JOIN renders r ON r.id_render = rev.id_render
JOIN proyectos pr ON pr.id_proyecto = r.id_proyecto
GROUP BY pr.id_proyecto
ORDER BY total_revisiones DESC;

-- 4. Revisiones ordenadas por fecha, de la mas reciente a la mas
-- antigua.
SELECT id_revision, fecha_revision, aprobado
FROM revisiones
ORDER BY fecha_revision DESC;

-- 5. Reporte para decision de negocio: proyectos con renders aprobados
-- (al menos una revision con aprobado = 1), para saber cuales estan
-- listos para su proxima entrega (GROUP BY + HAVING).
SELECT pr.nombre AS proyecto,
       COUNT(DISTINCT r.id_render) AS renders_aprobados
FROM revisiones rev
JOIN renders r ON r.id_render = rev.id_render
JOIN proyectos pr ON pr.id_proyecto = r.id_proyecto
WHERE rev.aprobado = 1
GROUP BY pr.id_proyecto
HAVING COUNT(DISTINCT r.id_render) >= 1
ORDER BY renders_aprobados DESC;
