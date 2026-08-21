PRAGMA foreign_keys = ON;

-- 1. LISTAR TODOS LOS REGISTROS DE LA ENTIDAD CENTRAL

SELECT
    id_compra,
    id_cliente,
    id_producto,
    cantidad,
    fecha_compra
FROM compras;

-- 2. MOSTRAR DOS COLUMNAS RELEVANTES DE LA ENTIDAD CENTRAL

SELECT
    id_compra,
    fecha_compra
FROM compras;

-- 3. FILTRAR POR CONDICION NUMERICA

SELECT
    id_compra,
    id_cliente,
    id_producto,
    cantidad,
    fecha_compra
FROM compras
WHERE cantidad >= 2;

-- 4. ORDENAR POR FECHA

SELECT
    id_compra,
    id_cliente,
    id_producto,
    cantidad,
    fecha_compra
FROM compras
ORDER BY fecha_compra ASC;

-- 5. MOSTRAR LOS 5 REGISTROS MAS IMPORTANTES SEGUN CANTIDAD

SELECT
    id_compra,
    id_cliente,
    id_producto,
    cantidad,
    fecha_compra
FROM compras
ORDER BY cantidad DESC, fecha_compra ASC
LIMIT 5;

-- 6. CONTAR REGISTROS TOTALES

SELECT
    COUNT(*) AS total_compras
FROM compras;

-- 7. CALCULAR PROMEDIO, MINIMO Y MAXIMO

SELECT
    AVG(precio) AS precio_promedio,
    MIN(precio) AS precio_minimo,
    MAX(precio) AS precio_maximo
FROM productos;

-- 8. AGRUPAR REGISTROS

SELECT
    id_producto,
    SUM(cantidad) AS unidades_vendidas
FROM compras
GROUP BY id_producto
ORDER BY unidades_vendidas DESC;

-- 9. RELACIONAR TABLAS CON JOIN

SELECT
    c.id_compra,
    cl.nombre_completo AS cliente,
    p.nombre AS producto,
    p.precio,
    c.cantidad,
    c.fecha_compra
FROM compras AS c
INNER JOIN clientes AS cl
    ON cl.id_cliente = c.id_cliente
INNER JOIN productos AS p
    ON p.id_producto = c.id_producto
ORDER BY c.fecha_compra ASC;

-- 10. WHERE + ORDER BY + LIMIT

SELECT
    id_compra,
    id_cliente,
    id_producto,
    cantidad,
    fecha_compra
FROM compras
WHERE fecha_compra >= '2026-08-05'
ORDER BY cantidad DESC, fecha_compra DESC
LIMIT 5;

-- 11. REPORTE CON ALIAS LEGIBLES

SELECT
    c.id_compra AS 'ID Compra',
    cl.nombre_completo AS 'Cliente',
    p.nombre AS 'Producto',
    cat.nombre AS 'Categoria',
    c.cantidad AS 'Cantidad',
    p.precio AS 'Precio Unitario',
    c.cantidad * p.precio AS 'Total Compra',
    c.fecha_compra AS 'Fecha'
FROM compras AS c
INNER JOIN clientes AS cl
    ON cl.id_cliente = c.id_cliente
INNER JOIN productos AS p
    ON p.id_producto = c.id_producto
INNER JOIN categorias AS cat
    ON cat.id_categoria = p.id_categoria
ORDER BY c.fecha_compra ASC;

-- 12. DECISION DE NEGOCIO: PRODUCTOS CON MAYOR DEMANDA

SELECT
    p.nombre AS producto,
    cat.nombre AS categoria,
    SUM(c.cantidad) AS unidades_vendidas,
    CASE
        WHEN SUM(c.cantidad) >= 4 THEN 'Alta demanda'
        WHEN SUM(c.cantidad) >= 2 THEN 'Demanda media'
        ELSE 'Baja demanda'
    END AS nivel_demanda
FROM compras AS c
INNER JOIN productos AS p
    ON p.id_producto = c.id_producto
INNER JOIN categorias AS cat
    ON cat.id_categoria = p.id_categoria
GROUP BY
    p.id_producto,
    p.nombre,
    cat.nombre
ORDER BY unidades_vendidas DESC;