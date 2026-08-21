.headers on
.mode column

-- Ejercicio 006: Renta Autos de Lujo
-- Consultas de validacion.

-- 1. Que registros principales existen.
SELECT * FROM reservas;

-- 2. Que registros estan activos, pendientes o finalizados (aqui:
--    reservas que todavia no terminan).
SELECT id_reserva, id_vehiculo, nombre_cliente, fecha_inicio, estado
FROM reservas
WHERE estado <> 'finalizada';

-- 3. Que cliente reserva mas autos.
SELECT nombre_cliente, COUNT(*) AS total_reservas
FROM reservas
GROUP BY nombre_cliente
ORDER BY total_reservas DESC;

-- 4. Reservas ordenadas por fecha de inicio.
SELECT id_reserva, nombre_cliente, fecha_inicio, fecha_fin, estado
FROM reservas
ORDER BY fecha_inicio;

-- 5. Reporte util para la empresa: ingresos por vehiculo (sin contar
--    reservas canceladas), para decidir que auto conviene mantener en la
--    flota.
SELECT
    v.marca,
    v.modelo,
    v.placa,
    SUM(r.monto_total) AS ingresos_generados,
    COUNT(r.id_reserva) AS reservas_validas
FROM vehiculos v
JOIN reservas r ON r.id_vehiculo = v.id_vehiculo
WHERE r.estado <> 'cancelada'
GROUP BY v.id_vehiculo, v.marca, v.modelo, v.placa
ORDER BY ingresos_generados DESC;
