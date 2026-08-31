.headers on
.mode column

-- Ejercicio 109: Indices Nivel Aplicado
-- Consultas de validacion.

-- 1. Mostrar todos los datos principales.
SELECT m.id_movimiento, p.nombre_producto, m.tipo_movimiento, m.cantidad, m.fecha_movimiento
FROM movimientos m
JOIN productos p ON p.id_producto = m.id_producto;

-- 2. Consulta con WHERE: solo los movimientos de salida.
SELECT id_movimiento, id_producto, cantidad, fecha_movimiento
FROM movimientos
WHERE tipo_movimiento = 'salida';

-- 3. Consulta con ORDER BY: movimientos ordenados por fecha.
SELECT id_movimiento, id_producto, tipo_movimiento, fecha_movimiento
FROM movimientos
ORDER BY fecha_movimiento;

-- 4. Conteo o resumen: total de unidades de salida por producto.
SELECT id_producto, SUM(cantidad) AS total_salida
FROM movimientos
WHERE tipo_movimiento = 'salida'
GROUP BY id_producto;

-- 5. Caso de negocio con Indices: reporte de salidas recientes del
-- producto 1 ("Laptop Pro 15"), el reporte que la bodega consulta a
-- diario para decidir reabastecimiento. EXPLAIN QUERY PLAN confirma
-- que esta consulta usa "SEARCH ... USING INDEX idx_movimientos_salida
-- (id_producto=?)" en vez de "SCAN movimientos": el indice parcial
-- (que solo contiene las filas de salida) es justo lo que este
-- reporte necesita, sin gastar espacio indexando las entradas.
EXPLAIN QUERY PLAN
SELECT id_movimiento, cantidad, fecha_movimiento
FROM movimientos
WHERE tipo_movimiento = 'salida' AND id_producto = 1;

-- Caso comentado que no es recomendable, dejar comentado: esperar que
-- idx_movimientos_salida tambien acelere un reporte de ENTRADAS del
-- mismo producto. Un indice parcial solo cubre las filas que
-- cumplen su condicion WHERE (aqui, tipo_movimiento = 'salida'); las
-- filas de entrada simplemente no estan en el indice. Se verifico
-- con Python (sqlite3) que el EXPLAIN QUERY PLAN de esta consulta
-- (identica a la 5, pero con tipo_movimiento = 'entrada') muestra
-- "SCAN movimientos", NO "SEARCH ... USING INDEX
-- idx_movimientos_salida", porque el indice parcial no incluye
-- ninguna fila de entrada que buscar.
-- EXPLAIN QUERY PLAN
-- SELECT id_movimiento, cantidad, fecha_movimiento
-- FROM movimientos
-- WHERE tipo_movimiento = 'entrada' AND id_producto = 1;
