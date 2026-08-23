-- Ejercicio 36: Normalizacion Hotel Reservas

-- 1. Reconstruir una vista similar al archivo original usando JOIN
-- (una fila por cada servicio de cada reserva, como quedaria "aplanado" el CSV original)
SELECT
    r.id_reserva,
    h.nombre AS huesped,
    h.documento AS documento,
    ha.numero AS habitacion,
    s.nombre AS servicio,
    ds.costo AS costo,
    ds.fecha AS fecha
FROM reservas r
JOIN huespedes h ON h.id_huesped = r.id_huesped
JOIN habitaciones ha ON ha.id_habitacion = r.id_habitacion
JOIN detalle_servicio ds ON ds.id_reserva = r.id_reserva
JOIN servicios s ON s.id_servicio = ds.id_servicio
ORDER BY r.id_reserva, ds.fecha;

-- 2. Listar entidades principales sin duplicados
SELECT DISTINCT nombre, documento FROM huespedes;
SELECT DISTINCT numero FROM habitaciones;
SELECT DISTINCT nombre, costo FROM servicios;

-- 3. Contar registros por categoria o estado (consumos por servicio)
SELECT s.nombre AS servicio, COUNT(*) AS veces_consumido
FROM detalle_servicio ds
JOIN servicios s ON s.id_servicio = ds.id_servicio
GROUP BY s.nombre;

-- 4. Calcular un total por transaccion (costo total por reserva)
SELECT r.id_reserva, SUM(ds.costo) AS total_reserva
FROM reservas r
JOIN detalle_servicio ds ON ds.id_reserva = r.id_reserva
GROUP BY r.id_reserva;

-- 5. Calcular promedio, minimo y maximo del costo de los servicios
SELECT
    AVG(costo) AS promedio,
    MIN(costo) AS minimo,
    MAX(costo) AS maximo
FROM detalle_servicio;

-- 6. Buscar registros por texto con LIKE
SELECT * FROM huespedes WHERE nombre LIKE 'Elena%';
SELECT * FROM servicios WHERE nombre LIKE '%a%';

-- 7. Filtrar por fecha o rango numerico
SELECT * FROM detalle_servicio WHERE fecha >= '2026-07-08';
SELECT * FROM detalle_servicio WHERE costo BETWEEN 60 AND 180;

-- 8. Mostrar top 5 por cantidad o monto (huespedes con mayor gasto total)
SELECT h.nombre AS huesped, SUM(ds.costo) AS gasto_total
FROM detalle_servicio ds
JOIN reservas r ON r.id_reserva = ds.id_reserva
JOIN huespedes h ON h.id_huesped = r.id_huesped
GROUP BY h.nombre
ORDER BY gasto_total DESC
LIMIT 5;

-- 9. Detectar registros relacionados sin detalle (reservas sin servicios consumidos)
SELECT r.id_reserva, h.nombre AS huesped, ha.numero AS habitacion
FROM reservas r
JOIN huespedes h ON h.id_huesped = r.id_huesped
JOIN habitaciones ha ON ha.id_habitacion = r.id_habitacion
LEFT JOIN detalle_servicio ds ON ds.id_reserva = r.id_reserva
WHERE ds.id_detalle IS NULL;

-- 10. Reporte final con alias legibles
SELECT
    h.nombre AS huesped,
    ha.numero AS habitacion,
    s.nombre AS servicio,
    ds.costo AS costo_servicio,
    ds.fecha AS fecha_consumo
FROM reservas r
JOIN huespedes h ON h.id_huesped = r.id_huesped
JOIN habitaciones ha ON ha.id_habitacion = r.id_habitacion
JOIN detalle_servicio ds ON ds.id_reserva = r.id_reserva
JOIN servicios s ON s.id_servicio = ds.id_servicio
ORDER BY r.id_reserva, ds.fecha;
