-- Ejercicio 29: Transacciones Reservas
-- Entidad central: reservas

-- 1. Listar todos los registros principales de la entidad central
SELECT * FROM reservas;

-- 2. Mostrar solo dos columnas relevantes
SELECT estado, fecha_inicio FROM reservas;

-- 3. Filtrar registros por una condicion de fecha
SELECT * FROM reservas WHERE fecha_inicio >= '2026-08-08';

-- 4. Ordenar resultados por fecha
SELECT * FROM reservas ORDER BY fecha_inicio;

-- 5. Mostrar las 5 reservas mas recientes
SELECT * FROM reservas ORDER BY fecha_inicio DESC LIMIT 5;

-- 6. Contar registros totales
SELECT COUNT(*) AS total_reservas FROM reservas;

-- 7. Promedio, minimo y maximo de duracion en horas de las reservas
SELECT
    AVG((julianday(fecha_fin) - julianday(fecha_inicio)) * 24) AS promedio_horas,
    MIN((julianday(fecha_fin) - julianday(fecha_inicio)) * 24) AS minimo_horas,
    MAX((julianday(fecha_fin) - julianday(fecha_inicio)) * 24) AS maximo_horas
FROM reservas;

-- 8. Agrupar reservas por estado
SELECT estado, COUNT(*) AS cantidad_reservas
FROM reservas
GROUP BY estado;

-- 9. Relacionar reservas, usuarios y recursos con JOIN
SELECT r.id_reserva, u.nombre AS usuario, rec.nombre AS recurso
FROM reservas r
JOIN usuarios u ON u.id_usuario = r.id_usuario
JOIN recursos rec ON rec.id_recurso = r.id_recurso;

-- 10. WHERE + ORDER BY + LIMIT
SELECT * FROM reservas
WHERE estado = 'confirmada'
ORDER BY fecha_inicio DESC
LIMIT 3;

-- 11. Reporte con alias legibles (incluye el pago si existe, con LEFT JOIN)
SELECT
    u.nombre AS usuario,
    rec.nombre AS recurso,
    r.fecha_inicio AS fecha_inicio,
    r.fecha_fin AS fecha_fin,
    r.estado AS estado_reserva,
    p.monto AS monto_pagado
FROM reservas r
JOIN usuarios u ON u.id_usuario = r.id_usuario
JOIN recursos rec ON rec.id_recurso = r.id_recurso
LEFT JOIN pagos p ON p.id_reserva = r.id_reserva;

-- 12. Consulta para decision de negocio: recurso con mayores ingresos por reservas pagadas
SELECT rec.nombre, SUM(p.monto) AS total_ingresos
FROM pagos p
JOIN reservas r ON r.id_reserva = p.id_reserva
JOIN recursos rec ON rec.id_recurso = r.id_recurso
GROUP BY rec.nombre
ORDER BY total_ingresos DESC
LIMIT 1;
