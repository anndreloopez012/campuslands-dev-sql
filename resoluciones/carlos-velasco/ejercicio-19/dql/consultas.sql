.headers on
.mode column

-- 1. LISTAR TODOS LOS REGISTROS DE LA ENTIDAD CENTRAL

SELECT
    id_nota,
    id_estudiante,
    id_materia,
    calificacion,
    fecha_evaluacion,
    tipo_evaluacion
FROM notas;

-- 2. DOS COLUMNAS RELEVANTES

SELECT
    id_estudiante,
    calificacion
FROM notas;

-- 3. FILTRAR POR CONDICION NUMERICA

SELECT
    id_nota,
    id_estudiante,
    calificacion
FROM notas
WHERE calificacion >= 4.0;

-- 4. ORDENAR RESULTADOS POR CALIFICACION

SELECT
    id_estudiante,
    id_materia,
    calificacion
FROM notas
ORDER BY calificacion DESC;

-- 5. CINCO MEJORES CALIFICACIONES

SELECT
    id_estudiante,
    id_materia,
    calificacion
FROM notas
ORDER BY calificacion DESC
LIMIT 5;

-- 6. CONTAR REGISTROS TOTALES

SELECT COUNT(*) AS total_notas
FROM notas;

-- 7. PROMEDIO, MINIMO Y MAXIMO

SELECT
    ROUND(AVG(calificacion), 2) AS promedio_general,
    MIN(calificacion) AS calificacion_minima,
    MAX(calificacion) AS calificacion_maxima
FROM notas;

-- 8. AGRUPAR POR MATERIA

SELECT
    m.nombre AS materia,
    COUNT(n.id_nota) AS cantidad_notas,
    ROUND(AVG(n.calificacion), 2) AS promedio_materia
FROM materias AS m
LEFT JOIN notas AS n
    ON n.id_materia = m.id_materia
GROUP BY m.id_materia, m.nombre
ORDER BY promedio_materia DESC;

-- 9. RELACIONAR ESTUDIANTES Y NOTAS

SELECT
    e.nombre_completo AS estudiante,
    m.nombre AS materia,
    n.calificacion,
    n.tipo_evaluacion
FROM notas AS n
INNER JOIN estudiantes AS e
    ON e.id_estudiante = n.id_estudiante
INNER JOIN materias AS m
    ON m.id_materia = n.id_materia
ORDER BY e.nombre_completo, m.nombre;

-- 10. WHERE, ORDER BY Y LIMIT

SELECT
    e.nombre_completo AS estudiante,
    m.nombre AS materia,
    n.calificacion
FROM notas AS n
INNER JOIN estudiantes AS e
    ON e.id_estudiante = n.id_estudiante
INNER JOIN materias AS m
    ON m.id_materia = n.id_materia
WHERE n.calificacion >= 4.0
ORDER BY n.calificacion DESC
LIMIT 5;

-- 11. REPORTE ACADEMICO CON ALIAS

SELECT
    e.nombre_completo AS estudiante,
    m.nombre AS asignatura,
    p.nombre_completo AS profesor,
    n.calificacion AS nota_obtenida,
    n.tipo_evaluacion AS evaluacion,
    n.fecha_evaluacion AS fecha
FROM notas AS n
INNER JOIN estudiantes AS e
    ON e.id_estudiante = n.id_estudiante
INNER JOIN materias AS m
    ON m.id_materia = n.id_materia
INNER JOIN profesores AS p
    ON p.id_profesor = m.id_profesor
ORDER BY e.nombre_completo, n.fecha_evaluacion;

-- 12. DECISION DE NEGOCIO: ESTUDIANTES EN RIESGO ACADEMICO

SELECT
    e.nombre_completo AS estudiante,
    ROUND(AVG(n.calificacion), 2) AS promedio,
    COUNT(n.id_nota) AS evaluaciones,
    CASE
        WHEN AVG(n.calificacion) < 3.0 THEN 'RIESGO ALTO'
        WHEN AVG(n.calificacion) < 3.5 THEN 'REQUIERE SEGUIMIENTO'
        ELSE 'DESEMPEÑO SATISFACTORIO'
    END AS decision_academica
FROM estudiantes AS e
INNER JOIN notas AS n
    ON n.id_estudiante = e.id_estudiante
GROUP BY e.id_estudiante, e.nombre_completo
ORDER BY promedio ASC;

-- REPORTE DE RENDIMIENTO POR PROFESOR

SELECT
    p.nombre_completo AS profesor,
    m.nombre AS materia,
    COUNT(n.id_nota) AS evaluaciones,
    ROUND(AVG(n.calificacion), 2) AS promedio
FROM profesores AS p
INNER JOIN materias AS m
    ON m.id_profesor = p.id_profesor
INNER JOIN notas AS n
    ON n.id_materia = m.id_materia
GROUP BY p.id_profesor, p.nombre_completo, m.id_materia, m.nombre
ORDER BY promedio DESC;