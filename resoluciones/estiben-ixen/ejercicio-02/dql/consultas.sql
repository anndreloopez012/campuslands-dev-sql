.headers on
.mode column

-- Ejercicio 02: Campus Shop SQLite
-- Autor: Brandon Estiben Ixen

-- 1. Listar todas las ventas ordenadas de la mas reciente a la mas antigua
SELECT v.id_venta, c.nombre_cliente, p.nombre_producto, v.cantidad, v.fecha_venta
FROM ventas v
JOIN clientes  c ON v.id_cliente  = c.id_cliente
JOIN productos p ON v.id_producto = p.id_producto
ORDER BY v.fecha_venta DESC;

-- 2. Mostrar el producto vendido y la fecha de venta
SELECT p.nombre_producto, v.fecha_venta
FROM ventas   v
JOIN productos p ON v.id_producto = p.id_producto;

-- 3. Filtrar productos con precio mayor a 500
SELECT nombre_producto, precio, cantidad_stock
FROM productos
WHERE precio > 500.00;

-- 4. Ordenar productos alfabeticamente por nombre
SELECT nombre_producto, precio
FROM productos
ORDER BY nombre_producto ASC;

-- 5. Top 5 ventas mas recientes
SELECT v.id_venta, c.nombre_cliente, p.nombre_producto, v.fecha_venta
FROM ventas   v
JOIN clientes  c ON v.id_cliente  = c.id_cliente
JOIN productos p ON v.id_producto = p.id_producto
ORDER BY v.fecha_venta DESC
LIMIT 5;

-- 6. Contar la cantidad de productos registrados
SELECT COUNT(*) AS total_productos
FROM productos;

-- 7. Calcular precio promedio, minimo y maximo
SELECT ROUND(AVG(precio), 2) AS precio_promedio,
       MIN(precio)            AS precio_minimo,
       MAX(precio)            AS precio_maximo
FROM productos;

-- 8. Agrupar ventas para conocer el total vendido por producto
SELECT p.nombre_producto,
       COUNT(v.id_venta)    AS veces_vendido,
       SUM(v.cantidad)      AS unidades_totales
FROM productos p
LEFT JOIN ventas v ON p.id_producto = v.id_producto
GROUP BY p.id_producto
ORDER BY unidades_totales DESC;

-- 9. Unir productos y categorias para mostrar inventario clasificado
SELECT p.nombre_producto,
       cat.nombre_categoria,
       p.cantidad_stock,
       p.precio
FROM productos  p
JOIN categorias cat ON p.id_categoria = cat.id_categoria
ORDER BY cat.nombre_categoria, p.nombre_producto;

-- 10. Ultimas 5 compras realizadas por el cliente con id 1
SELECT p.nombre_producto, v.cantidad, v.fecha_venta
FROM ventas   v
JOIN productos p ON v.id_producto = p.id_producto
WHERE v.id_cliente = 1
ORDER BY v.fecha_venta DESC
LIMIT 5;

-- 11. Reporte con nombres de columnas legibles
SELECT c.nombre_cliente   AS cliente,
       p.nombre_producto  AS producto,
       cat.nombre_categoria AS categoria,
       v.cantidad         AS unidades,
       (v.cantidad * p.precio) AS total_venta,
       v.fecha_venta      AS fecha
FROM ventas     v
JOIN clientes   c   ON v.id_cliente  = c.id_cliente
JOIN productos  p   ON v.id_producto = p.id_producto
JOIN categorias cat ON p.id_categoria = cat.id_categoria
ORDER BY v.fecha_venta DESC;

-- 12. Productos con mayor cantidad de ventas (decision de inventario)
SELECT p.nombre_producto,
       COUNT(v.id_venta)              AS veces_vendido,
       SUM(v.cantidad)                AS unidades_vendidas,
       p.cantidad_stock               AS stock_actual,
       ROUND(SUM(v.cantidad * p.precio), 2) AS ingreso_total
FROM productos p
LEFT JOIN ventas v ON p.id_producto = v.id_producto
GROUP BY p.id_producto
ORDER BY unidades_vendidas DESC;
