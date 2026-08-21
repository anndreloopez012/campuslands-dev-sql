.headers on
.mode column

-- Ejercicio 043: Escuela de Dibujo
-- Consultas de validacion.

-- 1. Que registros principales existen (con JOIN triple: alumno,
--    curso y profesor).
SELECT
    e.id_entrega,
    al.nombre_alumno,
    c.nombre_curso,
    p.nombre_profesor,
    e.fecha_entrega,
    e.calificacion,
    e.estado
FROM entregas e
JOIN alumnos al ON al.id_alumno = e.id_alumno
JOIN cursos c ON c.id_curso = e.id_curso
JOIN profesores p ON p.id_profesor = c.id_profesor;

-- 2. Que entregas no estan evaluadas todavia.
SELECT id_entrega, id_alumno, id_curso, fecha_entrega, estado
FROM entregas
WHERE estado <> 'evaluada';

-- 3. Que alumno tiene mas entregas registradas.
SELECT al.nombre_alumno, COUNT(*) AS total_entregas
FROM alumnos al
JOIN entregas e ON e.id_alumno = al.id_alumno
GROUP BY al.id_alumno, al.nombre_alumno
ORDER BY total_entregas DESC, al.nombre_alumno;

-- 4. Entregas ordenadas por fecha.
SELECT al.nombre_alumno, c.nombre_curso, e.fecha_entrega
FROM entregas e
JOIN alumnos al ON al.id_alumno = e.id_alumno
JOIN cursos c ON c.id_curso = e.id_curso
ORDER BY e.fecha_entrega;

-- 5. Que curso tiene el promedio de calificacion mas bajo (solo
--    entregas evaluadas), para decidir cual necesita refuerzo
--    pedagogico primero.
SELECT c.nombre_curso, ROUND(AVG(e.calificacion), 2) AS promedio_calificacion
FROM cursos c
JOIN entregas e ON e.id_curso = c.id_curso
WHERE e.estado = 'evaluada'
GROUP BY c.id_curso, c.nombre_curso
ORDER BY promedio_calificacion ASC;
