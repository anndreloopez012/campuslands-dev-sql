SELECT
    id_nota,
    id_estudiante,
    id_materia,
    id_profesor,
    nota,
    fecha_nota
FROM notas;

SELECT
    id_estudiante,
    id_materia
FROM notas;

SELECT
    id_nota,
    id_estudiante,
    nota,
    fecha_nota
FROM notas
WHERE nota >= 4.0;

SELECT
    id_nota,
    id_estudiante,
    nota,
    fecha_nota
FROM notas
ORDER BY fecha_nota DESC;

SELECT
    id_nota,
    id_estudiante,
    id_materia,
    nota
FROM notas
ORDER BY nota DESC
LIMIT 5;

SELECT
    COUNT(*) AS total_notas
FROM notas;

SELECT
    AVG(nota) AS promedio_general,
    MIN(nota) AS nota_minima,
    MAX(nota) AS nota_maxima
FROM notas;

SELECT
    id_materia,
    AVG(nota) AS promedio_materia,
    COUNT(*) AS cantidad_notas
FROM notas
GROUP BY id_materia
ORDER BY promedio_materia DESC;

SELECT
    e.nombre_completo AS estudiante,
    m.nombre AS materia,
    p.nombre_completo AS profesor,
    n.nota,
    n.fecha_nota
FROM notas AS n
JOIN estudiantes AS e
    ON n.id_estudiante = e.id_estudiante
JOIN materias AS m
    ON n.id_materia = m.id_materia
JOIN profesores AS p
    ON n.id_profesor = p.id_profesor;

SELECT
    e.nombre_completo AS estudiante,
    m.nombre AS materia,
    n.nota
FROM notas AS n
JOIN estudiantes AS e
    ON n.id_estudiante = e.id_estudiante
JOIN materias AS m
    ON n.id_materia = m.id_materia
WHERE n.nota >= 4.0
ORDER BY n.nota DESC
LIMIT 5;

SELECT
    e.nombre_completo AS estudiante,
    COUNT(n.id_nota) AS materias_cursadas,
    ROUND(AVG(n.nota), 2) AS promedio
FROM estudiantes AS e
JOIN notas AS n
    ON e.id_estudiante = n.id_estudiante
GROUP BY e.id_estudiante, e.nombre_completo
ORDER BY promedio DESC;

SELECT
    p.nombre_completo AS profesor,
    COUNT(n.id_nota) AS notas_registradas,
    ROUND(AVG(n.nota), 2) AS promedio_notas
FROM profesores AS p
JOIN notas AS n
    ON p.id_profesor = n.id_profesor
GROUP BY p.id_profesor, p.nombre_completo
ORDER BY notas_registradas DESC;

SELECT
    m.nombre AS materia,
    COUNT(n.id_nota) AS estudiantes_evaluados,
    ROUND(AVG(n.nota), 2) AS promedio,
    MIN(n.nota) AS nota_minima,
    MAX(n.nota) AS nota_maxima
FROM materias AS m
JOIN notas AS n
    ON m.id_materia = n.id_materia
GROUP BY m.id_materia, m.nombre
ORDER BY promedio DESC;

SELECT
    e.nombre_completo AS estudiante,
    ROUND(AVG(n.nota), 2) AS promedio,
    COUNT(n.id_nota) AS materias_evaluadas,
    CASE
        WHEN AVG(n.nota) >= 4.0 THEN 'Rendimiento excelente'
        WHEN AVG(n.nota) >= 3.0 THEN 'Rendimiento satisfactorio'
        ELSE 'Requiere acompanamiento'
    END AS decision_academica
FROM estudiantes AS e
JOIN notas AS n
    ON e.id_estudiante = n.id_estudiante
GROUP BY e.id_estudiante, e.nombre_completo
ORDER BY promedio DESC;