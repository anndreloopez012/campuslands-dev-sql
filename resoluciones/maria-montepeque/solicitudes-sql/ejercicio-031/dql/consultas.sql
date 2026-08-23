.headers on
.mode column

-- Ejercicio 031: Renta Autos de Lujo
-- Consultas de validacion.

-- 1. Que registros principales existen (con JOIN doble para mostrar el
--    cliente y el vehiculo en vez de solo los id numericos).
SELECT
    r.id_reserva,
    c.nombre_cliente,
    v.marca,
    v.modelo,
    r.fecha_inicio,
    r.fecha_fin,
    r.monto_total,
    r.estado
FROM reservas r
JOIN clientes c ON c.id_cliente = r.id_cliente
JOIN vehiculos v ON v.id_vehiculo = r.id_vehiculo;

-- 2. Que reservas no estan finalizadas todavia.
SELECT id_reserva, id_cliente, id_vehiculo, fecha_inicio, estado
FROM reservas
WHERE estado <> 'finalizada';

-- 3. Que cliente tiene mas reservas.
SELECT c.nombre_cliente, COUNT(*) AS total_reservas
FROM clientes c
JOIN reservas r ON r.id_cliente = c.id_cliente
GROUP BY c.id_cliente, c.nombre_cliente
ORDER BY total_reservas DESC;

-- 4. Reservas ordenadas por fecha de inicio.
SELECT c.nombre_cliente, v.marca, v.modelo, r.fecha_inicio
FROM reservas r
JOIN clientes c ON c.id_cliente = r.id_cliente
JOIN vehiculos v ON v.id_vehiculo = r.id_vehiculo
ORDER BY r.fecha_inicio;

-- 5. Ingresos por vehiculo (sin contar canceladas), para decidir que
--    auto conviene mantener en la flota.
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
