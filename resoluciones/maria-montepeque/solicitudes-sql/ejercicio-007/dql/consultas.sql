.headers on
.mode column

-- Ejercicio 007: Academia Kickboxing
-- Consultas de validacion.

-- 1. Que registros principales existen.
SELECT * FROM alumnos;

-- 2. Que registros estan activos, pendientes o finalizados (aqui:
--    alumnos que NO estan activos).
SELECT id_alumno, nombre_completo, id_plan, estado
FROM alumnos
WHERE estado <> 'activo';

-- 3. Que plan tiene mas alumnos activos.
SELECT p.nombre_plan, COUNT(*) AS alumnos_activos
FROM planes p
JOIN alumnos a ON a.id_plan = p.id_plan
WHERE a.estado = 'activo'
GROUP BY p.id_plan, p.nombre_plan
ORDER BY alumnos_activos DESC;

-- 4. Alumnos ordenados por fecha de inscripcion.
SELECT id_alumno, nombre_completo, fecha_inscripcion, estado
FROM alumnos
ORDER BY fecha_inscripcion;

-- 5. Reporte util para la academia: ingreso mensual estimado por plan
--    (solo alumnos activos), para decidir donde invertir.
SELECT
    p.nombre_plan,
    p.precio_mensual,
    COUNT(a.id_alumno) AS alumnos_activos,
    p.precio_mensual * COUNT(a.id_alumno) AS ingreso_mensual_estimado
FROM planes p
JOIN alumnos a ON a.id_plan = p.id_plan AND a.estado = 'activo'
GROUP BY p.id_plan, p.nombre_plan, p.precio_mensual
ORDER BY ingreso_mensual_estimado DESC;
