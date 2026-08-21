.headers on
.mode column

-- Ejercicio 018: Escuela de Dibujo
-- Consultas de validacion.

-- 1. Que registros principales existen.
SELECT * FROM entregas;

-- 2. Casos pendientes (tal como pidio el cliente explicitamente).
SELECT id_entrega, id_curso, nombre_alumno, fecha_entrega
FROM entregas
WHERE estado = 'pendiente';

-- 3. Que alumno tiene mas entregas.
SELECT nombre_alumno, COUNT(*) AS total_entregas
FROM entregas
GROUP BY nombre_alumno
ORDER BY total_entregas DESC;

-- 4. Entregas ordenadas por fecha.
SELECT id_entrega, nombre_alumno, fecha_entrega, estado
FROM entregas
ORDER BY fecha_entrega;

-- 5. Totales: promedio de calificacion por curso (ranking de cursos),
--    solo entregas evaluadas, para decidir cuales reforzar.
SELECT
    c.nombre_curso,
    c.nivel,
    ROUND(AVG(e.calificacion), 1) AS promedio_calificacion
FROM cursos c
JOIN entregas e ON e.id_curso = c.id_curso
WHERE e.estado = 'evaluada'
GROUP BY c.id_curso, c.nombre_curso, c.nivel
ORDER BY promedio_calificacion DESC;
