SELECT
    id_producto,
    id_categoria,
    nombre,
    precio,
    stock,
    fecha_ingreso
FROM productos;


SELECT
    nombre,
    precio
FROM productos;


SELECT
    id_producto,
    nombre,
    precio,
    stock
FROM productos
WHERE precio > 1000;


SELECT
    id_producto,
    nombre,
    precio
FROM productos
ORDER BY nombre ASC;


SELECT
    id_producto,
    nombre,
    precio
FROM productos
ORDER BY precio DESC
LIMIT 5;


SELECT COUNT(*) AS total_productos
FROM productos;


SELECT
    AVG(precio) AS precio_promedio,
    MIN(precio) AS precio_minimo,
    MAX(precio) AS precio_maximo
FROM productos;



SELECT
    c.nombre AS categoria,
    COUNT(p.id_producto) AS cantidad_productos
FROM categorias AS c
JOIN productos AS p
    ON p.id_categoria = c.id_categoria
GROUP BY c.id_categoria, c.nombre
ORDER BY cantidad_productos DESC;



SELECT
    v.id_venta,
    c.nombre_completo AS cliente,
    p.nombre AS producto,
    v.cantidad,
    v.precio_unitario,
    v.fecha_venta
FROM ventas AS v
JOIN clientes AS c
    ON c.id_cliente = v.id_cliente
JOIN productos AS p
    ON p.id_producto = v.id_producto
ORDER BY v.fecha_venta ASC;


SELECT
    id_producto,
    nombre,
    precio,
    stock
FROM productos
WHERE stock > 10
ORDER BY precio DESC
LIMIT 5;


SELECT
    v.id_venta AS "Numero de venta",
    c.nombre_completo AS "Cliente",
    p.nombre AS "Producto",
    v.cantidad AS "Cantidad",
    v.precio_unitario AS "Precio unitario",
    v.cantidad * v.precio_unitario AS "Total venta",
    v.fecha_venta AS "Fecha de venta"
FROM ventas AS v
JOIN clientes AS c
    ON c.id_cliente = v.id_cliente
JOIN productos AS p
    ON p.id_producto = v.id_producto
ORDER BY v.fecha_venta ASC;

SELECT
    id_producto,
    nombre,
    stock,
    CASE
        WHEN stock <= 15 THEN 'REABASTECER'
        WHEN stock <= 25 THEN 'VIGILAR'
        ELSE 'STOCK SUFICIENTE'
    END AS decision_inventario
FROM productos
WHERE stock <= 25
ORDER BY stock ASC;