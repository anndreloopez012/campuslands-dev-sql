.headers on
.mode column

-- Ejercicio 019: Diseno 3D Arquitectura
-- Consultas de validacion.

-- 1. Que registros principales existen (el historico completo).
SELECT * FROM eventos;

-- 2. Que eventos siguen pendientes de revision.
SELECT id_evento, id_proyecto, tipo_evento, fecha_evento
FROM eventos
WHERE estado = 'pendiente';

-- 3. Que proyecto tiene mas eventos registrados en su historico.
SELECT p.nombre_proyecto, COUNT(*) AS total_eventos
FROM proyectos p
JOIN eventos e ON e.id_proyecto = p.id_proyecto
GROUP BY p.id_proyecto, p.nombre_proyecto
ORDER BY total_eventos DESC;

-- 4. Historico ordenado cronologicamente: que paso y cuando paso.
SELECT id_evento, id_proyecto, tipo_evento, fecha_evento, estado
FROM eventos
ORDER BY fecha_evento;

-- 5. Ultimo evento registrado de cada proyecto, para saber en que quedo
--    cada uno sin revisar todo el historico (respuesta directa a la
--    pregunta de auditoria del cliente).
SELECT
    p.nombre_proyecto,
    e.tipo_evento,
    e.fecha_evento,
    e.estado
FROM proyectos p
JOIN eventos e ON e.id_proyecto = p.id_proyecto
WHERE e.fecha_evento = (
    SELECT MAX(fecha_evento) FROM eventos WHERE id_proyecto = p.id_proyecto
)
ORDER BY p.nombre_proyecto;
