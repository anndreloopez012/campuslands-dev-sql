.headers on
.mode column

-- Ejercicio 91: GROUP BY Nivel Aplicado
-- Consultas de validacion.

-- 1. Mostrar todos los datos principales.
SELECT p.id_producto, p.nombre_producto, c.nombre_categoria,
       p.precio_unitario, p.stock_inicial
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

-- 4. Conteo o resumen: total de movimientos registrados por producto (GROUP BY simple).
SELECT id_producto, COUNT(*) AS total_movimientos
FROM movimientos
GROUP BY id_producto;

-- 5. Caso de negocio con GROUP BY: reporte de stock calculado por
-- producto (stock_inicial + entradas - salidas), usando HAVING para
-- quedarse solo con los productos en sobreventa (stock calculado
-- negativo), que es la validacion final que el negocio necesita.
SELECT p.nombre_producto,
       p.stock_inicial,
       SUM(CASE WHEN m.tipo_movimiento = 'entrada' THEN m.cantidad ELSE 0 END) AS total_entradas,
       SUM(CASE WHEN m.tipo_movimiento = 'salida' THEN m.cantidad ELSE 0 END) AS total_salidas,
       p.stock_inicial
           + SUM(CASE WHEN m.tipo_movimiento = 'entrada' THEN m.cantidad ELSE 0 END)
           - SUM(CASE WHEN m.tipo_movimiento = 'salida' THEN m.cantidad ELSE 0 END)
           AS stock_calculado
FROM productos p
JOIN movimientos m ON m.id_producto = p.id_producto
GROUP BY p.id_producto, p.nombre_producto, p.stock_inicial
HAVING stock_calculado < 0;

-- Caso comentado que no es recomendable, dejar comentado: intentar
-- filtrar un total agregado usando WHERE en vez de HAVING. WHERE se
-- evalua fila por fila antes de que existan los grupos, por lo que no
-- puede usar SUM(); SQLite responde con el error
-- "misuse of aggregate function SUM()". El filtro correcto sobre un
-- agregado va en HAVING, como en la consulta 5.
-- SELECT id_producto, SUM(cantidad) AS total_salida
-- FROM movimientos
-- WHERE tipo_movimiento = 'salida' AND SUM(cantidad) > 40
-- GROUP BY id_producto;
