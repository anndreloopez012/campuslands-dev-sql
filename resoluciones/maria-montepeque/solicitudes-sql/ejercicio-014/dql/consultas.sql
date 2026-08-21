.headers on
.mode column

-- Ejercicio 014: Mecanica de Autos
-- Consultas de validacion.

-- 1. Que registros principales existen.
SELECT * FROM reparaciones;

-- 2. Que reparaciones no estan completadas todavia.
SELECT id_reparacion, id_vehiculo, diagnostico, costo, fecha_reparacion, estado
FROM reparaciones
WHERE estado <> 'completada';

-- 3. Que vehiculo tiene mas reparaciones.
SELECT v.placa, v.marca, v.modelo, COUNT(*) AS total_reparaciones
FROM vehiculos v
JOIN reparaciones r ON r.id_vehiculo = v.id_vehiculo
GROUP BY v.id_vehiculo, v.placa, v.marca, v.modelo
ORDER BY total_reparaciones DESC;

-- 4. Reparaciones ordenadas por fecha, para revisar la semana dia a dia.
SELECT id_reparacion, diagnostico, fecha_reparacion, estado
FROM reparaciones
ORDER BY fecha_reparacion;

-- 5. Reporte semanal para el taller: ingresos por dia (solo reparaciones
--    completadas), para decidir compras de repuestos.
SELECT
    date(fecha_reparacion) AS dia,
    SUM(costo) AS ingresos_del_dia,
    COUNT(*) AS reparaciones_completadas
FROM reparaciones
WHERE estado = 'completada'
GROUP BY date(fecha_reparacion)
ORDER BY dia;
