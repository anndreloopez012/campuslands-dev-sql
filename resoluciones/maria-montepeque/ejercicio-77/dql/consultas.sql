.headers on
.mode column

-- Ejercicio 77: DELETE Nivel Basico
-- Consultas de validacion.

-- 1. Mostrar todos los datos principales (movimientos con producto y
-- categoria).
SELECT m.id_movimiento,
       p.nombre_producto,
       c.nombre_categoria,
       m.tipo_movimiento,
       m.cantidad
FROM movimientos m
JOIN productos p ON p.id_producto = m.id_producto
JOIN categorias c ON c.id_categoria = p.id_categoria;

-- 2. Consulta con WHERE: solo los productos activos.
SELECT id_producto, nombre_producto, activo
FROM productos
WHERE activo = 1;

-- 3. Consulta con ORDER BY: movimientos ordenados por fecha.
SELECT id_movimiento, fecha_movimiento, cantidad
FROM movimientos
ORDER BY fecha_movimiento;

-- 4. Conteo o resumen: total de movimientos por producto.
SELECT id_producto, COUNT(*) AS total_movimientos
FROM movimientos
GROUP BY id_producto;

-- 5. Validacion especifica de DELETE: el movimiento duplicado
-- (id_movimiento = 6) ya no existe, pero el resto de movimientos de
-- Mouse Inalambrico (id_producto = 3) sigue intacto.
SELECT id_movimiento
FROM movimientos
WHERE id_movimiento = 6;
-- Debe devolver 0 filas: el duplicado se elimino con DELETE.

SELECT COUNT(*) AS movimientos_mouse
FROM movimientos
WHERE id_producto = 3;
-- Debe devolver 1: solo queda el movimiento real, no el duplicado.
