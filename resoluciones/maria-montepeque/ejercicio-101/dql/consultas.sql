.headers on
.mode column

-- Ejercicio 101: Procedimientos almacenados Nivel Basico
-- Consultas de validacion.

-- 1. Mostrar todos los datos principales.
SELECT v.id_venta, p.nombre_producto, v.nombre_cliente, v.cantidad, v.fecha_venta
FROM ventas v
JOIN productos p ON p.id_producto = v.id_producto;

-- 2. Consulta con WHERE: solo las ventas de "Cafe Americano" (id_producto = 1).
SELECT id_venta, nombre_cliente, cantidad, fecha_venta
FROM ventas
WHERE id_producto = 1;

-- 3. Consulta con ORDER BY: ventas ordenadas por fecha.
SELECT id_venta, id_producto, cantidad, fecha_venta
FROM ventas
ORDER BY fecha_venta;

-- 4. Conteo o resumen: total de unidades vendidas por producto.
SELECT id_producto, SUM(cantidad) AS total_vendido
FROM ventas
GROUP BY id_producto;

-- 5. Validacion especifica de Procedimientos almacenados (via su
-- alternativa ejecutable, el trigger): el stock de cada producto debe
-- reflejar el descuento automatico que aplico
-- trg_actualizar_stock_venta en cada INSERT de dml/inserts.sql, SIN
-- que se haya escrito ningun UPDATE manual sobre "productos" en todo
-- el script. Esto demuestra que la logica de "registrar venta +
-- descontar stock" quedo encapsulada y se ejecuta sola, que es
-- justamente el proposito de un procedimiento almacenado.
SELECT id_producto, nombre_producto, stock
FROM productos
ORDER BY id_producto;

-- Caso comentado que no es recomendable, dejar comentado: intentar
-- crear el procedimiento almacenado directamente en SQLite, con la
-- sintaxis de MySQL/PostgreSQL. Se verifico con Python (sqlite3) que
-- SQLite rechaza la sentencia con el error
-- "near PROCEDURE: syntax error", porque CREATE PROCEDURE no existe
-- en su gramatica: SQLite no tiene el concepto de procedimiento
-- almacenado, solo funciones, vistas y triggers.
-- CREATE PROCEDURE registrar_venta (IN p_id_producto INT, IN p_cantidad INT)
-- BEGIN
--     UPDATE productos SET stock = stock - p_cantidad WHERE id_producto = p_id_producto;
-- END;
