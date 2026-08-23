.headers on
.mode column

-- Ejercicio 040: Laboratorio Quimico
-- Consultas de validacion.

-- 1. Que registros principales existen (con JOIN doble para mostrar la
--    formula y el reactivo en vez de solo los id).
SELECT
    m.id_muestra,
    f.nombre_formula,
    r.nombre_reactivo,
    m.fecha_analisis,
    m.concentracion,
    m.resultado
FROM muestras m
JOIN formulas f ON f.id_formula = m.id_formula
JOIN reactivos r ON r.id_reactivo = m.id_reactivo;

-- 2. Que muestras todavia no tienen un resultado valido.
SELECT id_muestra, id_formula, id_reactivo, fecha_analisis, resultado
FROM muestras
WHERE resultado <> 'valido';

-- 3. Que formula tiene mas muestras analizadas.
SELECT f.nombre_formula, COUNT(*) AS total_muestras
FROM formulas f
JOIN muestras m ON m.id_formula = f.id_formula
GROUP BY f.id_formula, f.nombre_formula
ORDER BY total_muestras DESC, f.nombre_formula;

-- 4. Muestras ordenadas por fecha.
SELECT f.nombre_formula, r.nombre_reactivo, m.fecha_analisis
FROM muestras m
JOIN formulas f ON f.id_formula = m.id_formula
JOIN reactivos r ON r.id_reactivo = m.id_reactivo
ORDER BY m.fecha_analisis;

-- 5. Que formula acumula mas muestras invalidas o por repetir, para
--    decidir cual revisar con prioridad (control de calidad).
SELECT f.nombre_formula, COUNT(*) AS muestras_problema
FROM formulas f
JOIN muestras m ON m.id_formula = f.id_formula
WHERE m.resultado IN ('invalido', 'repetir')
GROUP BY f.id_formula, f.nombre_formula
ORDER BY muestras_problema DESC;
