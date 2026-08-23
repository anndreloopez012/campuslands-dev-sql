.headers on
.mode column

-- Ejercicio 057: Academia Kickboxing
-- Consultas de validacion.

-- 1. Que registros principales existen (con JOIN doble para mostrar el
--    alumno y el entrenador en vez de solo los id).
SELECT
    a.id_asistencia,
    al.nombre_alumno,
    e.nombre_entrenador,
    a.fecha_clase,
    a.estado
FROM asistencias a
JOIN alumnos al ON al.id_alumno = a.id_alumno
JOIN entrenadores e ON e.id_entrenador = a.id_entrenador;

-- 2. Que asistencias no estan marcadas como presente todavia.
SELECT id_asistencia, id_alumno, fecha_clase, estado
FROM asistencias
WHERE estado <> 'presente';

-- 3. Que alumno tiene mas asistencias registradas.
SELECT al.nombre_alumno, COUNT(*) AS total_asistencias
FROM alumnos al
JOIN asistencias a ON a.id_alumno = al.id_alumno
GROUP BY al.id_alumno, al.nombre_alumno
ORDER BY total_asistencias DESC, al.nombre_alumno;

-- 4. Asistencias ordenadas por fecha.
SELECT al.nombre_alumno, e.nombre_entrenador, a.fecha_clase
FROM asistencias a
JOIN alumnos al ON al.id_alumno = a.id_alumno
JOIN entrenadores e ON e.id_entrenador = a.id_entrenador
ORDER BY a.fecha_clase;

-- 5. Porcentaje de asistencia por alumno (presente + justificada
--    sobre el total), para decidir a quien contactar por riesgo de
--    desercion.
SELECT
    al.nombre_alumno,
    COUNT(*) AS total_clases,
    SUM(CASE WHEN a.estado = 'ausente' THEN 1 ELSE 0 END) AS ausencias,
    ROUND(100.0 * SUM(CASE WHEN a.estado IN ('presente', 'justificada') THEN 1 ELSE 0 END) / COUNT(*), 1) AS porcentaje_asistencia
FROM alumnos al
JOIN asistencias a ON a.id_alumno = al.id_alumno
GROUP BY al.id_alumno, al.nombre_alumno
ORDER BY porcentaje_asistencia ASC;
