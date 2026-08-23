.headers on
.mode column

-- Ejercicio 059: Estudio Animacion 3D
-- Consultas de validacion.

-- 1. Que registros principales existen (con JOIN a proyecto, cliente
--    y artista).
SELECT
    t.id_tarea,
    p.nombre_proyecto,
    c.nombre_cliente,
    ar.nombre_artista,
    t.descripcion,
    t.fecha_asignacion,
    t.estado
FROM tareas t
JOIN proyectos p ON p.id_proyecto = t.id_proyecto
JOIN clientes c ON c.id_cliente = p.id_cliente
JOIN artistas ar ON ar.id_artista = t.id_artista;

-- 2. Que tareas no estan completadas todavia.
SELECT id_tarea, id_proyecto, id_artista, fecha_asignacion, estado
FROM tareas
WHERE estado <> 'completada';

-- 3. Que artista tiene mas tareas asignadas.
SELECT ar.nombre_artista, COUNT(*) AS total_tareas
FROM artistas ar
JOIN tareas t ON t.id_artista = ar.id_artista
GROUP BY ar.id_artista, ar.nombre_artista
ORDER BY total_tareas DESC, ar.nombre_artista;

-- 4. Tareas ordenadas por fecha de asignacion.
SELECT p.nombre_proyecto, ar.nombre_artista, t.descripcion, t.fecha_asignacion
FROM tareas t
JOIN proyectos p ON p.id_proyecto = t.id_proyecto
JOIN artistas ar ON ar.id_artista = t.id_artista
ORDER BY t.fecha_asignacion;

-- 5. Tareas 'en_progreso' ordenadas por fecha de ultimo cambio (las
--    mas antiguas sin actualizar primero), para decidir cuales
--    necesitan seguimiento urgente.
SELECT p.nombre_proyecto, ar.nombre_artista, t.descripcion, t.fecha_ultimo_cambio
FROM tareas t
JOIN proyectos p ON p.id_proyecto = t.id_proyecto
JOIN artistas ar ON ar.id_artista = t.id_artista
WHERE t.estado = 'en_progreso'
ORDER BY t.fecha_ultimo_cambio ASC;
