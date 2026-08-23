-- Ejercicio 07: Academia de Cursos
-- Entidad central: matriculas

-- 1. Listar todos los registros principales de la entidad central
SELECT * FROM matriculas;

-- 2. Mostrar solo dos columnas relevantes
SELECT fecha_matricula, estado FROM matriculas;

-- 3. Filtrar registros por una condicion numerica
SELECT * FROM matriculas WHERE nota_final >= 80;

-- 4. Ordenar resultados por fecha
SELECT * FROM matriculas ORDER BY fecha_matricula;

-- 5. Mostrar las 5 mejores notas
SELECT * FROM matriculas
WHERE nota_final IS NOT NULL
ORDER BY nota_final DESC
LIMIT 5;

-- 6. Contar registros totales
SELECT COUNT(*) AS total_matriculas FROM matriculas;

-- 7. Promedio, minimo y maximo de nota final
SELECT
    AVG(nota_final) AS promedio,
    MIN(nota_final) AS minimo,
    MAX(nota_final) AS maximo
FROM matriculas
WHERE nota_final IS NOT NULL;

-- 8. Agrupar matriculas por estado
SELECT estado, COUNT(*) AS cantidad
FROM matriculas
GROUP BY estado;

-- 9. Relacionar matriculas, estudiantes y cursos con JOIN
SELECT m.id_matricula, e.nombre AS estudiante, c.nombre AS curso
FROM matriculas m
JOIN estudiantes e ON e.id_estudiante = m.id_estudiante
JOIN cursos c ON c.id_curso = m.id_curso;

-- 10. WHERE + ORDER BY + LIMIT
SELECT * FROM matriculas
WHERE estado = 'aprobada'
ORDER BY nota_final DESC
LIMIT 3;

-- 11. Reporte con alias legibles
SELECT
    e.nombre AS estudiante,
    c.nombre AS curso,
    m.fecha_matricula AS matriculado_el,
    m.nota_final AS nota,
    m.estado AS estado_actual
FROM matriculas m
JOIN estudiantes e ON e.id_estudiante = m.id_estudiante
JOIN cursos c ON c.id_curso = m.id_curso;

-- 12. Consulta para decision de negocio: curso con mas matriculas aprobadas
SELECT c.nombre, COUNT(*) AS aprobados
FROM matriculas m
JOIN cursos c ON c.id_curso = m.id_curso
WHERE m.estado = 'aprobada'
GROUP BY c.nombre
ORDER BY aprobados DESC
LIMIT 1;
