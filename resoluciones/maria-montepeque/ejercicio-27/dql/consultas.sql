-- Ejercicio 27: Indices y Busquedas
-- Entidad central: inscripciones

-- 1. Listar todos los registros principales de la entidad central
SELECT * FROM inscripciones;

-- 2. Mostrar solo dos columnas relevantes
SELECT estudiante_nombre, estado FROM inscripciones;

-- 3. Filtrar registros por una condicion de fecha
SELECT * FROM inscripciones WHERE fecha_inscripcion >= '2026-07-08';

-- 4. Ordenar resultados alfabeticamente por estudiante
SELECT * FROM inscripciones ORDER BY estudiante_nombre;

-- 5. Mostrar los 5 cursos con mas inscripciones
SELECT id_curso, COUNT(*) AS total_inscripciones
FROM inscripciones
GROUP BY id_curso
ORDER BY total_inscripciones DESC
LIMIT 5;

-- 6. Contar registros totales
SELECT COUNT(*) AS total_inscripciones FROM inscripciones;

-- 7. Contar inscripciones por estado (frecuencia de cada estado)
SELECT estado, COUNT(*) AS cantidad
FROM inscripciones
GROUP BY estado;

-- 8. Agrupar inscripciones por curso y estado
SELECT id_curso, estado, COUNT(*) AS cantidad
FROM inscripciones
GROUP BY id_curso, estado;

-- 9. Relacionar inscripciones, cursos e instructores con JOIN
SELECT i.id_inscripcion, c.nombre AS curso, ins.nombre AS instructor
FROM inscripciones i
JOIN cursos c ON c.id_curso = i.id_curso
JOIN instructores ins ON ins.id_instructor = c.id_instructor;

-- 10. WHERE + ORDER BY + LIMIT
SELECT * FROM inscripciones
WHERE estado = 'completado'
ORDER BY fecha_inscripcion DESC
LIMIT 3;

-- 11. Reporte con alias legibles
SELECT
    i.estudiante_nombre AS estudiante,
    c.nombre AS curso,
    cat.nombre AS categoria,
    ins.nombre AS instructor,
    i.estado AS estado_inscripcion,
    i.fecha_inscripcion AS fecha_inscripcion
FROM inscripciones i
JOIN cursos c ON c.id_curso = i.id_curso
JOIN categorias cat ON cat.id_categoria = c.id_categoria
JOIN instructores ins ON ins.id_instructor = c.id_instructor;

-- 12. Consulta para decision de negocio: curso con mayores ingresos por inscripciones completadas
SELECT c.nombre, SUM(c.precio) AS total_ingresos
FROM inscripciones i
JOIN cursos c ON c.id_curso = i.id_curso
WHERE i.estado = 'completado'
GROUP BY c.nombre
ORDER BY total_ingresos DESC
LIMIT 1;

-- Verificacion de uso de indices (busqueda por correo del estudiante, cubierta por idx_inscripciones_estudiante_correo)
EXPLAIN QUERY PLAN
SELECT * FROM inscripciones WHERE estudiante_correo = 'manuel.estrada@correo.com';
