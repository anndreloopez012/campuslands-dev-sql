.headers on
.mode column

-- Ejercicio 054: Tienda Sneakers
-- 1. Sneakers en inventario
SELECT id, modelo, marca, precio, stock FROM productos WHERE stock > 0;

-- 2. Ventas con cliente y producto
SELECT v.id, c.nombre AS cliente, p.modelo, v.cantidad, (v.cantidad * p.precio) AS total FROM ventas v JOIN clientes c ON c.id = v.cliente_id JOIN productos p ON p.id = v.producto_id;

-- 3. Total recaudado por marca
SELECT p.marca, SUM(v.cantidad * p.precio) AS total_ventas FROM ventas v JOIN productos p ON p.id = v.producto_id GROUP BY p.marca;