.headers on
.mode column

-- Ejercicio 015: Laboratorio Quimico
-- Consultas de validacion.

-- 1. Que registros principales existen.
SELECT * FROM muestras;

-- 2. Que muestras no estan completadas todavia.
SELECT id_muestra, codigo_muestra, id_reactivo, fecha_analisis, estado
FROM muestras
WHERE estado <> 'completado';

-- 3. Que reactivo se usa mas.
SELECT r.nombre_reactivo, COUNT(*) AS veces_usado
FROM reactivos r
JOIN muestras m ON m.id_reactivo = r.id_reactivo
GROUP BY r.id_reactivo, r.nombre_reactivo
ORDER BY veces_usado DESC;

-- 4. Muestras ordenadas por fecha de analisis.
SELECT id_muestra, codigo_muestra, fecha_analisis, estado
FROM muestras
ORDER BY fecha_analisis;

-- 5. Cuantas muestras hay por estado, para medir la tasa de
--    contaminacion del laboratorio.
SELECT estado, COUNT(*) AS total_muestras
FROM muestras
GROUP BY estado
ORDER BY total_muestras DESC;
