.headers on
.mode column

-- Ejercicio 033: Viajes y Paracaidismo
-- Consultas de validacion.

-- 1. Que registros principales existen (con JOIN doble para mostrar el
--    cliente y la experiencia en vez de solo los id).
SELECT
    r.id_reserva,
    c.nombre_cliente,
    e.nombre_experiencia,
    r.fecha_reserva,
    r.monto_pagado,
    r.estado
FROM reservas r
JOIN clientes c ON c.id_cliente = r.id_cliente
JOIN experiencias e ON e.id_experiencia = r.id_experiencia;

-- 2. Que reservas no estan completadas todavia.
SELECT id_reserva, id_cliente, id_experiencia, monto_pagado, estado
FROM reservas
WHERE estado <> 'completada';

-- 3. Que cliente tiene mas reservas.
SELECT c.nombre_cliente, COUNT(*) AS total_reservas
FROM clientes c
JOIN reservas r ON r.id_cliente = c.id_cliente
GROUP BY c.id_cliente, c.nombre_cliente
ORDER BY total_reservas DESC;

-- 4. Reservas ordenadas por fecha.
SELECT c.nombre_cliente, e.nombre_experiencia, r.fecha_reserva
FROM reservas r
JOIN clientes c ON c.id_cliente = r.id_cliente
JOIN experiencias e ON e.id_experiencia = r.id_experiencia
ORDER BY r.fecha_reserva;

-- 5. Totales: cuanto genera cada experiencia (sin contar canceladas),
--    para decidir cual promocionar mas.
SELECT
    e.nombre_experiencia,
    e.tipo,
    SUM(r.monto_pagado) AS total_generado
FROM experiencias e
JOIN reservas r ON r.id_experiencia = e.id_experiencia
WHERE r.estado <> 'cancelada'
GROUP BY e.id_experiencia, e.nombre_experiencia, e.tipo
ORDER BY total_generado DESC;
