PRAGMA foreign_keys = ON;

-- 1. LISTAR TODOS LOS REGISTROS PRINCIPALES

SELECT
    id_curso,
    nombre,
    codigo,
    precio,
    duracion_horas,
    id_categoria,
    id_instructor
FROM cursos;

-- 2. MOSTRAR DOS COLUMNAS RELEVANTES

SELECT
    nombre,
    precio
FROM cursos;

-- 3. FILTRAR POR CONDICION NUMERICA

SELECT
    id_curso,
    nombre,
    precio,
    duracion_horas
FROM cursos
WHERE precio >= 180.00;

-- 4. ORDENAR ALFABETICAMENTE

SELECT
    id_curso,
    nombre,
    precio
FROM cursos
ORDER BY nombre ASC;

-- 5. MOSTRAR LOS 5 REGISTROS MAS IMPORTANTES SEGUN INSCRIPCIONES

SELECT
    c.id_curso,
    c.nombre,
    COUNT(i.id_inscripcion) AS total_inscripciones
FROM cursos AS c
LEFT JOIN inscripciones AS i
    ON i.id_curso = c.id_curso
GROUP BY
    c.id_curso,
    c.nombre
ORDER BY total_inscripciones DESC, c.nombre ASC
LIMIT 5;

-- 6. CONTAR REGISTROS TOTALES

SELECT
    COUNT(*) AS total_cursos
FROM cursos;

-- 7. CALCULAR PROMEDIO, MINIMO Y MAXIMO

SELECT
    AVG(precio) AS precio_promedio,
    MIN(precio) AS precio_minimo,
    MAX(precio) AS precio_maximo
FROM cursos;

-- 8. AGRUPAR REGISTROS

SELECT
    id_categoria,
    COUNT(*) AS total_cursos
FROM cursos
GROUP BY id_categoria
ORDER BY total_cursos DESC;

-- 9. RELACIONAR TABLAS CON JOIN

SELECT
    c.nombre AS curso,
    cat.nombre AS categoria,
    ins.nombre_completo AS instructor
FROM cursos AS c
INNER JOIN categorias AS cat
    ON cat.id_categoria = c.id_categoria
INNER JOIN instructores AS ins
    ON ins.id_instructor = c.id_instructor
ORDER BY c.nombre ASC;

-- 10. WHERE + ORDER BY + LIMIT

SELECT
    id_curso,
    nombre,
    precio,
    duracion_horas
FROM cursos
WHERE precio >= 150.00
ORDER BY precio DESC
LIMIT 5;

-- 11. REPORTE CON ALIAS LEGIBLES

SELECT
    c.id_curso AS 'ID Curso',
    c.nombre AS 'Curso',
    cat.nombre AS 'Categoria',
    ins.nombre_completo AS 'Instructor',
    c.precio AS 'Precio',
    c.duracion_horas AS 'Duracion Horas',
    COUNT(i.id_inscripcion) AS 'Total Inscripciones'
FROM cursos AS c
INNER JOIN categorias AS cat
    ON cat.id_categoria = c.id_categoria
INNER JOIN instructores AS ins
    ON ins.id_instructor = c.id_instructor
LEFT JOIN inscripciones AS i
    ON i.id_curso = c.id_curso
GROUP BY
    c.id_curso,
    c.nombre,
    cat.nombre,
    ins.nombre_completo,
    c.precio,
    c.duracion_horas
ORDER BY 'Total Inscripciones' DESC;

-- 12. DECISION DE NEGOCIO: CURSOS CON MAYOR DEMANDA

SELECT
    c.nombre AS curso,
    COUNT(i.id_inscripcion) AS total_inscripciones,
    CASE
        WHEN COUNT(i.id_inscripcion) >= 3 THEN 'Alta demanda'
        WHEN COUNT(i.id_inscripcion) >= 2 THEN 'Demanda media'
        ELSE 'Baja demanda'
    END AS nivel_demanda,
    CASE
        WHEN COUNT(i.id_inscripcion) >= 3 THEN 'Priorizar cupos y promocion'
        WHEN COUNT(i.id_inscripcion) >= 2 THEN 'Mantener oferta'
        ELSE 'Evaluar estrategia comercial'
    END AS decision
FROM cursos AS c
LEFT JOIN inscripciones AS i
    ON i.id_curso = c.id_curso
GROUP BY
    c.id_curso,
    c.nombre
ORDER BY total_inscripciones DESC;

-- BUSQUEDAS EFICIENTES

SELECT
    id_curso,
    nombre,
    precio
FROM cursos
WHERE nombre = 'Python Profesional';

SELECT
    id_inscripcion,
    id_curso,
    nombre_estudiante,
    fecha_inscripcion
FROM inscripciones
WHERE id_curso = 2
  AND fecha_inscripcion >= '2026-08-01'
ORDER BY fecha_inscripcion DESC;

-- VERIFICACION DE INDICES

EXPLAIN QUERY PLAN
SELECT
    id_curso,
    nombre,
    precio
FROM cursos
WHERE nombre = 'Python Profesional';

EXPLAIN QUERY PLAN
SELECT
    id_inscripcion,
    id_curso,
    nombre_estudiante,
    fecha_inscripcion
FROM inscripciones
WHERE id_curso = 2
  AND fecha_inscripcion >= '2026-08-01'
ORDER BY fecha_inscripcion DESC;