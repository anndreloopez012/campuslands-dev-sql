PRAGMA foreign_keys = ON;

-- 1. LISTAR TODOS LOS REGISTROS PRINCIPALES

SELECT
    id_camper,
    nombre_completo,
    correo,
    telefono,
    fecha_ingreso,
    estado
FROM campers;

-- 2. MOSTRAR DOS COLUMNAS RELEVANTES

SELECT
    nombre_completo,
    estado
FROM campers;

-- 3. FILTRAR POR CONDICION NUMERICA

SELECT
    id_evaluacion,
    id_camper,
    id_modulo,
    nota,
    tipo
FROM evaluaciones
WHERE nota >= 90
ORDER BY nota DESC;

-- 4. ORDENAR RESULTADOS POR FECHA

SELECT
    id_camper,
    nombre_completo,
    fecha_ingreso,
    estado
FROM campers
ORDER BY fecha_ingreso ASC;

-- 5. CINCO EVALUACIONES CON MAYOR NOTA

SELECT
    id_evaluacion,
    id_camper,
    id_modulo,
    nota,
    tipo
FROM evaluaciones
ORDER BY nota DESC
LIMIT 5;

-- 6. CONTAR CAMPERS

SELECT
    COUNT(*) AS total_campers
FROM campers;

-- 7. ESTADISTICAS DE EVALUACIONES

SELECT
    ROUND(AVG(nota), 2) AS promedio_notas,
    MIN(nota) AS nota_minima,
    MAX(nota) AS nota_maxima
FROM evaluaciones;

-- 8. AGRUPAR EVALUACIONES POR MODULO

SELECT
    m.nombre AS modulo,
    COUNT(e.id_evaluacion) AS total_evaluaciones,
    ROUND(AVG(e.nota), 2) AS promedio_nota
FROM modulos AS m
INNER JOIN evaluaciones AS e
    ON e.id_modulo = m.id_modulo
GROUP BY
    m.id_modulo,
    m.nombre
ORDER BY promedio_nota DESC;

-- 9. RELACIONAR CAMPERS, RUTAS Y MODULOS

SELECT
    c.nombre_completo AS camper,
    r.nombre AS ruta,
    m.nombre AS modulo,
    e.nota,
    e.tipo
FROM evaluaciones AS e
INNER JOIN campers AS c
    ON c.id_camper = e.id_camper
INNER JOIN modulos AS m
    ON m.id_modulo = e.id_modulo
INNER JOIN rutas AS r
    ON r.id_ruta = m.id_ruta
ORDER BY e.nota DESC;

-- 10. WHERE + ORDER BY + LIMIT

SELECT
    c.nombre_completo AS camper,
    e.nota,
    e.fecha_evaluacion
FROM evaluaciones AS e
INNER JOIN campers AS c
    ON c.id_camper = e.id_camper
WHERE e.nota >= 80
ORDER BY e.nota DESC
LIMIT 5;

-- 11. REPORTE ACADEMICO CON ALIAS

SELECT
    c.nombre_completo AS 'Camper',
    r.nombre AS 'Ruta',
    t.nombre_completo AS 'Trainer',
    m.nombre AS 'Modulo',
    e.nota AS 'Nota',
    e.tipo AS 'Tipo Evaluacion',
    e.fecha_evaluacion AS 'Fecha Evaluacion'
FROM evaluaciones AS e
INNER JOIN campers AS c
    ON c.id_camper = e.id_camper
INNER JOIN modulos AS m
    ON m.id_modulo = e.id_modulo
INNER JOIN rutas AS r
    ON r.id_ruta = m.id_ruta
INNER JOIN trainers AS t
    ON t.id_trainer = r.id_trainer
ORDER BY c.nombre_completo, e.fecha_evaluacion;

-- 12. DECISION DE NEGOCIO: CAMPERS EN RIESGO ACADEMICO

SELECT
    c.nombre_completo AS camper,
    COUNT(e.id_evaluacion) AS evaluaciones,
    ROUND(AVG(e.nota), 2) AS promedio,
    CASE
        WHEN AVG(e.nota) < 70 THEN 'Riesgo alto'
        WHEN AVG(e.nota) < 80 THEN 'Riesgo medio'
        ELSE 'Rendimiento adecuado'
    END AS nivel_riesgo,
    CASE
        WHEN AVG(e.nota) < 70 THEN 'Asignar acompanamiento academico'
        WHEN AVG(e.nota) < 80 THEN 'Realizar seguimiento'
        ELSE 'Mantener seguimiento normal'
    END AS decision
FROM campers AS c
INNER JOIN evaluaciones AS e
    ON e.id_camper = c.id_camper
GROUP BY
    c.id_camper,
    c.nombre_completo
ORDER BY promedio ASC;

-- REPORTE DE ASISTENCIA

SELECT
    c.nombre_completo AS camper,
    COUNT(a.id_asistencia) AS total_registros,
    SUM(CASE WHEN a.estado = 'Presente' THEN 1 ELSE 0 END) AS presentes,
    SUM(CASE WHEN a.estado = 'Ausente' THEN 1 ELSE 0 END) AS ausencias,
    SUM(CASE WHEN a.estado = 'Justificada' THEN 1 ELSE 0 END) AS justificadas,
    ROUND(
        100.0 * SUM(
            CASE WHEN a.estado = 'Presente' THEN 1 ELSE 0 END
        ) / COUNT(a.id_asistencia),
        2
    ) AS porcentaje_asistencia
FROM campers AS c
INNER JOIN asistencias AS a
    ON a.id_camper = c.id_camper
GROUP BY
    c.id_camper,
    c.nombre_completo
ORDER BY porcentaje_asistencia DESC;

-- RENDIMIENTO POR RUTA

SELECT
    r.nombre AS ruta,
    t.nombre_completo AS trainer,
    COUNT(e.id_evaluacion) AS evaluaciones_realizadas,
    ROUND(AVG(e.nota), 2) AS promedio_ruta,
    MAX(e.nota) AS mejor_nota,
    MIN(e.nota) AS menor_nota
FROM rutas AS r
INNER JOIN trainers AS t
    ON t.id_trainer = r.id_trainer
INNER JOIN modulos AS m
    ON m.id_ruta = r.id_ruta
INNER JOIN evaluaciones AS e
    ON e.id_modulo = m.id_modulo
GROUP BY
    r.id_ruta,
    r.nombre,
    t.nombre_completo
ORDER BY promedio_ruta DESC;

-- MODULOS CON RENDIMIENTO INFERIOR A 85

SELECT
    m.nombre AS modulo,
    r.nombre AS ruta,
    ROUND(AVG(e.nota), 2) AS promedio
FROM modulos AS m
INNER JOIN rutas AS r
    ON r.id_ruta = m.id_ruta
INNER JOIN evaluaciones AS e
    ON e.id_modulo = m.id_modulo
GROUP BY
    m.id_modulo,
    m.nombre,
    r.nombre
HAVING AVG(e.nota) < 85
ORDER BY promedio ASC;