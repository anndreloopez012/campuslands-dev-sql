-- Ejercicio 19: Universidad Notas
-- Entidad central: notas

-- 1. Listar todos los registros principales de la entidad central
SELECT * FROM notas;

-- 2. Mostrar solo dos columnas relevantes
SELECT nota, fecha FROM notas;

-- 3. Filtrar registros por una condicion numerica
SELECT * FROM notas WHERE nota >= 80;

-- 4. Ordenar resultados por fecha
SELECT * FROM notas ORDER BY fecha;

-- 5. Mostrar las 5 notas mas altas
SELECT * FROM notas ORDER BY nota DESC LIMIT 5;

-- 6. Contar registros totales
SELECT COUNT(*) AS total_notas FROM notas;

-- 7. Promedio, minimo y maximo de las notas
SELECT
    AVG(nota) AS promedio,
    MIN(nota) AS minimo,
    MAX(nota) AS maximo
FROM notas;

-- 8. Agrupar notas por materia
SELECT id_materia, COUNT(*) AS cantidad_notas, AVG(nota) AS promedio_materia
FROM notas
GROUP BY id_materia;

-- 9. Relacionar notas, estudiantes y materias con JOIN
SELECT n.id_nota, e.nombre AS estudiante, m.nombre AS materia
FROM notas n
JOIN estudiantes e ON e.id_estudiante = n.id_estudiante
JOIN materias m ON m.id_materia = n.id_materia;

-- 10. WHERE + ORDER BY + LIMIT
SELECT * FROM notas
WHERE nota >= 70
ORDER BY nota DESC
LIMIT 3;

-- 11. Reporte con alias legibles
SELECT
    e.nombre AS estudiante,
    m.nombre AS materia,
    p.nombre AS profesor,
    n.nota AS nota_obtenida,
    n.fecha AS fecha_evaluacion
FROM notas n
JOIN estudiantes e ON e.id_estudiante = n.id_estudiante
JOIN materias m ON m.id_materia = n.id_materia
JOIN profesores p ON p.id_profesor = n.id_profesor;

-- 12. Consulta para decision de negocio: estudiante con el mejor promedio general
SELECT e.nombre, AVG(n.nota) AS promedio_general
FROM notas n
JOIN estudiantes e ON e.id_estudiante = n.id_estudiante
GROUP BY e.nombre
ORDER BY promedio_general DESC
LIMIT 1;
