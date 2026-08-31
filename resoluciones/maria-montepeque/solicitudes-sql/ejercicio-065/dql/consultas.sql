.headers on
.mode column

-- Ejercicio 065: Laboratorio Quimico
-- Consultas que responden preguntas reales del cliente.

-- 1. Que registros principales existen: todas las muestras con
-- formula, reactivo y tecnico.
SELECT m.id_muestra,
       f.nombre AS formula,
       r.nombre AS reactivo,
       t.nombre AS tecnico,
       m.fecha_muestra,
       m.estado
FROM muestras m
JOIN formulas f ON f.id_formula = m.id_formula
JOIN reactivos r ON r.id_reactivo = m.id_reactivo
JOIN tecnicos t ON t.id_tecnico = m.id_tecnico;

-- 2. Que registros estan pendientes, en analisis o finalizados.
SELECT id_muestra, estado
FROM muestras
ORDER BY estado;

-- 3. Que reactivo se usa con mas frecuencia (ranking de uso).
SELECT r.nombre AS reactivo,
       COUNT(*) AS veces_usado
FROM muestras m
JOIN reactivos r ON r.id_reactivo = m.id_reactivo
GROUP BY r.id_reactivo
ORDER BY veces_usado DESC;

-- 4. Muestras ordenadas por fecha, de la mas reciente a la mas antigua.
SELECT id_muestra, fecha_muestra, estado
FROM muestras
ORDER BY fecha_muestra DESC;

-- 5. Reporte para decision de negocio: formula con mas muestras
-- aprobadas, para decidir en que formula seguir invirtiendo (GROUP BY +
-- HAVING).
SELECT f.nombre AS formula,
       COUNT(*) AS muestras_aprobadas
FROM resultados res
JOIN muestras m ON m.id_muestra = res.id_muestra
JOIN formulas f ON f.id_formula = m.id_formula
WHERE res.aprobado = 1
GROUP BY f.id_formula
HAVING COUNT(*) > 1
ORDER BY muestras_aprobadas DESC;
