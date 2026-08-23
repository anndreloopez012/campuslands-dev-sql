.headers on
.mode column

-- Ejercicio 57: CHECK Nivel Intermedio
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

-- 4. Conteo o resumen: movimientos por tipo.
SELECT tipo_movimiento, COUNT(*) AS total
FROM movimientos
GROUP BY tipo_movimiento
ORDER BY tipo_movimiento;

-- 5. Validacion especifica del tema CHECK:
--    a) ninguna cantidad registrada es cero o negativa (el CHECK de rango
--       numerico nunca dejo entrar un valor invalido).
SELECT MIN(cantidad) AS cantidad_minima_registrada
FROM movimientos;

--    b) ningun producto tiene precio_unitario en cero o negativo (mismo
--       tipo de regla aplicada en otra tabla).
SELECT MIN(precio_unitario) AS precio_minimo_registrado
FROM productos;
