.headers on
.mode column

-- Ejercicio 79: DELETE Nivel Aplicado
-- Consultas de validacion.

-- 1. Mostrar todos los datos principales (ventas con cliente y
-- producto).
SELECT v.id_venta,
       c.nombre_cliente,
       p.nombre_producto,
       v.cantidad,
       v.fecha_venta
FROM ventas v
JOIN clientes c ON c.id_cliente = v.id_cliente
JOIN productos p ON p.id_producto = v.id_producto;

-- 2. Consulta con WHERE: solo las ventas del 2026-08-01.
SELECT id_venta, id_cliente, id_producto, cantidad
FROM ventas
WHERE fecha_venta = '2026-08-01';

-- 3. Consulta con ORDER BY: ventas ordenadas por cantidad, de mayor a
-- menor.
SELECT id_venta, cantidad
FROM ventas
ORDER BY cantidad DESC;

-- 4. Conteo o resumen: total de ventas por fecha.
SELECT fecha_venta, COUNT(*) AS total_ventas
FROM ventas
GROUP BY fecha_venta;

-- 5. Caso de negocio con reporte final (nivel aplicado): total
-- cobrado por dia, calculado desde cero con cantidad * precio. Si
-- solo aparece el 2026-08-01 y con el monto correcto, los DELETE
-- cumplieron su proposito: el dia con la falla de caja ya no existe,
-- y la venta duplicada tampoco se cuenta.
SELECT v.fecha_venta,
       SUM(v.cantidad * p.precio) AS total_dia
FROM ventas v
JOIN productos p ON p.id_producto = v.id_producto
GROUP BY v.fecha_venta;
