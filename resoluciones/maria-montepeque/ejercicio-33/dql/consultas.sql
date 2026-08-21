-- Ejercicio 33: Normalizacion Matriculas Academicas

-- 1. Reconstruir una vista similar al archivo original usando JOIN
-- (una fila por cada modulo cursado en cada matricula, como quedaria "aplanado" el CSV original)
SELECT
    ma.id_matricula,
    e.nombre AS estudiante,
    e.documento AS documento,
    r.nombre AS ruta,
    t.nombre AS trainer,
    mo.nombre AS modulo,
    n.horario AS horario,
    n.nota AS nota
FROM matriculas ma
JOIN estudiantes e ON e.id_estudiante = ma.id_estudiante
JOIN rutas r ON r.id_ruta = ma.id_ruta
JOIN trainers t ON t.id_trainer = ma.id_trainer
JOIN notas n ON n.id_matricula = ma.id_matricula
JOIN modulos mo ON mo.id_modulo = n.id_modulo
ORDER BY ma.id_matricula, n.horario;

-- 2. Listar entidades principales sin duplicados
SELECT DISTINCT nombre, documento FROM estudiantes;
SELECT DISTINCT nombre FROM rutas;
SELECT DISTINCT nombre FROM trainers;
SELECT DISTINCT nombre FROM modulos;

-- 3. Contar registros por categoria o estado (notas registradas por modulo)
SELECT mo.nombre AS modulo, COUNT(*) AS veces_cursado
FROM notas n
JOIN modulos mo ON mo.id_modulo = n.id_modulo
GROUP BY mo.nombre;

-- 4. Calcular un total por transaccion (cantidad de modulos por matricula)
SELECT ma.id_matricula, COUNT(*) AS total_modulos
FROM matriculas ma
JOIN notas n ON n.id_matricula = ma.id_matricula
GROUP BY ma.id_matricula;

-- 5. Calcular promedio, minimo y maximo de las notas
SELECT
    AVG(nota) AS promedio,
    MIN(nota) AS minimo,
    MAX(nota) AS maximo
FROM notas;

-- 6. Buscar registros por texto con LIKE
SELECT * FROM estudiantes WHERE nombre LIKE 'Laura%';
SELECT * FROM modulos WHERE nombre LIKE '%JS%' OR nombre LIKE 'J%';

-- 7. Filtrar por fecha o rango numerico
SELECT * FROM notas WHERE horario >= '12:00';
SELECT * FROM notas WHERE nota BETWEEN 85 AND 95;

-- 8. Mostrar top 5 por cantidad o monto (modulos con mejor promedio de nota)
SELECT mo.nombre AS modulo, ROUND(AVG(n.nota), 2) AS promedio_nota
FROM notas n
JOIN modulos mo ON mo.id_modulo = n.id_modulo
GROUP BY mo.nombre
ORDER BY promedio_nota DESC
LIMIT 5;

-- 9. Detectar registros relacionados sin detalle (matriculas sin notas registradas)
SELECT ma.id_matricula, e.nombre AS estudiante, r.nombre AS ruta
FROM matriculas ma
JOIN estudiantes e ON e.id_estudiante = ma.id_estudiante
JOIN rutas r ON r.id_ruta = ma.id_ruta
LEFT JOIN notas n ON n.id_matricula = ma.id_matricula
WHERE n.id_nota IS NULL;

-- 10. Reporte final con alias legibles
SELECT
    e.nombre AS estudiante,
    e.documento AS documento,
    r.nombre AS ruta,
    t.nombre AS trainer,
    mo.nombre AS modulo,
    n.horario AS horario,
    n.nota AS nota_obtenida
FROM matriculas ma
JOIN estudiantes e ON e.id_estudiante = ma.id_estudiante
JOIN rutas r ON r.id_ruta = ma.id_ruta
JOIN trainers t ON t.id_trainer = ma.id_trainer
JOIN notas n ON n.id_matricula = ma.id_matricula
JOIN modulos mo ON mo.id_modulo = n.id_modulo
ORDER BY ma.id_matricula, n.horario;
