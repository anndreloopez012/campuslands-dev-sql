-- Ejercicio 30: Proyecto Integrador SQL
-- Entidad central: evaluaciones

-- 1. Listar todos los registros principales de la entidad central
SELECT * FROM evaluaciones;

-- 2. Mostrar solo dos columnas relevantes
SELECT nota, fecha FROM evaluaciones;

-- 3. Filtrar registros por una condicion numerica
SELECT * FROM evaluaciones WHERE nota >= 85;

-- 4. Ordenar resultados por fecha
SELECT * FROM evaluaciones ORDER BY fecha;

-- 5. Mostrar las 5 notas mas altas
SELECT * FROM evaluaciones ORDER BY nota DESC LIMIT 5;

-- 6. Contar registros totales
SELECT COUNT(*) AS total_evaluaciones FROM evaluaciones;

-- 7. Promedio, minimo y maximo de las notas
SELECT
    AVG(nota) AS promedio,
    MIN(nota) AS minimo,
    MAX(nota) AS maximo
FROM evaluaciones;

-- 8. Agrupar evaluaciones por modulo
SELECT id_modulo, COUNT(*) AS cantidad_evaluaciones, AVG(nota) AS promedio_modulo
FROM evaluaciones
GROUP BY id_modulo;

-- 9. Relacionar evaluaciones, campers y modulos con JOIN
SELECT e.id_evaluacion, c.nombre AS camper, m.nombre AS modulo
FROM evaluaciones e
JOIN campers c ON c.id_camper = e.id_camper
JOIN modulos m ON m.id_modulo = e.id_modulo;

-- 10. WHERE + ORDER BY + LIMIT
SELECT * FROM evaluaciones
WHERE nota >= 80
ORDER BY nota DESC
LIMIT 3;

-- 11. Reporte con alias legibles
SELECT
    c.nombre AS camper,
    r.nombre AS ruta,
    m.nombre AS modulo,
    t.nombre AS trainer,
    e.nota AS nota_obtenida,
    e.fecha AS fecha_evaluacion
FROM evaluaciones e
JOIN campers c ON c.id_camper = e.id_camper
JOIN rutas r ON r.id_ruta = c.id_ruta
JOIN modulos m ON m.id_modulo = e.id_modulo
JOIN trainers t ON t.id_trainer = m.id_trainer;

-- 12. Consulta para decision de negocio: camper con el mejor promedio general,
-- cruzando ademas su porcentaje de asistencia (presente + tardanza) como referencia
SELECT
    c.nombre AS camper,
    ROUND(AVG(e.nota), 2) AS promedio_notas,
    (SELECT COUNT(*) FROM asistencias a WHERE a.id_camper = c.id_camper AND a.estado != 'ausente') * 1.0
        / NULLIF((SELECT COUNT(*) FROM asistencias a WHERE a.id_camper = c.id_camper), 0) AS porcentaje_asistencia
FROM evaluaciones e
JOIN campers c ON c.id_camper = e.id_camper
GROUP BY c.nombre
ORDER BY promedio_notas DESC
LIMIT 1;
