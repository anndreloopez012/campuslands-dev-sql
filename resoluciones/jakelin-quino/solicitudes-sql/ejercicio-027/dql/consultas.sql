.headers on
.mode column

-- Ejercicio 027: Taller de Motos
-- 1. Motos con su propietario
SELECT m.placa, m.marca, c.nombre AS propietario FROM motos m JOIN clientes c ON c.id = m.cliente_id;

-- 2. Servicios pendientes
SELECT s.id, m.placa, s.descripcion, s.costo FROM servicios s JOIN motos m ON m.id = s.moto_id WHERE s.estado = 'pendiente';

-- 3. Total gastado por moto
SELECT m.placa, SUM(s.costo) AS total FROM servicios s JOIN motos m ON m.id = s.moto_id WHERE s.estado = 'completado' GROUP BY m.id, m.placa;