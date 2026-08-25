-- 1. Reconstruir una vista similar al archivo original

SELECT
    e.nombre_completo AS estudiante,
    e.documento,
    r.nombre AS ruta,
    t.nombre_completo AS trainer,
    GROUP_CONCAT(m.nombre, ', ') AS modulos,
    GROUP_CONCAT(m.horario, ', ') AS horarios,
    GROUP_CONCAT(n.nota, ', ') AS notas
FROM matriculas ma
JOIN estudiantes e
    ON ma.id_estudiante = e.id_estudiante
JOIN rutas r
    ON ma.id_ruta = r.id_ruta
JOIN trainers t
    ON ma.id_trainer = t.id_trainer
JOIN notas n
    ON ma.id_matricula = n.id_matricula
JOIN modulos m
    ON n.id_modulo = m.id_modulo
GROUP BY ma.id_matricula
ORDER BY e.nombre_completo;

-- 2. Listar entidades principales sin duplicados

SELECT DISTINCT
    nombre_completo AS estudiante
FROM estudiantes
ORDER BY estudiante;

SELECT DISTINCT
    nombre AS ruta
FROM rutas
ORDER BY ruta;

SELECT DISTINCT
    nombre_completo AS trainer
FROM trainers
ORDER BY trainer;

-- 3. Contar registros por ruta y estado

SELECT
    r.nombre AS ruta,
    ma.estado,
    COUNT(*) AS cantidad_matriculas
FROM matriculas ma
JOIN rutas r
    ON ma.id_ruta = r.id_ruta
GROUP BY r.id_ruta, r.nombre, ma.estado
ORDER BY r.nombre, ma.estado;

-- 4. Calcular un total por transaccion academica

SELECT
    ma.id_matricula,
    e.nombre_completo AS estudiante,
    COUNT(n.id_modulo) AS modulos_calificados,
    ROUND(AVG(n.nota), 2) AS promedio_notas
FROM matriculas ma
JOIN estudiantes e
    ON ma.id_estudiante = e.id_estudiante
JOIN notas n
    ON ma.id_matricula = n.id_matricula
GROUP BY ma.id_matricula, e.nombre_completo
ORDER BY ma.id_matricula;

-- 5. Calcular promedio, minimo y maximo

SELECT
    ROUND(AVG(nota), 2) AS nota_promedio,
    MIN(nota) AS nota_minima,
    MAX(nota) AS nota_maxima
FROM notas;

-- 6. Buscar registros por texto con LIKE

SELECT
    id_estudiante,
    nombre_completo,
    documento
FROM estudiantes
WHERE nombre_completo LIKE '%Ana%'
ORDER BY nombre_completo;

-- 7. Filtrar por fecha o rango numerico

SELECT
    id_matricula,
    id_estudiante,
    id_ruta,
    fecha_matricula
FROM matriculas
WHERE fecha_matricula BETWEEN '2026-01-01' AND '2026-01-31'
ORDER BY fecha_matricula;

SELECT
    id_matricula,
    id_modulo,
    nota
FROM notas
WHERE nota BETWEEN 80 AND 100
ORDER BY nota DESC;

-- 8. Top 5 por cantidad o promedio

SELECT
    e.nombre_completo AS estudiante,
    COUNT(n.id_modulo) AS modulos_calificados,
    ROUND(AVG(n.nota), 2) AS promedio
FROM matriculas ma
JOIN estudiantes e
    ON ma.id_estudiante = e.id_estudiante
JOIN notas n
    ON ma.id_matricula = n.id_matricula
GROUP BY ma.id_matricula, e.nombre_completo
ORDER BY promedio DESC
LIMIT 5;

-- 9. Detectar matriculas relacionadas sin detalle

SELECT
    ma.id_matricula,
    e.nombre_completo AS estudiante,
    r.nombre AS ruta,
    ma.fecha_matricula
FROM matriculas ma
JOIN estudiantes e
    ON ma.id_estudiante = e.id_estudiante
JOIN rutas r
    ON ma.id_ruta = r.id_ruta
LEFT JOIN notas n
    ON ma.id_matricula = n.id_matricula
WHERE n.id_matricula IS NULL;

-- 10. Reporte final con alias legibles

SELECT
    ma.id_matricula AS matricula,
    e.nombre_completo AS estudiante,
    e.documento AS documento,
    r.nombre AS ruta_academica,
    t.nombre_completo AS trainer,
    r.jornada AS jornada,
    ma.fecha_matricula AS fecha_matricula,
    ma.estado AS estado,
    COUNT(n.id_modulo) AS modulos_evaluados,
    ROUND(AVG(n.nota), 2) AS promedio_final
FROM matriculas ma
JOIN estudiantes e
    ON ma.id_estudiante = e.id_estudiante
JOIN rutas r
    ON ma.id_ruta = r.id_ruta
JOIN trainers t
    ON ma.id_trainer = t.id_trainer
LEFT JOIN notas n
    ON ma.id_matricula = n.id_matricula
GROUP BY
    ma.id_matricula,
    e.nombre_completo,
    e.documento,
    r.nombre,
    t.nombre_completo,
    r.jornada,
    ma.fecha_matricula,
    ma.estado
ORDER BY ma.fecha_matricula;

-- Consulta adicional por estado del estudiante

SELECT
    estado,
    COUNT(*) AS cantidad_estudiantes
FROM estudiantes
GROUP BY estado
ORDER BY cantidad_estudiantes DESC;