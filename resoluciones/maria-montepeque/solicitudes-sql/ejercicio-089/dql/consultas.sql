.headers on
.mode column

-- Ejercicio 089: Mecanica de Autos
-- Consultas que responden preguntas reales del cliente.

-- 1. Que registros principales existen: se usa la vista
-- vista_historial_vehiculo (creada en ddl/schema.sql), que responde
-- directamente "que paso y cuando paso" con cada vehiculo.
SELECT *
FROM vista_historial_vehiculo;

-- 2. Que reparaciones estan pendientes, en proceso, completadas o
-- canceladas.
SELECT id_reparacion, id_diagnostico, estado
FROM reparaciones
ORDER BY estado;

-- 3. Que vehiculo tiene mas diagnosticos (ranking de actividad).
SELECT v.placa, v.modelo, COUNT(*) AS total_diagnosticos
FROM vehiculos v
JOIN diagnosticos d ON d.id_vehiculo = v.id_vehiculo
GROUP BY v.id_vehiculo, v.placa, v.modelo
ORDER BY total_diagnosticos DESC, v.placa;

-- 4. Diagnosticos ordenados por fecha.
SELECT id_diagnostico, fecha_diagnostico, gravedad
FROM diagnosticos
ORDER BY fecha_diagnostico;

-- 5. Reporte para decision de negocio: gasto total por cliente (mano
-- de obra + repuestos), para decidir a quien ofrecer un programa de
-- fidelidad (GROUP BY + HAVING, en dos niveles: primero el costo de
-- cada reparacion, despues la suma por cliente).
SELECT cl.nombre_cliente,
       SUM(rep_costos.costo_total) AS gasto_total
FROM (
    SELECT r.id_reparacion,
           d.id_vehiculo,
           r.costo_mano_obra + COALESCE(SUM(dr.cantidad * rp.precio_unitario), 0) AS costo_total
    FROM reparaciones r
    JOIN diagnosticos d ON d.id_diagnostico = r.id_diagnostico
    LEFT JOIN detalle_repuestos dr ON dr.id_reparacion = r.id_reparacion
    LEFT JOIN repuestos rp ON rp.id_repuesto = dr.id_repuesto
    GROUP BY r.id_reparacion, d.id_vehiculo, r.costo_mano_obra
) AS rep_costos
JOIN vehiculos v ON v.id_vehiculo = rep_costos.id_vehiculo
JOIN clientes cl ON cl.id_cliente = v.id_cliente
GROUP BY cl.id_cliente, cl.nombre_cliente
HAVING SUM(rep_costos.costo_total) > 0
ORDER BY gasto_total DESC;
