PRAGMA foreign_keys = ON;

-- =========================================================
-- 1. Listar todos los registros principales
-- Entidad central: matriculas
-- =========================================================

SELECT
    id_matricula,
    id_estudiante,
    id_curso,
    id_instructor,
    fecha_matricula,
    progreso,
    estado
FROM matriculas;

-- =========================================================
-- 2. Mostrar solo dos columnas relevantes
-- =========================================================

SELECT
    fecha_matricula,
    progreso
FROM matriculas;

-- =========================================================
-- 3. Filtrar por condición numérica
-- Matrículas con progreso igual o superior al 80%.
-- =========================================================

SELECT
    id_matricula,
    id_estudiante,
    id_curso,
    progreso
FROM matriculas
WHERE progreso >= 80;

-- =========================================================
-- 4. Ordenar resultados por fecha
-- =========================================================

SELECT
    id_matricula,
    fecha_matricula,
    progreso
FROM matriculas
ORDER BY fecha_matricula DESC;

-- =========================================================
-- 5. Top 5 estudiantes según promedio de progreso
-- =========================================================

SELECT
    e.nombre_completo,
    ROUND(AVG(m.progreso), 2) AS promedio_progreso
FROM estudiantes AS e
INNER JOIN matriculas AS m
    ON e.id_estudiante = m.id_estudiante
GROUP BY
    e.id_estudiante,
    e.nombre_completo
ORDER BY promedio_progreso DESC
LIMIT 5;

-- =========================================================
-- 6. Contar registros totales
-- =========================================================

SELECT
    COUNT(*) AS total_matriculas
FROM matriculas;

-- =========================================================
-- 7. Promedio, mínimo y máximo del progreso
-- =========================================================

SELECT
    ROUND(AVG(progreso), 2) AS progreso_promedio,
    MIN(progreso) AS progreso_minimo,
    MAX(progreso) AS progreso_maximo
FROM matriculas;

-- =========================================================
-- 8. Agrupar matrículas por estado
-- =========================================================

SELECT
    estado,
    COUNT(*) AS cantidad_matriculas,
    ROUND(AVG(progreso), 2) AS progreso_promedio
FROM matriculas
GROUP BY estado
ORDER BY cantidad_matriculas DESC;

-- =========================================================
-- 9. Relacionar mínimo dos tablas con JOIN
-- Mostrar estudiantes y sus cursos.
-- =========================================================

SELECT
    e.nombre_completo AS estudiante,
    c.nombre AS curso,
    m.progreso,
    m.estado
FROM matriculas AS m
INNER JOIN estudiantes AS e
    ON m.id_estudiante = e.id_estudiante
INNER JOIN cursos AS c
    ON m.id_curso = c.id_curso
ORDER BY e.nombre_completo;

-- =========================================================
-- 10. WHERE + ORDER BY + LIMIT
-- Buscar los estudiantes con mayor progreso activo.
-- =========================================================

SELECT
    e.nombre_completo AS estudiante,
    c.nombre AS curso,
    m.progreso
FROM matriculas AS m
INNER JOIN estudiantes AS e
    ON m.id_estudiante = e.id_estudiante
INNER JOIN cursos AS c
    ON m.id_curso = c.id_curso
WHERE m.estado = 'ACTIVA'
ORDER BY m.progreso DESC
LIMIT 5;

-- =========================================================
-- 11. Reporte con alias legibles
-- =========================================================

SELECT
    m.id_matricula AS 'ID Matricula',
    e.nombre_completo AS 'Estudiante',
    c.nombre AS 'Curso',
    i.nombre_completo AS 'Instructor',
    m.fecha_matricula AS 'Fecha de Matricula',
    m.progreso AS 'Progreso Porcentaje',
    m.estado AS 'Estado'
FROM matriculas AS m
INNER JOIN estudiantes AS e
    ON m.id_estudiante = e.id_estudiante
INNER JOIN cursos AS c
    ON m.id_curso = c.id_curso
INNER JOIN instructores AS i
    ON m.id_instructor = i.id_instructor
ORDER BY m.fecha_matricula;

-- =========================================================
-- 12. Consulta para apoyar una decisión de negocio
--
-- Identificar cursos que requieren seguimiento.
-- Se consideran prioritarios aquellos que:
--   - tengan estudiantes activos
--   - tengan progreso promedio inferior al 70%
-- =========================================================

SELECT
    c.nombre AS 'Curso',
    COUNT(m.id_matricula) AS 'Estudiantes Activos',
    ROUND(AVG(m.progreso), 2) AS 'Progreso Promedio',
    CASE
        WHEN AVG(m.progreso) < 50
            THEN 'Intervencion academica urgente'
        WHEN AVG(m.progreso) < 70
            THEN 'Requiere seguimiento'
        ELSE 'Rendimiento satisfactorio'
    END AS 'Recomendacion'
FROM cursos AS c
INNER JOIN matriculas AS m
    ON c.id_curso = m.id_curso
WHERE m.estado = 'ACTIVA'
GROUP BY
    c.id_curso,
    c.nombre
ORDER BY
    AVG(m.progreso) ASC;