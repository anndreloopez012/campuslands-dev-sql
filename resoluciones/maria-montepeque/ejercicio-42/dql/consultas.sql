.headers on
.mode column

-- Ejercicio 42: Tipos de datos Nivel Intermedio
-- Consultas de validacion.

-- 1. Mostrar todos los datos principales.
SELECT * FROM inscripciones;

-- 2. Consulta con WHERE (filtra por el BOOLEAN simulado: campers becados).
SELECT nombre, correo, fecha_nacimiento
FROM campers
WHERE becado = 1;

-- 3. Consulta con ORDER BY (REAL ordena numericamente).
SELECT r.nombre AS ruta, i.nota_final
FROM inscripciones i
JOIN rutas r ON r.id_ruta = i.id_ruta
WHERE i.nota_final IS NOT NULL
ORDER BY i.nota_final DESC;

-- 4. Conteo o resumen.
SELECT
    COUNT(*) AS total_inscripciones,
    SUM(aprobado) AS aprobados,
    COUNT(*) - SUM(aprobado) AS no_aprobados,
    ROUND(AVG(nota_final), 2) AS promedio_notas
FROM inscripciones;

-- 5. Validacion especifica del tema Tipos de datos:
--    a) el DATE simulado (TEXT ISO) permite comparar y ordenar fechas de
--       nacimiento como si fueran un tipo fecha real.
SELECT nombre, fecha_nacimiento
FROM campers
WHERE fecha_nacimiento >= '2000-01-01'
ORDER BY fecha_nacimiento;

--    b) el REAL nullable en nota_final distingue "sin nota todavia" (NULL)
--       de "nota cero"; NULL se excluye automaticamente de AVG/COUNT sin
--       falsear el promedio.
SELECT
    c.nombre AS camper,
    r.nombre AS ruta,
    CASE WHEN i.nota_final IS NULL THEN 'En curso' ELSE 'Finalizado' END AS estado_curso,
    i.aprobado AS aprobado
FROM inscripciones i
JOIN campers c ON c.id_camper = i.id_camper
JOIN rutas r ON r.id_ruta = i.id_ruta;
