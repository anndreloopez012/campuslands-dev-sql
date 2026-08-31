.headers on
.mode column

-- Ejercicio 064: Mecanica de Autos
-- Consultas que responden preguntas reales del cliente.

-- 1. Que registros principales existen: todos los diagnosticos con
-- vehiculo y cliente.
SELECT d.id_diagnostico,
       c.nombre AS cliente,
       v.placa,
       v.marca || ' ' || v.modelo AS vehiculo,
       d.descripcion,
       d.estado
FROM diagnosticos d
JOIN vehiculos v ON v.id_vehiculo = d.id_vehiculo
JOIN clientes c ON c.id_cliente = v.id_cliente;

-- 2. Que registros estan pendientes, en reparacion o finalizados.
SELECT id_diagnostico, estado
FROM diagnosticos
ORDER BY estado;

-- 3. Que vehiculo tiene mas actividad (ranking por numero de
-- diagnosticos).
SELECT v.placa,
       v.marca || ' ' || v.modelo AS vehiculo,
       COUNT(*) AS total_diagnosticos
FROM diagnosticos d
JOIN vehiculos v ON v.id_vehiculo = d.id_vehiculo
GROUP BY v.id_vehiculo
ORDER BY total_diagnosticos DESC;

-- 4. Diagnosticos ordenados por fecha, del mas reciente al mas antiguo.
SELECT id_diagnostico, fecha_diagnostico, estado
FROM diagnosticos
ORDER BY fecha_diagnostico DESC;

-- 5. Reporte semanal para decision de negocio: facturacion por cliente
-- (mano de obra + repuestos), clientes que superan Q400 en la semana
-- (GROUP BY + HAVING).
SELECT c.nombre AS cliente,
       SUM(r.costo_mano_obra) AS total_mano_obra,
       COALESCE(SUM(rp.subtotal_repuestos), 0) AS total_repuestos,
       SUM(r.costo_mano_obra) + COALESCE(SUM(rp.subtotal_repuestos), 0) AS total_facturado
FROM reparaciones r
JOIN diagnosticos d ON d.id_diagnostico = r.id_diagnostico
JOIN vehiculos v ON v.id_vehiculo = d.id_vehiculo
JOIN clientes c ON c.id_cliente = v.id_cliente
LEFT JOIN (
    SELECT id_reparacion, SUM(cantidad * precio_unitario) AS subtotal_repuestos
    FROM repuestos
    GROUP BY id_reparacion
) rp ON rp.id_reparacion = r.id_reparacion
GROUP BY c.id_cliente
HAVING total_facturado > 400
ORDER BY total_facturado DESC;
