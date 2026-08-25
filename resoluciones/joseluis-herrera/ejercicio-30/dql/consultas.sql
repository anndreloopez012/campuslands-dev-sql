SELECT
    id_camper,
    nombre_completo,
    email,
    id_ruta,
    fecha_ingreso,
    estado
FROM campers;

SELECT
    nombre_completo,
    estado
FROM campers;

SELECT
    id_camper,
    nombre_completo,
    fecha_ingreso,
    estado
FROM campers
WHERE fecha_ingreso >= '2026-01-15';

SELECT
    id_camper,
    nombre_completo,
    fecha_ingreso
FROM campers
ORDER BY nombre_completo ASC;

SELECT
    c.id_camper,
    c.nombre_completo,
    AVG(e.nota) AS promedio
FROM campers AS c
INNER JOIN evaluaciones AS e
    ON e.id_camper = c.id_camper
GROUP BY c.id_camper, c.nombre_completo
ORDER BY promedio DESC
LIMIT 5;

SELECT COUNT(*) AS total_campers
FROM campers;

SELECT
    AVG(nota) AS promedio_general,
    MIN(nota) AS nota_minima,
    MAX(nota) AS nota_maxima
FROM evaluaciones;

SELECT
    r.nombre AS ruta,
    COUNT(c.id_camper) AS cantidad_campers
FROM rutas AS r
LEFT JOIN campers AS c
    ON c.id_ruta = r.id_ruta
GROUP BY r.id_ruta, r.nombre
ORDER BY cantidad_campers DESC;

SELECT
    c.nombre_completo AS camper,
    r.nombre AS ruta,
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

SELECT
    c.nombre_completo,
    AVG(e.nota) AS promedio
FROM campers AS c
INNER JOIN evaluaciones AS e
    ON e.id_camper = c.id_camper
WHERE c.estado = 'activo'
GROUP BY c.id_camper, c.nombre_completo
ORDER BY promedio DESC
LIMIT 5;

SELECT
    c.nombre_completo AS "Camper",
    r.nombre AS "Ruta",
    m.nombre AS "Modulo",
    t.nombre_completo AS "Trainer",
    e.nota AS "Nota",
    e.tipo AS "Evaluacion"
FROM evaluaciones AS e
INNER JOIN campers AS c
    ON c.id_camper = e.id_camper
INNER JOIN modulos AS m
    ON m.id_modulo = e.id_modulo
INNER JOIN rutas AS r
    ON r.id_ruta = m.id_ruta
INNER JOIN trainers AS t
    ON t.id_trainer = m.id_trainer
ORDER BY e.nota DESC;

SELECT
    m.nombre AS modulo,
    t.nombre_completo AS trainer,
    COUNT(e.id_evaluacion) AS evaluaciones,
    ROUND(AVG(e.nota), 2) AS promedio
FROM modulos AS m
INNER JOIN trainers AS t
    ON t.id_trainer = m.id_trainer
LEFT JOIN evaluaciones AS e
    ON e.id_modulo = m.id_modulo
GROUP BY m.id_modulo, m.nombre, t.nombre_completo
ORDER BY promedio DESC;

SELECT
    c.nombre_completo AS camper,
    COUNT(a.id_asistencia) AS total_registros,
    SUM(CASE WHEN a.estado = 'presente' THEN 1 ELSE 0 END) AS asistencias,
    ROUND(
        SUM(CASE WHEN a.estado = 'presente' THEN 1 ELSE 0 END) * 100.0
        / COUNT(a.id_asistencia),
        2
    ) AS porcentaje_asistencia
FROM campers AS c
INNER JOIN asistencias AS a
    ON a.id_camper = c.id_camper
GROUP BY c.id_camper, c.nombre_completo
ORDER BY porcentaje_asistencia DESC;

SELECT
    c.nombre_completo AS camper,
    r.nombre AS ruta,
    ROUND(AVG(e.nota), 2) AS promedio_notas,
    ROUND(
        SUM(CASE WHEN a.estado = 'presente' THEN 1 ELSE 0 END) * 100.0
        / COUNT(a.id_asistencia),
        2
    ) AS porcentaje_asistencia,
    CASE
        WHEN AVG(e.nota) >= 85
             AND SUM(CASE WHEN a.estado = 'presente' THEN 1 ELSE 0 END) * 100.0
                 / COUNT(a.id_asistencia) >= 80
            THEN 'Alto rendimiento'
        WHEN AVG(e.nota) >= 70
             AND SUM(CASE WHEN a.estado = 'presente' THEN 1 ELSE 0 END) * 100.0
                 / COUNT(a.id_asistencia) >= 70
            THEN 'Rendimiento medio'
        ELSE 'Requiere seguimiento'
    END AS recomendacion
FROM campers AS c
INNER JOIN rutas AS r
    ON r.id_ruta = c.id_ruta
INNER JOIN evaluaciones AS e
    ON e.id_camper = c.id_camper
INNER JOIN asistencias AS a
    ON a.id_camper = c.id_camper
WHERE c.estado = 'activo'
GROUP BY c.id_camper, c.nombre_completo, r.nombre
ORDER BY promedio_notas DESC;