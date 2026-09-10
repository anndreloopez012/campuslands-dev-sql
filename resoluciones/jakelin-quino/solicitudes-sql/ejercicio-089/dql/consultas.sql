.headers on
.mode column

-- Ejercicio 089: Mecanica de Autos
-- 1. Vehiculos y sus dueños
SELECT v.placa, v.modelo, c.nombre AS propietario FROM vehiculos v JOIN clientes c ON c.id = v.cliente_id;

-- 2. Ordenes de reparacion activas
SELECT o.id, v.placa, o.falla, o.costo_estimado FROM ordenes o JOIN vehiculos v ON v.id = o.vehiculo_id;

-- 3. Costo total estimado por vehiculo
SELECT v.placa, SUM(o.costo_estimado) AS total_reparaciones FROM ordenes o JOIN vehiculos v ON v.id = o.vehiculo_id GROUP BY v.id, v.placa;