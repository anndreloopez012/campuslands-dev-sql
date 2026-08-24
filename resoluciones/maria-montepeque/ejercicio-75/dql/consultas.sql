.headers on
.mode column

-- Ejercicio 75: UPDATE Nivel Intermedio
-- Consultas de validacion.

-- 1. Mostrar todos los datos principales (productos con su
-- categoria).
SELECT p.id_producto,
       p.nombre_producto,
       c.nombre_categoria,
       p.precio_unitario,
       p.stock_actual
FROM productos p
JOIN categorias c ON c.id_categoria = p.id_categoria;

-- 2. Consulta con WHERE: solo los movimientos de tipo salida.
SELECT id_movimiento, id_producto, cantidad
FROM movimientos
WHERE tipo_movimiento = 'salida';

-- 3. Consulta con ORDER BY: productos ordenados por stock actual, de
-- mayor a menor.
SELECT nombre_producto, stock_actual
FROM productos
ORDER BY stock_actual DESC;

-- 4. Conteo o resumen: total de movimientos por tipo.
SELECT tipo_movimiento, COUNT(*) AS total
FROM movimientos
GROUP BY tipo_movimiento;

-- 5. Validacion especifica de UPDATE: Laptop Pro 14 quedo con
-- stock_actual = 15 (broto 10, sumo 5 con el reabastecimiento) y
-- Mouse Inalambrico con stock_actual = 38 (broto 50, resto 12 por la
-- venta). Ademas, las dos laptops quedaron con el precio ya
-- actualizado un 10%.
SELECT nombre_producto, precio_unitario, stock_actual
FROM productos
WHERE id_producto IN (1, 2, 3);
