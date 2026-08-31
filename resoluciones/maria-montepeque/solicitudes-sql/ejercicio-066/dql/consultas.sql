.headers on
.mode column

-- Ejercicio 066: Hotel Gamers
-- Consultas que responden preguntas reales del cliente.

-- 1. Que registros principales existen: todas las reservas con
-- huesped y habitacion.
SELECT r.id_reserva,
       h.nombre AS huesped,
       hab.numero AS habitacion,
       hab.tipo,
       r.fecha_entrada,
       r.fecha_salida,
       r.estado
FROM reservas r
JOIN huespedes h ON h.id_huesped = r.id_huesped
JOIN habitaciones hab ON hab.id_habitacion = r.id_habitacion;

-- 2. Que registros estan activos, finalizados o cancelados.
SELECT id_reserva, estado
FROM reservas
ORDER BY estado;

-- 3. Que huesped tiene mas actividad (ranking por numero de consumos).
SELECT h.nombre AS huesped,
       COUNT(*) AS total_consumos
FROM consumos c
JOIN reservas r ON r.id_reserva = c.id_reserva
JOIN huespedes h ON h.id_huesped = r.id_huesped
GROUP BY h.id_huesped
ORDER BY total_consumos DESC;

-- 4. Consumos ordenados por fecha, del mas reciente al mas antiguo.
SELECT id_consumo, descripcion, monto, fecha_consumo
FROM consumos
ORDER BY fecha_consumo DESC;

-- 5. Reporte para decision de negocio: facturacion por huesped
-- (habitacion segun noches + consumos), huespedes que superan Q1000
-- (GROUP BY + HAVING). Se calcula primero el total por reserva en una
-- subconsulta, para no duplicar el costo de habitacion cuando una
-- reserva tiene varios consumos.
SELECT h.nombre AS huesped,
       SUM(t.costo_habitacion) AS total_habitacion,
       SUM(t.costo_consumos) AS total_consumos,
       SUM(t.costo_habitacion + t.costo_consumos) AS total_facturado
FROM (
    SELECT r.id_reserva,
           r.id_huesped,
           ROUND(julianday(r.fecha_salida) - julianday(r.fecha_entrada)) * hab.precio_noche AS costo_habitacion,
           COALESCE((SELECT SUM(c.monto) FROM consumos c WHERE c.id_reserva = r.id_reserva), 0) AS costo_consumos
    FROM reservas r
    JOIN habitaciones hab ON hab.id_habitacion = r.id_habitacion
) t
JOIN huespedes h ON h.id_huesped = t.id_huesped
GROUP BY h.id_huesped
HAVING total_facturado > 1000
ORDER BY total_facturado DESC;
