.headers on
.mode column

-- Ejercicio 052: Taller de Motos
-- Consultas de validacion.

-- 1. Que registros principales existen (con JOIN a cliente y
--    mecanico, y el costo total de cada orden desde el detalle).
SELECT
    o.id_orden,
    c.nombre_cliente,
    m.nombre_mecanico,
    o.placa_moto,
    o.fecha_orden,
    o.estado,
    ROUND(o.costo_mano_obra + COALESCE(SUM(r.cantidad * r.costo_unitario), 0), 2) AS costo_total
FROM ordenes_servicio o
JOIN clientes c ON c.id_cliente = o.id_cliente
JOIN mecanicos m ON m.id_mecanico = o.id_mecanico
LEFT JOIN repuestos_usados r ON r.id_orden = o.id_orden
GROUP BY o.id_orden, c.nombre_cliente, m.nombre_mecanico, o.placa_moto, o.fecha_orden, o.estado, o.costo_mano_obra
ORDER BY o.id_orden;

-- 2. Que ordenes no estan entregadas todavia.
SELECT id_orden, id_cliente, id_mecanico, fecha_orden, estado
FROM ordenes_servicio
WHERE estado <> 'entregado';

-- 3. Que mecanico tiene mas ordenes asignadas.
SELECT m.nombre_mecanico, COUNT(*) AS total_ordenes
FROM mecanicos m
JOIN ordenes_servicio o ON o.id_mecanico = m.id_mecanico
GROUP BY m.id_mecanico, m.nombre_mecanico
ORDER BY total_ordenes DESC, m.nombre_mecanico;

-- 4. Ordenes ordenadas por fecha.
SELECT c.nombre_cliente, m.nombre_mecanico, o.placa_moto, o.fecha_orden
FROM ordenes_servicio o
JOIN clientes c ON c.id_cliente = o.id_cliente
JOIN mecanicos m ON m.id_mecanico = o.id_mecanico
ORDER BY o.fecha_orden;

-- 5. Costo total de cada orden (mano de obra + repuestos), de mayor
--    a menor, para decidir a quien cobrar o entregar primero.
SELECT
    o.id_orden,
    c.nombre_cliente,
    o.placa_moto,
    ROUND(o.costo_mano_obra + COALESCE(SUM(r.cantidad * r.costo_unitario), 0), 2) AS costo_total
FROM ordenes_servicio o
JOIN clientes c ON c.id_cliente = o.id_cliente
LEFT JOIN repuestos_usados r ON r.id_orden = o.id_orden
GROUP BY o.id_orden, c.nombre_cliente, o.placa_moto, o.costo_mano_obra
ORDER BY costo_total DESC;
