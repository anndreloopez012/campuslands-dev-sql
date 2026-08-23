.headers on
.mode column

-- Ejercicio 002: Taller de Motos
-- Consultas de validacion.

-- 1. Que registros principales existen.
SELECT * FROM ordenes_trabajo;

-- 2. Que registros estan activos, pendientes o finalizados (aqui: ordenes
--    que NO estan completadas, ya sea porque siguen en proceso o se
--    cancelaron). Despues de dml/operaciones.sql ya no queda ninguna
--    'en_proceso' (se completo la de la moto 1), asi que esta consulta
--    muestra la que sigue sin cerrarse con exito: la cancelada.
SELECT id_orden, id_moto, descripcion_servicio, costo, fecha_orden, estado
FROM ordenes_trabajo
WHERE estado <> 'completada';

-- 3. Que moto (y por lo tanto que cliente) tiene mas actividad.
SELECT m.placa, m.nombre_dueno, COUNT(*) AS total_ordenes
FROM motos m
JOIN ordenes_trabajo o ON o.id_moto = m.id_moto
GROUP BY m.id_moto, m.placa, m.nombre_dueno
ORDER BY total_ordenes DESC;

-- 4. Ordenes ordenadas por fecha.
SELECT id_orden, descripcion_servicio, fecha_orden, estado
FROM ordenes_trabajo
ORDER BY fecha_orden;

-- 5. Reporte util para el cliente: ingresos por mecanico (solo ordenes
--    completadas), para decidir carga de trabajo o bonificaciones.
SELECT
    mecanico_asignado,
    SUM(costo) AS total_generado,
    COUNT(*) AS ordenes_completadas
FROM ordenes_trabajo
WHERE estado = 'completada'
GROUP BY mecanico_asignado
ORDER BY total_generado DESC;
