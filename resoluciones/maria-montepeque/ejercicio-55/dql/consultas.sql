.headers on
.mode column

-- Ejercicio 55: NOT NULL Nivel Aplicado
-- Consultas de validacion.

-- 1. Mostrar todos los datos principales.
SELECT * FROM movimientos;

-- 2. Consulta con WHERE.
SELECT id_movimiento, id_producto, cantidad, fecha_movimiento
FROM movimientos
WHERE tipo_movimiento = 'salida';

-- 3. Consulta con ORDER BY.
SELECT id_movimiento, id_producto, tipo_movimiento, fecha_movimiento
FROM movimientos
ORDER BY fecha_movimiento;

-- 4. Reporte final del caso de negocio: stock actual por producto
--    (entradas menos salidas). Este es el reporte que el negocio necesita
--    para saber que hay en bodega.
SELECT
    p.sku,
    p.nombre_producto,
    COALESCE(SUM(CASE WHEN m.tipo_movimiento = 'entrada' THEN m.cantidad
                       WHEN m.tipo_movimiento = 'salida' THEN -m.cantidad
                       ELSE 0 END), 0) AS stock_actual
FROM productos p
LEFT JOIN movimientos m ON m.id_producto = p.id_producto
GROUP BY p.id_producto, p.sku, p.nombre_producto
ORDER BY p.sku;

-- 5. Validacion especifica del tema NOT NULL:
--    a) ningun movimiento puede tener cantidad vacia: el conteo de
--       movimientos con cantidad no nula es igual al total de movimientos.
SELECT
    COUNT(*) AS total_movimientos,
    COUNT(cantidad) AS movimientos_con_cantidad
FROM movimientos;

--    b) contraste con un campo OPCIONAL (observaciones): aqui si es
--       normal que falten valores, y NOT NULL nunca lo exigio.
SELECT
    COUNT(*) AS total_movimientos,
    COUNT(observaciones) AS movimientos_con_observaciones,
    COUNT(*) - COUNT(observaciones) AS movimientos_sin_observaciones
FROM movimientos;
