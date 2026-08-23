-- Ejercicio 26: Normalizacion Tienda
-- Entidad central: compras

-- 1. Listar todos los registros principales de la entidad central
SELECT * FROM compras;

-- 2. Mostrar solo dos columnas relevantes
SELECT cantidad, fecha FROM compras;

-- 3. Filtrar registros por una condicion numerica
SELECT * FROM compras WHERE cantidad > 1;

-- 4. Ordenar resultados por fecha
SELECT * FROM compras ORDER BY fecha;

-- 5. Mostrar las 5 compras con mayor cantidad
SELECT * FROM compras ORDER BY cantidad DESC LIMIT 5;

-- 6. Contar registros totales
SELECT COUNT(*) AS total_compras FROM compras;

-- 7. Promedio, minimo y maximo de la cantidad comprada
SELECT
    AVG(cantidad) AS promedio,
    MIN(cantidad) AS minimo,
    MAX(cantidad) AS maximo
FROM compras;

-- 8. Agrupar compras por producto
SELECT id_producto, COUNT(*) AS cantidad_compras, SUM(cantidad) AS unidades_compradas
FROM compras
GROUP BY id_producto;

-- 9. Relacionar compras, productos y categorias con JOIN
SELECT c.id_compra, p.nombre AS producto, cat.nombre AS categoria
FROM compras c
JOIN productos p ON p.id_producto = c.id_producto
JOIN categorias cat ON cat.id_categoria = p.id_categoria;

-- 10. WHERE + ORDER BY + LIMIT
SELECT * FROM compras
WHERE cantidad >= 2
ORDER BY fecha DESC
LIMIT 3;

-- 11. Reporte con alias legibles
SELECT
    cl.nombre AS cliente,
    p.nombre AS producto,
    cat.nombre AS categoria,
    c.cantidad AS cantidad_comprada,
    (c.cantidad * p.precio) AS total_compra,
    c.fecha AS fecha_compra
FROM compras c
JOIN clientes cl ON cl.id_cliente = c.id_cliente
JOIN productos p ON p.id_producto = c.id_producto
JOIN categorias cat ON cat.id_categoria = p.id_categoria;

-- 12. Consulta para decision de negocio: categoria con mayores ingresos totales
SELECT cat.nombre, SUM(c.cantidad * p.precio) AS total_ingresos
FROM compras c
JOIN productos p ON p.id_producto = c.id_producto
JOIN categorias cat ON cat.id_categoria = p.id_categoria
GROUP BY cat.nombre
ORDER BY total_ingresos DESC
LIMIT 1;
