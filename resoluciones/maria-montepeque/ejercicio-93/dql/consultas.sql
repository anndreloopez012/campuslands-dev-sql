.headers on
.mode column

-- Ejercicio 93: HAVING Nivel Intermedio
-- Consultas de validacion.

-- 1. Mostrar todos los datos principales.
SELECT p.id_producto, p.nombre_producto, c.nombre_categoria, p.precio_unitario
FROM productos p
JOIN categorias c ON c.id_categoria = p.id_categoria;

-- 2. Consulta con WHERE: solo los movimientos de salida.
SELECT id_movimiento, id_producto, cantidad, fecha_movimiento
FROM movimientos
WHERE tipo_movimiento = 'salida';

-- 3. Consulta con ORDER BY: movimientos ordenados por fecha.
SELECT id_movimiento, id_producto, tipo_movimiento, cantidad, fecha_movimiento
FROM movimientos
ORDER BY fecha_movimiento;

-- 4. Conteo o resumen: total de movimientos por categoria (GROUP BY, sin filtrar grupos todavia).
SELECT c.id_categoria, c.nombre_categoria, COUNT(*) AS total_movimientos
FROM movimientos m
JOIN productos p ON p.id_producto = m.id_producto
JOIN categorias c ON c.id_categoria = p.id_categoria
GROUP BY c.id_categoria, c.nombre_categoria;

-- 5. Validacion especifica de HAVING: categorias cuyas salidas
-- (unidades vendidas) suman mas de 30 unidades en total. Primero
-- WHERE deja solo los movimientos de salida (filtro por fila, antes
-- de agrupar), luego GROUP BY agrupa esas salidas por categoria a
-- traves del JOIN productos-movimientos, y HAVING filtra los grupos
-- resultantes quedandose solo con las categorias cuyo SUM(cantidad)
-- agregado supera 30 (a diferencia de WHERE, que no puede evaluar un
-- SUM porque las filas todavia no estan agrupadas).
SELECT c.nombre_categoria, SUM(m.cantidad) AS total_unidades_salida
FROM movimientos m
JOIN productos p ON p.id_producto = m.id_producto
JOIN categorias c ON c.id_categoria = p.id_categoria
WHERE m.tipo_movimiento = 'salida'
GROUP BY c.id_categoria, c.nombre_categoria
HAVING SUM(m.cantidad) > 30;

-- Caso comentado que no es recomendable, dejar comentado: escribir
-- HAVING antes de GROUP BY. El orden de clausulas en SQL es fijo
-- (SELECT ... FROM ... WHERE ... GROUP BY ... HAVING ... ORDER BY);
-- HAVING depende de los grupos que arma GROUP BY, por lo que no puede
-- ir antes. Se verifico con Python (sqlite3) que SQLite rechaza esta
-- consulta con el error "near GROUP: syntax error".
-- SELECT id_producto, SUM(cantidad) AS total_salida
-- FROM movimientos
-- HAVING SUM(cantidad) > 30
-- GROUP BY id_producto;
