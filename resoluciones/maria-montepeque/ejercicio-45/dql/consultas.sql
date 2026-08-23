.headers on
.mode column

-- Ejercicio 45: PRIMARY KEY Nivel Intermedio
-- Consultas de validacion.

-- 1. Mostrar todos los datos principales.
SELECT * FROM ventas;

-- 2. Consulta con WHERE.
SELECT id_venta, codigo_barras, cantidad, fecha_venta
FROM ventas
WHERE cantidad > 1;

-- 3. Consulta con ORDER BY.
SELECT nombre, precio
FROM productos
ORDER BY precio DESC;

-- 4. Conteo o resumen.
SELECT
    COUNT(*) AS total_ventas,
    COUNT(DISTINCT codigo_barras) AS productos_distintos_vendidos,
    COUNT(DISTINCT id_cliente) AS clientes_distintos
FROM ventas;

-- 5. Validacion especifica del tema PRIMARY KEY:
--    a) el codigo_barras (PRIMARY KEY natural de productos) se repite
--       libremente en ventas como FOREIGN KEY: eso es correcto, la PK solo
--       exige unicidad en la tabla donde es llave primaria (productos), no
--       en las tablas que la referencian.
SELECT codigo_barras, COUNT(*) AS veces_vendido
FROM ventas
GROUP BY codigo_barras
ORDER BY veces_vendido DESC;

--    b) cada id_venta (PRIMARY KEY subrogada) identifica una fila unica de
--       ventas, incluso si dos ventas tienen exactamente el mismo cliente,
--       producto, cantidad y fecha (no hay forma de confundirlas).
SELECT id_venta, id_cliente, codigo_barras, cantidad, fecha_venta
FROM ventas
ORDER BY id_venta;
