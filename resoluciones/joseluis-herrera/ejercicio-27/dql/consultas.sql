SELECT
    id_curso,
    nombre,
    id_categoria,
    id_instructor,
    precio,
    fecha_inicio,
    cupo_maximo
FROM cursos;

SELECT
    nombre,
    precio
FROM cursos;

SELECT
    id_curso,
    nombre,
    precio,
    fecha_inicio
FROM cursos
WHERE precio >= 300;

SELECT
    id_curso,
    nombre,
    fecha_inicio
FROM cursos
ORDER BY fecha_inicio ASC;

SELECT
    c.id_curso,
    c.nombre,
    c.precio,
    COUNT(i.id_inscripcion) AS total_inscripciones
FROM cursos AS c
LEFT JOIN inscripciones AS i
    ON i.id_curso = c.id_curso
GROUP BY c.id_curso, c.nombre, c.precio
ORDER BY total_inscripciones DESC, c.nombre ASC
LIMIT 5;

SELECT COUNT(*) AS total_cursos
FROM cursos;

SELECT
    AVG(precio) AS precio_promedio,
    MIN(precio) AS precio_minimo,
    MAX(precio) AS precio_maximo
FROM cursos;

SELECT
    cat.nombre AS categoria,
    COUNT(c.id_curso) AS cantidad_cursos
FROM categorias AS cat
LEFT JOIN cursos AS c
    ON c.id_categoria = cat.id_categoria
GROUP BY cat.id_categoria, cat.nombre
ORDER BY cantidad_cursos DESC;

SELECT
    c.nombre AS curso,
    cat.nombre AS categoria,
    ins.nombre_completo AS instructor,
    c.precio
FROM cursos AS c
INNER JOIN categorias AS cat
    ON cat.id_categoria = c.id_categoria
INNER JOIN instructores AS ins
    ON ins.id_instructor = c.id_instructor
ORDER BY c.nombre ASC;

SELECT
    nombre,
    precio,
    fecha_inicio
FROM cursos
WHERE precio >= 250
ORDER BY precio DESC
LIMIT 5;

SELECT
    c.nombre AS "Curso",
    cat.nombre AS "Categoría",
    ins.nombre_completo AS "Instructor",
    c.precio AS "Precio",
    COUNT(i.id_inscripcion) AS "Inscripciones"
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
    c.precio
ORDER BY "Inscripciones" DESC, "Precio" DESC;

SELECT
    c.nombre AS curso,
    c.cupo_maximo,
    COUNT(i.id_inscripcion) AS inscritos,
    c.cupo_maximo - COUNT(i.id_inscripcion) AS cupos_disponibles,
    CASE
        WHEN COUNT(i.id_inscripcion) >= c.cupo_maximo THEN 'Sin cupos'
        WHEN COUNT(i.id_inscripcion) * 100.0 / c.cupo_maximo >= 80 THEN 'Alta demanda'
        WHEN COUNT(i.id_inscripcion) * 100.0 / c.cupo_maximo >= 50 THEN 'Demanda media'
        ELSE 'Baja demanda'
    END AS nivel_demanda
FROM cursos AS c
LEFT JOIN inscripciones AS i
    ON i.id_curso = c.id_curso
    AND i.estado = 'activa'
GROUP BY
    c.id_curso,
    c.nombre,
    c.cupo_maximo
ORDER BY inscritos DESC, c.nombre ASC;