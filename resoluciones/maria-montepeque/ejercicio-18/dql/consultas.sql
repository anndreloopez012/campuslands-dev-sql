-- Ejercicio 18: Farmacia Inventario
-- Entidad central: ventas

-- 1. Listar todos los registros principales de la entidad central
SELECT * FROM ventas;

-- 2. Mostrar solo dos columnas relevantes
SELECT cantidad, precio_unitario FROM ventas;

-- 3. Filtrar registros por una condicion numerica
SELECT * FROM ventas WHERE cantidad > 10;

-- 4. Ordenar resultados por fecha
SELECT * FROM ventas ORDER BY fecha;

-- 5. Mostrar las 5 ventas con mayor monto total
SELECT *, (cantidad * precio_unitario) AS total
FROM ventas
ORDER BY total DESC
LIMIT 5;

-- 6. Contar registros totales
SELECT COUNT(*) AS total_ventas FROM ventas;

-- 7. Promedio, minimo y maximo de la cantidad vendida
SELECT
    AVG(cantidad) AS promedio,
    MIN(cantidad) AS minimo,
    MAX(cantidad) AS maximo
FROM ventas;

-- 8. Agrupar ventas por medicamento
SELECT id_medicamento, COUNT(*) AS cantidad_ventas, SUM(cantidad) AS unidades_vendidas
FROM ventas
GROUP BY id_medicamento;

-- 9. Relacionar ventas, medicamentos y laboratorios con JOIN
SELECT v.id_venta, m.nombre AS medicamento, l.nombre AS laboratorio
FROM ventas v
JOIN medicamentos m ON m.id_medicamento = v.id_medicamento
JOIN laboratorios l ON l.id_laboratorio = m.id_laboratorio;

-- 10. WHERE + ORDER BY + LIMIT
SELECT * FROM ventas
WHERE cantidad >= 5
ORDER BY fecha DESC
LIMIT 3;

-- 11. Reporte con alias legibles
SELECT
    m.nombre AS medicamento,
    l.nombre AS laboratorio,
    v.cantidad AS unidades_vendidas,
    v.precio_unitario AS precio_unitario,
    (v.cantidad * v.precio_unitario) AS total_venta,
    v.fecha AS fecha_venta
FROM ventas v
JOIN medicamentos m ON m.id_medicamento = v.id_medicamento
JOIN laboratorios l ON l.id_laboratorio = m.id_laboratorio;

-- 12. Consulta para decision de negocio: medicamento con mayores ingresos totales por ventas
SELECT m.nombre, SUM(v.cantidad * v.precio_unitario) AS total_ingresos
FROM ventas v
JOIN medicamentos m ON m.id_medicamento = v.id_medicamento
GROUP BY m.nombre
ORDER BY total_ingresos DESC
LIMIT 1;
