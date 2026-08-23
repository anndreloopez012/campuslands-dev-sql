.headers on
.mode column

-- Ejercicio 008: Viajes y Paracaidismo
-- Consultas de validacion.

-- 1. Que registros principales existen.
SELECT * FROM reservas;

-- 2. Casos pendientes (tal como pidio el cliente explicitamente).
SELECT id_reserva, id_experiencia, nombre_cliente, fecha_reserva
FROM reservas
WHERE estado = 'pendiente';

-- 3. Ranking: que experiencia tiene mas reservas.
SELECT e.nombre_experiencia, COUNT(*) AS total_reservas
FROM experiencias e
JOIN reservas r ON r.id_experiencia = e.id_experiencia
GROUP BY e.id_experiencia, e.nombre_experiencia
ORDER BY total_reservas DESC;

-- 4. Reservas ordenadas por fecha.
SELECT id_reserva, nombre_cliente, fecha_reserva, estado
FROM reservas
ORDER BY fecha_reserva;

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
