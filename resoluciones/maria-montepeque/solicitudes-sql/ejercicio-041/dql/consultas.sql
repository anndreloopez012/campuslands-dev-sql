.headers on
.mode column

-- Ejercicio 041: Hotel Gamers
-- Consultas de validacion.

-- 1. Que registros principales existen (con JOIN doble para mostrar el
--    huesped y la habitacion en vez de solo los id).
SELECT
    r.id_reserva,
    h.nombre_huesped,
    hab.numero_habitacion,
    hab.tipo,
    r.fecha_checkin,
    r.fecha_checkout,
    r.estado
FROM reservas r
JOIN huespedes h ON h.id_huesped = r.id_huesped
JOIN habitaciones hab ON hab.id_habitacion = r.id_habitacion;

-- 2. Que reservas no estan finalizadas todavia.
SELECT id_reserva, id_huesped, id_habitacion, fecha_checkin, estado
FROM reservas
WHERE estado <> 'finalizada';

-- 3. Que huesped tiene mas consumo acumulado.
SELECT h.nombre_huesped, SUM(c.monto) AS total_consumo
FROM huespedes h
JOIN reservas r ON r.id_huesped = h.id_huesped
JOIN consumos c ON c.id_reserva = r.id_reserva
GROUP BY h.id_huesped, h.nombre_huesped
ORDER BY total_consumo DESC;

-- 4. Reservas ordenadas por fecha de checkin.
SELECT h.nombre_huesped, hab.numero_habitacion, r.fecha_checkin
FROM reservas r
JOIN huespedes h ON h.id_huesped = r.id_huesped
JOIN habitaciones hab ON hab.id_habitacion = r.id_habitacion
ORDER BY r.fecha_checkin;

-- 5. Cuanto hay que facturar por cada reserva activa (noches x
--    precio de habitacion, mas sus consumos), para priorizar el
--    cobro de las cuentas mas altas. Las canceladas no facturan
--    estadia.
SELECT
    h.nombre_huesped,
    hab.numero_habitacion,
    r.estado,
    (julianday(r.fecha_checkout) - julianday(r.fecha_checkin)) AS noches,
    ROUND((julianday(r.fecha_checkout) - julianday(r.fecha_checkin)) * hab.precio_noche, 2) AS costo_habitacion,
    ROUND(COALESCE(SUM(c.monto), 0), 2) AS total_consumos,
    ROUND((julianday(r.fecha_checkout) - julianday(r.fecha_checkin)) * hab.precio_noche + COALESCE(SUM(c.monto), 0), 2) AS total_a_facturar
FROM reservas r
JOIN huespedes h ON h.id_huesped = r.id_huesped
JOIN habitaciones hab ON hab.id_habitacion = r.id_habitacion
LEFT JOIN consumos c ON c.id_reserva = r.id_reserva
WHERE r.estado <> 'cancelada'
GROUP BY r.id_reserva, h.nombre_huesped, hab.numero_habitacion, r.estado, r.fecha_checkin, r.fecha_checkout, hab.precio_noche
ORDER BY total_a_facturar DESC;
