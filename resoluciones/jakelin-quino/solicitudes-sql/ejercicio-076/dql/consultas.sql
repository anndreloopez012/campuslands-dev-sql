.headers on
.mode column

-- Ejercicio 076: Cafeteria Campus
-- 1. Productos disponibles
SELECT id, nombre, categoria, precio FROM productos ORDER BY nombre;

-- 2. Ventas registradas
SELECT v.id, v.estudiante, p.nombre, v.cantidad, v.metodo_pago FROM ventas v JOIN productos p ON p.id = v.producto_id;

-- 3. Total de ventas por metodo de pago
SELECT metodo_pago, COUNT(*) AS total_ventas FROM ventas GROUP BY metodo_pago;