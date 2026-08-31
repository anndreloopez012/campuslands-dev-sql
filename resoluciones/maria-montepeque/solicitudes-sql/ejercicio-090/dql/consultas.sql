.headers on
.mode column

-- Ejercicio 090: Laboratorio Quimico
-- Consultas que responden preguntas reales del cliente.

-- 1. Listado principal: se usa la vista vista_historial_muestra
-- (creada en ddl/schema.sql), que responde directamente "que paso y
-- cuando paso" con cada muestra.
SELECT *
FROM vista_historial_muestra;

-- 2. Filtro por estado: que muestras estan en analisis en este momento.
SELECT id_muestra, id_formula, id_tecnico, fecha_recepcion
FROM muestras
WHERE estado = 'en_analisis';

-- 3. Consulta con JOIN: que reactivos se usaron en cada muestra y en
-- que cantidad.
SELECT m.id_muestra, f.nombre_formula, r.nombre_reactivo, dr.cantidad_usada, r.unidad_medida
FROM detalle_reactivos dr
JOIN muestras m ON m.id_muestra = dr.id_muestra
JOIN formulas f ON f.id_formula = m.id_formula
JOIN reactivos r ON r.id_reactivo = dr.id_reactivo
ORDER BY m.id_muestra;

-- 4. Reporte ordenado por una metrica importante: muestras ordenadas
-- por fecha de recepcion.
SELECT id_muestra, fecha_recepcion, estado
FROM muestras
ORDER BY fecha_recepcion;

-- 5. Conteo, suma o promedio: cuantos resultados tiene cada formula y
-- cual es su valor medido promedio (GROUP BY + JOIN).
SELECT f.nombre_formula,
       COUNT(r.id_resultado) AS total_resultados,
       ROUND(AVG(r.valor_medido), 2) AS promedio_valor
FROM formulas f
JOIN muestras m ON m.id_formula = f.id_formula
JOIN resultados r ON r.id_muestra = m.id_muestra
GROUP BY f.id_formula, f.nombre_formula
ORDER BY promedio_valor DESC;

-- 6. Consulta final de decision para el cliente: que formulas tienen
-- muestras rechazadas, para decidir cuales revisar con el proveedor
-- de reactivos (GROUP BY + HAVING sobre un conteo condicional).
SELECT f.nombre_formula,
       COUNT(m.id_muestra) AS total_muestras,
       SUM(CASE WHEN m.estado = 'rechazada' THEN 1 ELSE 0 END) AS muestras_rechazadas
FROM formulas f
JOIN muestras m ON m.id_formula = f.id_formula
GROUP BY f.id_formula, f.nombre_formula
HAVING SUM(CASE WHEN m.estado = 'rechazada' THEN 1 ELSE 0 END) > 0
ORDER BY muestras_rechazadas DESC;
