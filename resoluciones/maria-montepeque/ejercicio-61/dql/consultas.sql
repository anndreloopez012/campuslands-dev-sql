.headers on
.mode column

-- Ejercicio 61: DEFAULT Nivel Aplicado
-- Consultas de validacion.

-- 1. Mostrar todos los datos principales (ventas con cliente y producto).
SELECT v.id_venta, c.nombre AS cliente, p.nombre AS producto,
       v.cantidad, v.fecha_venta, v.estado
FROM ventas v
JOIN clientes c ON c.id_cliente = v.id_cliente
JOIN productos p ON p.id_producto = v.id_producto;

-- 2. Consulta con WHERE: ventas ya pagadas.
SELECT id_venta, id_cliente, id_producto, cantidad, estado
FROM ventas
WHERE estado = 'pagada';

-- 3. Consulta con ORDER BY: ventas ordenadas por fecha descendente.
SELECT id_venta, fecha_venta, estado
FROM ventas
ORDER BY fecha_venta DESC;

-- 4. Conteo o resumen: cantidad de ventas por estado.
SELECT estado, COUNT(*) AS total_ventas
FROM ventas
GROUP BY estado;

-- 5. Validacion especifica del tema DEFAULT: clientes, productos y
-- ventas que quedaron con el valor por defecto correspondiente
-- (no se indico el valor en el INSERT).
SELECT id_cliente, nombre, tipo_cliente
FROM clientes
WHERE tipo_cliente = 'regular';

SELECT id_producto, nombre, categoria, disponible
FROM productos
WHERE categoria = 'bebida' AND disponible = 1;

SELECT id_venta, cantidad, estado
FROM ventas
WHERE cantidad = 1 AND estado = 'pendiente';

-- 6. Consulta de decision de negocio (nivel aplicado): ingresos totales
-- por producto solo con ventas 'pagada', usando el precio del producto.
SELECT p.nombre AS producto,
       SUM(v.cantidad) AS unidades_vendidas,
       SUM(v.cantidad * p.precio) AS ingresos_totales
FROM ventas v
JOIN productos p ON p.id_producto = v.id_producto
WHERE v.estado = 'pagada'
GROUP BY p.id_producto
ORDER BY ingresos_totales DESC;
