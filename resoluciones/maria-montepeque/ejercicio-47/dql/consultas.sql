.headers on
.mode column

-- Ejercicio 47: FOREIGN KEY Nivel Basico
-- Consultas de validacion.

-- 1. Mostrar todos los datos principales.
SELECT * FROM ventas;

-- 2. Consulta con WHERE.
SELECT id_venta, id_cliente, id_producto, cantidad
FROM ventas
WHERE cantidad > 1;

-- 3. Consulta con ORDER BY.
SELECT id_venta, fecha_venta, cantidad
FROM ventas
ORDER BY fecha_venta;

-- 4. Conteo o resumen.
SELECT COUNT(*) AS total_ventas FROM ventas;

-- 5. Validacion especifica del tema FOREIGN KEY:
--    a) todo id_cliente y todo id_producto que aparece en ventas existe
--       realmente en su catalogo (si no fuera asi, el JOIN dejaria filas
--       sin coincidencia, y aqui no falta ninguna).
SELECT
    (SELECT COUNT(*) FROM ventas) AS total_ventas,
    (SELECT COUNT(*)
        FROM ventas v
        JOIN clientes c ON c.id_cliente = v.id_cliente
        JOIN productos p ON p.id_producto = v.id_producto) AS ventas_con_referencias_validas;

--    b) reporte que solo es posible gracias a la FOREIGN KEY: relacionar
--       ventas con el nombre real del cliente y del producto, con la
--       certeza de que la relacion siempre existe.
SELECT
    c.nombre AS cliente,
    p.nombre AS producto,
    v.cantidad AS cantidad,
    v.fecha_venta AS fecha
FROM ventas v
JOIN clientes c ON c.id_cliente = v.id_cliente
JOIN productos p ON p.id_producto = v.id_producto
ORDER BY v.fecha_venta;
