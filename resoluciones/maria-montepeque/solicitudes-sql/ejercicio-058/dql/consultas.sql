.headers on
.mode column

-- Ejercicio 058: Viajes y Paracaidismo
-- Consultas de validacion.

-- 1. Que registros principales existen (con JOIN a cliente y
--    experiencia, mas el total pagado -completado- de cada reserva).
SELECT
    r.id_reserva,
    c.nombre_cliente,
    e.nombre_experiencia,
    r.fecha_reserva,
    r.estado,
    COALESCE(SUM(CASE WHEN p.estado = 'completado' THEN p.monto ELSE 0 END), 0) AS total_pagado
FROM reservas r
JOIN clientes c ON c.id_cliente = r.id_cliente
JOIN experiencias e ON e.id_experiencia = r.id_experiencia
LEFT JOIN pagos p ON p.id_reserva = r.id_reserva
GROUP BY r.id_reserva, c.nombre_cliente, e.nombre_experiencia, r.fecha_reserva, r.estado
ORDER BY r.id_reserva;

-- 2. Que reservas no estan completadas todavia (casos pendientes).
SELECT id_reserva, id_cliente, id_experiencia, fecha_reserva, estado
FROM reservas
WHERE estado <> 'completada';

-- 3. Que cliente tiene mas reservas (ranking de actividad).
SELECT c.nombre_cliente, COUNT(*) AS total_reservas
FROM clientes c
JOIN reservas r ON r.id_cliente = c.id_cliente
GROUP BY c.id_cliente, c.nombre_cliente
ORDER BY total_reservas DESC, c.nombre_cliente;

-- 4. Reservas ordenadas por fecha.
SELECT c.nombre_cliente, e.nombre_experiencia, r.fecha_reserva
FROM reservas r
JOIN clientes c ON c.id_cliente = r.id_cliente
JOIN experiencias e ON e.id_experiencia = r.id_experiencia
ORDER BY r.fecha_reserva;

-- 5. Total recaudado por experiencia (solo pagos completados), para
--    decidir cual promocionar mas.
SELECT e.nombre_experiencia, COALESCE(SUM(p.monto), 0) AS total_recaudado
FROM experiencias e
JOIN reservas r ON r.id_experiencia = e.id_experiencia
JOIN pagos p ON p.id_reserva = r.id_reserva AND p.estado = 'completado'
GROUP BY e.id_experiencia, e.nombre_experiencia
ORDER BY total_recaudado DESC;
