.headers on
.mode column

-- Ejercicio 001: Cafeteria Campus
-- 1. Productos disponibles.
SELECT id, nombre, categoria, precio
FROM productos
WHERE estado = 'activo'
ORDER BY nombre;

-- 2. Ventas pendientes o pagadas.
SELECT id, estudiante, fecha, estado
FROM ventas
WHERE estado IN ('pendiente', 'pagada')
ORDER BY fecha;

-- 3. Ventas con el nombre del producto.
SELECT v.id, v.estudiante, p.nombre, v.cantidad, v.estado
FROM ventas AS v
JOIN productos AS p ON p.id = v.producto_id;

-- 4. Ingresos por producto.
SELECT p.nombre, SUM(v.cantidad) AS unidades,
	   SUM(v.cantidad * p.precio) AS ingresos
FROM ventas AS v
JOIN productos AS p ON p.id = v.producto_id
WHERE v.estado = 'pagada'
GROUP BY p.id, p.nombre
ORDER BY ingresos DESC;

-- 5. Total recaudado por metodo de pago.
SELECT metodo_pago, COUNT(*) AS ventas,
	   SUM(cantidad * (SELECT precio FROM productos WHERE id = producto_id)) AS total
FROM ventas
WHERE estado = 'pagada'
GROUP BY metodo_pago;
