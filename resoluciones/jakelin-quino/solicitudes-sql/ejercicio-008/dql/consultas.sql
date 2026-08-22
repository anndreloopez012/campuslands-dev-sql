.headers on
.mode column

-- Ejercicio 008: Viajes Paracaidismo
-- 1. Modalidades de salto ofertadas
SELECT id, modalidad, altura_pies, precio FROM saltos;

-- 2. Reservas por cliente
SELECT r.id, c.nombre AS cliente, s.modalidad, s.precio, r.fecha FROM reservas r JOIN clientes c ON c.id = r.cliente_id JOIN saltos s ON s.id = r.salto_id;

-- 3. Total acumulado por modalidad de salto
SELECT s.modalidad, COUNT(r.id) AS reservas, SUM(s.precio) AS total FROM reservas r JOIN saltos s ON s.id = r.salto_id GROUP BY s.id, s.modalidad;