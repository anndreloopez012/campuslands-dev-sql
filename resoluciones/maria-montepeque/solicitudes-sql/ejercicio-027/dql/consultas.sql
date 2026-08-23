.headers on
.mode column

-- Ejercicio 027: Taller de Motos
-- Consultas de validacion.

-- 1. Que registros principales existen (con JOIN para mostrar el
--    cliente y la placa en vez de solo los id numericos).
SELECT
    o.id_orden,
    c.nombre_cliente,
    m.placa,
    o.descripcion_servicio,
    o.costo,
    o.estado
FROM ordenes_servicio o
JOIN motos m ON m.id_moto = o.id_moto
JOIN clientes c ON c.id_cliente = m.id_cliente;

-- 2. Que ordenes no estan completadas todavia.
SELECT id_orden, id_moto, descripcion_servicio, costo, estado
FROM ordenes_servicio
WHERE estado <> 'completada';

-- 3. Que cliente tiene mas actividad (mas ordenes de servicio).
SELECT c.nombre_cliente, COUNT(*) AS total_ordenes
FROM clientes c
JOIN motos m ON m.id_cliente = c.id_cliente
JOIN ordenes_servicio o ON o.id_moto = m.id_moto
GROUP BY c.id_cliente, c.nombre_cliente
ORDER BY total_ordenes DESC;

-- 4. Ordenes ordenadas por fecha.
SELECT c.nombre_cliente, m.placa, o.descripcion_servicio, o.fecha_orden
FROM ordenes_servicio o
JOIN motos m ON m.id_moto = o.id_moto
JOIN clientes c ON c.id_cliente = m.id_cliente
ORDER BY o.fecha_orden;

-- 5. Cuanto genera cada mecanico en costo total (sin ordenes
--    canceladas), para decisiones de carga de trabajo.
SELECT
    mecanico_asignado,
    SUM(costo) AS total_generado,
    COUNT(*) AS ordenes_validas
FROM ordenes_servicio
WHERE estado <> 'cancelada'
GROUP BY mecanico_asignado
ORDER BY total_generado DESC;
