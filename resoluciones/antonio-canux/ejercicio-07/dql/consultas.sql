SELECT * FROM matriculas;

SELECT fecha_matricula, estado FROM matriculas;

SELECT * FROM matriculas WHERE nota_final >= 80;

SELECT * FROM matriculas ORDER BY fecha_matricula;

SELECT * FROM matriculas
WHERE nota_final IS NOT NULL
ORDER BY nota_final DESC
LIMIT 5;

SELECT COUNT(*) AS total_matriculas FROM matriculas;

SELECT
    AVG(nota_final) AS promedio,
    MIN(nota_final) AS minimo,
    MAX(nota_final) AS maximo
FROM matriculas
WHERE nota_final IS NOT NULL;
