.headers on
.mode column

-- Ejercicio 81: SELECT Nivel Intermedio
-- Consultas de validacion.

-- 1. Mostrar todos los datos principales: ventas con JOIN a cliente y
-- producto, alias descriptivos y una expresion calculada (subtotal).
SELECT v.id_venta,
       c.nombre_cliente AS cliente,
       p.nombre_producto AS producto,
       v.cantidad,
       p.precio,
       (v.cantidad * p.precio) AS subtotal
FROM ventas v
JOIN clientes c ON c.id_cliente = v.id_cliente
JOIN productos p ON p.id_producto = v.id_producto;

-- 2. Consulta con WHERE: ventas del 2026-08-01.
SELECT id_venta, id_cliente, id_producto, cantidad
FROM ventas
WHERE fecha_venta = '2026-08-01';

-- 3. Consulta con ORDER BY: productos ordenados por precio, de mayor
-- a menor.
SELECT nombre_producto, precio
FROM productos
ORDER BY precio DESC;

-- 4. Conteo o resumen: cantidad total vendida por producto.
SELECT p.nombre_producto, SUM(v.cantidad) AS unidades_vendidas
FROM ventas v
JOIN productos p ON p.id_producto = v.id_producto
GROUP BY p.id_producto, p.nombre_producto;

-- 5. Validacion especifica de SELECT (nivel intermedio: subconsulta y
-- DISTINCT). Productos con precio por encima del precio promedio de
-- todo el catalogo: la subconsulta calcula el promedio una sola vez y
-- el SELECT externo lo usa para filtrar.
SELECT nombre_producto, precio
FROM productos
WHERE precio > (SELECT AVG(precio) FROM productos);

-- DISTINCT: cuantos clientes distintos compraron algo (sin contar
-- repetidos, aunque un cliente haya comprado varias veces).
SELECT COUNT(DISTINCT id_cliente) AS clientes_distintos
FROM ventas;

-- Caso comentado que debe fallar (no ser recomendable), dejar
-- comentado: hacer JOIN entre dos tablas que comparten un nombre de
-- columna (id_producto) sin calificarlo con el alias de la tabla.
-- SQLite no sabe de cual tabla tomar la columna.
-- SELECT id_producto FROM productos, ventas;
