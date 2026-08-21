.headers on
.mode column

-- Ejercicio 016: Hotel Gamers
-- Consultas de validacion.

-- 1. Que registros principales existen.
SELECT * FROM reservas;

-- 2. Que reservas no estan finalizadas todavia.
SELECT id_reserva, id_habitacion, nombre_huesped, fecha_entrada, estado
FROM reservas
WHERE estado <> 'finalizada';

-- 3. Que huesped reserva mas.
SELECT nombre_huesped, COUNT(*) AS total_reservas
FROM reservas
GROUP BY nombre_huesped
ORDER BY total_reservas DESC;

-- 4. Reservas ordenadas por fecha de entrada.
SELECT id_reserva, nombre_huesped, fecha_entrada, fecha_salida, estado
FROM reservas
ORDER BY fecha_entrada;

-- 5. Reporte util para el hotel: ingresos por habitacion (sin contar
--    canceladas), para decidir que habitaciones mantener o remodelar.
SELECT
    h.numero_habitacion,
    h.tipo,
    SUM(r.monto_total) AS ingresos_generados,
    COUNT(r.id_reserva) AS reservas_validas
FROM habitaciones h
JOIN reservas r ON r.id_habitacion = h.id_habitacion
WHERE r.estado <> 'cancelada'
GROUP BY h.id_habitacion, h.numero_habitacion, h.tipo
ORDER BY ingresos_generados DESC;
