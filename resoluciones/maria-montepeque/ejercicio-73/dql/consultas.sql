.headers on
.mode column

-- Ejercicio 73: INSERT Nivel Aplicado
-- Consultas de validacion.

-- 1. Mostrar todos los datos principales (movimientos con producto y
-- categoria).
SELECT m.id_movimiento,
       p.nombre_producto,
       c.nombre_categoria,
       m.tipo_movimiento,
       m.cantidad,
       m.fecha_movimiento
FROM movimientos m
JOIN productos p ON p.id_producto = m.id_producto
JOIN categorias c ON c.id_categoria = p.id_categoria;

-- 2. Consulta con WHERE: solo las salidas de bodega.
SELECT id_movimiento, id_producto, cantidad
FROM movimientos
WHERE tipo_movimiento = 'salida';

-- 3. Consulta con ORDER BY: movimientos ordenados por fecha.
SELECT id_movimiento, fecha_movimiento, tipo_movimiento, cantidad
FROM movimientos
ORDER BY fecha_movimiento;

-- 4. Conteo o resumen: total de movimientos por tipo.
SELECT tipo_movimiento, COUNT(*) AS total
FROM movimientos
GROUP BY tipo_movimiento;

-- 5. Caso de negocio con reporte final (nivel aplicado): el stock
-- real de cada producto no se guardo en ninguna columna, se calcula
-- sumando todas las entradas y restando todas las salidas. Esta
-- consulta demuestra que los INSERT de movimientos cumplieron su
-- proposito: reconstruyen el stock actual desde cero, solo con el
-- historial.
SELECT p.nombre_producto,
       SUM(
           CASE
               WHEN m.tipo_movimiento = 'entrada' THEN m.cantidad
               ELSE -m.cantidad
           END
       ) AS stock_actual
FROM productos p
JOIN movimientos m ON m.id_producto = p.id_producto
GROUP BY p.id_producto, p.nombre_producto
ORDER BY p.nombre_producto;
