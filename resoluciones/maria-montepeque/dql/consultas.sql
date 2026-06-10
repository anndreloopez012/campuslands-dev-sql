.headers on
.mode column
-- Ejercicio 33: Normalizacion Matriculas Academicas

-- 1. Reconstruir vista similar al CSV original usando JOIN.
SELECT
    m.id_matricula,
    e.nombre AS estudiante,
    e.documento,
    r.nombre AS ruta,
    t.nombre AS trainer,
    mo.nombre AS modulo,
    mm.horario,
    mm.nota
FROM
    matricula m
    JOIN estudiante e ON e.documento = m.documento
    JOIN ruta r ON r.id_ruta = m.id_ruta
    JOIN trainer t ON t.id_trainer = r.id_trainer
    JOIN matricula_modulo mm ON mm.id_matricula = m.id_matricula
    JOIN modulo mo ON mo.id_modulo = mm.id_modulo
ORDER BY m.id_matricula, mm.id_modulo;

-- 2. Listar entidades principales sin duplicados.
SELECT documento, nombre FROM estudiante ORDER BY nombre;

-- 3. Contar modulos cursados por cada matricula.
SELECT m.id_matricula, e.nombre AS estudiante, COUNT(mm.id_modulo) AS total_modulos
FROM
    matricula m
    JOIN estudiante e ON e.documento = m.documento
    JOIN matricula_modulo mm ON mm.id_matricula = m.id_matricula
GROUP BY
    m.id_matricula,
    e.nombre
ORDER BY total_modulos DESC;

-- 4. Calcular la nota total acumulada por matricula.
SELECT id_matricula, SUM(nota) AS suma_notas
FROM matricula_modulo
GROUP BY
    id_matricula
ORDER BY id_matricula;

-- 5. Promedio, minimo y maximo de nota por ruta.
SELECT
    r.nombre AS ruta,
    ROUND(AVG(mm.nota), 2) AS promedio,
    MIN(mm.nota) AS nota_min,
    MAX(mm.nota) AS nota_max
FROM
    ruta r
    JOIN matricula m ON m.id_ruta = r.id_ruta
    JOIN matricula_modulo mm ON mm.id_matricula = m.id_matricula
GROUP BY
    r.nombre
ORDER BY promedio DESC;

-- 6. Buscar modulos cuyo nombre contiene 'S'.
SELECT id_modulo, nombre
FROM modulo
WHERE
    nombre LIKE '%S%'
ORDER BY nombre;

-- 7. Filtrar registros con nota en un rango numerico.
SELECT mm.id_matricula, mo.nombre AS modulo, mm.nota
FROM
    matricula_modulo mm
    JOIN modulo mo ON mo.id_modulo = mm.id_modulo
WHERE
    mm.nota BETWEEN 90 AND 100
ORDER BY mm.nota DESC;

-- 8. Top 5 modulos por nota mas alta registrada.
SELECT mo.nombre AS modulo, MAX(mm.nota) AS mejor_nota
FROM
    matricula_modulo mm
    JOIN modulo mo ON mo.id_modulo = mm.id_modulo
GROUP BY
    mo.nombre
ORDER BY mejor_nota DESC
LIMIT 5;

-- 9. Detectar modulos del catalogo que nadie ha cursado.
SELECT mo.id_modulo, mo.nombre
FROM
    modulo mo
    LEFT JOIN matricula_modulo mm ON mm.id_modulo = mo.id_modulo
WHERE
    mm.id_modulo IS NULL
ORDER BY mo.id_modulo;

-- 10. Reporte final con alias legibles: promedio por estudiante.
SELECT
    e.nombre AS "Estudiante",
    r.nombre AS "Ruta",
    COUNT(mm.id_modulo) AS "Modulos",
    ROUND(AVG(mm.nota), 2) AS "Promedio"
FROM
    matricula m
    JOIN estudiante e ON e.documento = m.documento
    JOIN ruta r ON r.id_ruta = m.id_ruta
    JOIN matricula_modulo mm ON mm.id_matricula = m.id_matricula
GROUP BY
    m.id_matricula,
    e.nombre,
    r.nombre
ORDER BY "Promedio" DESC;