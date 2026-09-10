.headers on
.mode column

-- Ejercicio 97: JOIN Nivel Aplicado
-- Consultas de validacion.

-- 1. Mostrar todos los datos principales: INNER JOIN de las 3 tablas.
SELECT v.id_venta, cl.nombre_cliente, p.nombre_producto, v.cantidad, v.fecha_venta
FROM ventas v
INNER JOIN clientes cl ON cl.id_cliente = v.id_cliente
INNER JOIN productos p ON p.id_producto = v.id_producto;

-- 2. Consulta con WHERE: solo las ventas de 2 unidades o mas.
SELECT id_venta, id_cliente, id_producto, cantidad
FROM ventas
WHERE cantidad >= 2;

-- 3. Consulta con ORDER BY: ventas ordenadas por fecha.
SELECT id_venta, id_producto, cantidad, fecha_venta
FROM ventas
ORDER BY fecha_venta;

-- 4. Conteo o resumen: total de ventas (transacciones) por cliente.
SELECT id_cliente, COUNT(*) AS total_ventas
FROM ventas
GROUP BY id_cliente;

-- 5. Caso de negocio con JOIN: reporte final de ingresos por
-- producto, incluyendo los productos que todavia NO se han vendido.
-- LEFT JOIN desde productos (tabla izquierda) hacia ventas conserva
-- TODOS los productos aunque no tengan ninguna venta; COALESCE
-- convierte a 0 el SUM que resultaria en NULL para esos productos sin
-- ventas (SUM sobre un grupo sin filas coincidentes es NULL, no 0).
-- Este es el reporte que el negocio necesita para decidir que
-- productos del menu no se estan vendiendo.
SELECT p.nombre_producto,
       COALESCE(SUM(v.cantidad * p.precio_unitario), 0) AS total_facturado
FROM productos p
LEFT JOIN ventas v ON v.id_producto = p.id_producto
GROUP BY p.id_producto, p.nombre_producto
ORDER BY total_facturado DESC;

-- Caso comentado que no es recomendable, dejar comentado: el mismo
-- reporte de ingresos por producto, pero usando INNER JOIN en vez de
-- LEFT JOIN. Al no haber ninguna venta que combine con "Muffin de
-- Arandanos", el INNER JOIN descarta esa fila por completo: el
-- producto desaparece del reporte en vez de aparecer con
-- total_facturado = 0. Se verifico con Python (sqlite3) que esta
-- version devuelve solo 3 productos en vez de los 4 del catalogo
-- completo, ocultando al negocio que existe un producto sin ninguna
-- venta.
-- SELECT p.nombre_producto,
--        SUM(v.cantidad * p.precio_unitario) AS total_facturado
-- FROM productos p
-- INNER JOIN ventas v ON v.id_producto = p.id_producto
-- GROUP BY p.id_producto, p.nombre_producto
-- ORDER BY total_facturado DESC;
