.headers on
.mode column

-- Ejercicio 044: Diseno 3D Arquitectura
-- Consultas de validacion.

-- 1. Que registros principales existen (con JOIN doble: render,
--    proyecto y cliente).
SELECT
    r.id_render,
    cl.nombre_cliente,
    p.nombre_proyecto,
    r.nombre_render,
    r.fecha_entrega_estimada,
    r.estado
FROM renders r
JOIN proyectos p ON p.id_proyecto = r.id_proyecto
JOIN clientes cl ON cl.id_cliente = p.id_cliente;

-- 2. Que renders no estan aprobados todavia.
SELECT id_render, id_proyecto, fecha_entrega_estimada, estado
FROM renders
WHERE estado <> 'aprobado';

-- 3. Que cliente tiene mas renders en el estudio.
SELECT cl.nombre_cliente, COUNT(*) AS total_renders
FROM clientes cl
JOIN proyectos p ON p.id_cliente = cl.id_cliente
JOIN renders r ON r.id_proyecto = p.id_proyecto
GROUP BY cl.id_cliente, cl.nombre_cliente
ORDER BY total_renders DESC, cl.nombre_cliente;

-- 4. Renders ordenados por fecha de entrega estimada.
SELECT cl.nombre_cliente, p.nombre_proyecto, r.nombre_render, r.fecha_entrega_estimada
FROM renders r
JOIN proyectos p ON p.id_proyecto = r.id_proyecto
JOIN clientes cl ON cl.id_cliente = p.id_cliente
ORDER BY r.fecha_entrega_estimada;

-- 5. Reporte semanal: renders sin aprobar, ordenados por la fecha
--    mas urgente primero, para decidir en que enfocarse esta semana.
SELECT
    cl.nombre_cliente,
    p.nombre_proyecto,
    r.nombre_render,
    r.fecha_entrega_estimada,
    r.estado
FROM renders r
JOIN proyectos p ON p.id_proyecto = r.id_proyecto
JOIN clientes cl ON cl.id_cliente = p.id_cliente
WHERE r.estado <> 'aprobado'
ORDER BY r.fecha_entrega_estimada ASC;
