PRAGMA foreign_keys = ON;

-- 1. Listar todos los registros principales de la entidad central.
SELECT
    id,
    nombre,
    precio,
    stock
FROM productos
ORDER BY id;

-- 2. Mostrar solo dos columnas relevantes de la entidad central.
SELECT
    nombre,
    precio
FROM productos
ORDER BY nombre;

-- 3. Filtrar registros por una condición numérica.
SELECT
    nombre,
    precio
FROM productos
WHERE precio >= 1000
ORDER BY precio DESC;

-- 4. Ordenar resultados por fecha.
SELECT
    id,
    nombre,
    fecha_ingreso
FROM productos
ORDER BY fecha_ingreso DESC;

-- 5. Mostrar los 5 productos más importantes según precio.
SELECT
    nombre,
    precio
FROM productos
ORDER BY precio DESC
LIMIT 5;

-- 6. Contar registros totales.
SELECT
    COUNT(*) AS total_productos
FROM productos;

-- 7. Calcular promedio, mínimo y máximo.
SELECT
    ROUND(AVG(precio), 2) AS promedio_precio,
    MIN(precio) AS precio_minimo,
    MAX(precio) AS precio_maximo
FROM productos;

-- 8. Agrupar productos por categoría.
SELECT
    c.nombre AS categoria,
    COUNT(p.id) AS total_productos
FROM categorias AS c
LEFT JOIN productos AS p
    ON p.categoria_id = c.id
GROUP BY
    c.id,
    c.nombre
ORDER BY
    total_productos DESC,
    c.nombre;

-- 9. Relacionar tres tablas mediante JOIN.
SELECT
    v.id,
    cl.nombre_completo AS cliente,
    p.nombre AS producto,
    v.cantidad,
    v.total
FROM ventas AS v
INNER JOIN clientes AS cl
    ON cl.id = v.cliente_id
INNER JOIN productos AS p
    ON p.id = v.producto_id
ORDER BY v.id;

-- 10. Consulta con WHERE, ORDER BY y LIMIT.
SELECT
    id,
    nombre,
    precio
FROM productos
WHERE stock > 10
ORDER BY precio DESC
LIMIT 5;

-- 11. Reporte con alias legibles.
SELECT
    cl.nombre_completo AS cliente,
    p.nombre AS producto,
    v.fecha_venta AS fecha,
    printf('Q %.2f', v.total) AS importe
FROM ventas AS v
INNER JOIN clientes AS cl
    ON cl.id = v.cliente_id
INNER JOIN productos AS p
    ON p.id = v.producto_id
ORDER BY v.fecha_venta;

-- 12. Consulta para apoyar una decisión del negocio.
SELECT
    p.nombre,
    SUM(v.cantidad) AS unidades_vendidas,
    SUM(v.total) AS ingresos
FROM ventas AS v
INNER JOIN productos AS p
    ON p.id = v.producto_id
GROUP BY
    p.id,
    p.nombre
HAVING SUM(v.cantidad) >= 2
ORDER BY ingresos DESC;