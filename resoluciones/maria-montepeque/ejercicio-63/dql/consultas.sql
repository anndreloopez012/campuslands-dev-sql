.headers on
.mode column

-- Ejercicio 63: AUTO_INCREMENT Nivel Intermedio
-- Consultas de validacion.

-- 1. Mostrar todos los datos principales (ventas con cliente y producto).
SELECT v.id_venta, c.nombre AS cliente, p.nombre AS producto,
       v.cantidad, v.fecha_venta
FROM ventas v
JOIN clientes c ON c.id_cliente = v.id_cliente
JOIN productos p ON p.id_producto = v.id_producto;

-- 2. Consulta con WHERE: ventas de mas de una unidad.
SELECT id_venta, id_cliente, id_producto, cantidad
FROM ventas
WHERE cantidad > 1;

-- 3. Consulta con ORDER BY: ventas ordenadas por id descendente.
SELECT id_venta, fecha_venta
FROM ventas
ORDER BY id_venta DESC;

-- 4. Conteo o resumen: total de ventas registradas.
SELECT COUNT(*) AS total_ventas FROM ventas;

-- 5. Validacion especifica de AUTO_INCREMENT: el id 3 (venta eliminada)
-- nunca vuelve a aparecer, y la ultima venta insertada recibio un id
-- nuevo (6), no el que quedo libre.
SELECT id_venta, id_cliente, id_producto
FROM ventas
ORDER BY id_venta;

SELECT id_venta
FROM ventas
WHERE id_venta = 3;
-- Debe devolver 0 filas: el id 3 quedo libre pero AUTOINCREMENT no lo reutilizo.
