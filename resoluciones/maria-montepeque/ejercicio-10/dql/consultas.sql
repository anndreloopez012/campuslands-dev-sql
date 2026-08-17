-- Ejercicio 10: Hotel Reservas
-- Entidad central: pagos

-- 1. Listar todos los registros principales de la entidad central
SELECT * FROM pagos;

-- 2. Mostrar solo dos columnas relevantes
SELECT monto, metodo FROM pagos;

-- 3. Filtrar registros por una condicion numerica
SELECT * FROM pagos WHERE monto > 400;

-- 4. Ordenar resultados por fecha
SELECT * FROM pagos ORDER BY fecha_pago;

-- 5. Mostrar los 5 pagos de mayor monto
SELECT * FROM pagos ORDER BY monto DESC LIMIT 5;

-- 6. Contar registros totales
SELECT COUNT(*) AS total_pagos FROM pagos;

-- 7. Promedio, minimo y maximo de monto pagado
SELECT
    AVG(monto) AS promedio,
    MIN(monto) AS minimo,
    MAX(monto) AS maximo
FROM pagos;

-- 8. Agrupar pagos por metodo
SELECT metodo, COUNT(*) AS cantidad
FROM pagos
GROUP BY metodo;

-- 9. Relacionar pagos, reservas y huespedes con JOIN
SELECT p.id_pago, h.nombre AS huesped, r.fecha_checkin
FROM pagos p
JOIN reservas r ON r.id_reserva = p.id_reserva
JOIN huespedes h ON h.id_huesped = r.id_huesped;

-- 10. WHERE + ORDER BY + LIMIT
SELECT * FROM pagos
WHERE metodo = 'tarjeta'
ORDER BY monto DESC
LIMIT 3;

-- 11. Reporte con alias legibles
SELECT
    h.nombre AS huesped,
    ha.numero AS habitacion,
    p.monto AS monto_pagado,
    p.metodo AS metodo_pago,
    p.fecha_pago AS fecha
FROM pagos p
JOIN reservas r ON r.id_reserva = p.id_reserva
JOIN huespedes h ON h.id_huesped = r.id_huesped
JOIN habitaciones ha ON ha.id_habitacion = r.id_habitacion;

-- 12. Consulta para decision de negocio: huesped que mas ha pagado en total
SELECT h.nombre, SUM(p.monto) AS total_pagado
FROM pagos p
JOIN reservas r ON r.id_reserva = p.id_reserva
JOIN huespedes h ON h.id_huesped = r.id_huesped
GROUP BY h.nombre
ORDER BY total_pagado DESC
LIMIT 1;
