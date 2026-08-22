.headers on
.mode column

-- Ejercicio 020: Soldadura Industrial
-- 1. Materiales de soldadura
SELECT id, tipo, precio_kg FROM materiales;

-- 2. Ordenes registradas con costo total
SELECT o.id, c.empresa, m.tipo, o.peso_kg, (o.peso_kg * m.precio_kg) AS total FROM ordenes o JOIN clientes c ON c.id = o.cliente_id JOIN materiales m ON m.id = o.material_id;

-- 3. Total gastado por cliente en estructuras
SELECT c.empresa, SUM(o.peso_kg * m.precio_kg) AS total_invertido FROM ordenes o JOIN clientes c ON c.id = o.cliente_id JOIN materiales m ON m.id = o.material_id GROUP BY c.id, c.empresa;