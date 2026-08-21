.headers on
.mode column

-- Ejercicio 056: Renta Autos de Lujo
-- Consultas de validacion.

-- 1. Que registros principales existen (con JOIN a cliente y
--    vehiculo, mas el total pagado de cada reserva).
SELECT
    r.id_reserva,
    c.nombre_cliente,
    v.modelo,
    r.fecha_inicio,
    r.fecha_fin,
    r.estado,
    COALESCE(SUM(CASE WHEN p.estado = 'completado' THEN p.monto ELSE 0 END), 0) AS total_pagado
FROM reservas r
JOIN clientes c ON c.id_cliente = r.id_cliente
JOIN vehiculos v ON v.id_vehiculo = r.id_vehiculo
LEFT JOIN pagos p ON p.id_reserva = r.id_reserva
GROUP BY r.id_reserva, c.nombre_cliente, v.modelo, r.fecha_inicio, r.fecha_fin, r.estado
ORDER BY r.id_reserva;

-- 2. Que reservas no estan finalizadas todavia.
SELECT id_reserva, id_cliente, id_vehiculo, fecha_inicio, estado
FROM reservas
WHERE estado <> 'finalizada';

-- 3. Que cliente tiene mas reservas.
SELECT c.nombre_cliente, COUNT(*) AS total_reservas
FROM clientes c
JOIN reservas r ON r.id_cliente = c.id_cliente
GROUP BY c.id_cliente, c.nombre_cliente
ORDER BY total_reservas DESC, c.nombre_cliente;

-- 4. Reservas ordenadas por fecha de inicio.
SELECT c.nombre_cliente, v.modelo, r.fecha_inicio
FROM reservas r
JOIN clientes c ON c.id_cliente = r.id_cliente
JOIN vehiculos v ON v.id_vehiculo = r.id_vehiculo
ORDER BY r.fecha_inicio;

-- 5. Ingreso total por vehiculo (solo pagos completados), para
--    decidir cual vehiculo es mas rentable.
SELECT v.modelo, COALESCE(SUM(p.monto), 0) AS ingreso_total
FROM vehiculos v
JOIN reservas r ON r.id_vehiculo = v.id_vehiculo
JOIN pagos p ON p.id_reserva = r.id_reserva AND p.estado = 'completado'
GROUP BY v.id_vehiculo, v.modelo
ORDER BY ingreso_total DESC;
