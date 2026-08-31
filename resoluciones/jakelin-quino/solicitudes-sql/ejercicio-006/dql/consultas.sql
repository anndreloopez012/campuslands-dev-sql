.headers on
.mode column

-- Ejercicio 006: Renta Autos de Lujo
-- 1. Autos disponibles
SELECT id, marca, modelo, precio_dia FROM vehiculos WHERE estado = 'disponible';

-- 2. Reservas con cliente y auto
SELECT r.id, c.nombre AS cliente, v.marca, v.modelo, r.dias, r.total FROM reservas r JOIN clientes c ON c.id = r.cliente_id JOIN vehiculos v ON v.id = r.vehiculo_id;

-- 3. Total invertido por cliente
SELECT c.nombre, SUM(r.total) AS total_reservas FROM reservas r JOIN clientes c ON c.id = r.cliente_id GROUP BY c.id, c.nombre;