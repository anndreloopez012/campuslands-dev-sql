-- Ejercicio 14: Marketplace Campus
-- Entidad central: ordenes

-- 1. Listar todos los registros principales de la entidad central
SELECT * FROM ordenes;

-- 2. Mostrar solo dos columnas relevantes
SELECT cantidad, estado FROM ordenes;

-- 3. Filtrar registros por una condicion numerica
SELECT * FROM ordenes WHERE cantidad > 1;

-- 4. Ordenar resultados por fecha
SELECT * FROM ordenes ORDER BY fecha;

-- 5. Mostrar las 5 ordenes con mayor cantidad
SELECT * FROM ordenes ORDER BY cantidad DESC LIMIT 5;

-- 6. Contar registros totales
SELECT COUNT(*) AS total_ordenes FROM ordenes;

-- 7. Promedio, minimo y maximo de la cantidad ordenada
SELECT
    AVG(cantidad) AS promedio,
    MIN(cantidad) AS minimo,
    MAX(cantidad) AS maximo
FROM ordenes;

-- 8. Agrupar ordenes por estado
SELECT estado, COUNT(*) AS cantidad_ordenes
FROM ordenes
GROUP BY estado;

-- 9. Relacionar ordenes, productos y compradores con JOIN
SELECT o.id_orden, c.nombre AS comprador, p.nombre AS producto
FROM ordenes o
JOIN compradores c ON c.id_comprador = o.id_comprador
JOIN productos p ON p.id_producto = o.id_producto;

-- 10. WHERE + ORDER BY + LIMIT
SELECT * FROM ordenes
WHERE estado = 'pagada'
ORDER BY cantidad DESC
LIMIT 3;

-- 11. Reporte con alias legibles
SELECT
    c.nombre AS comprador,
    p.nombre AS producto,
    v.nombre AS vendedor,
    o.cantidad AS cantidad_ordenada,
    o.estado AS estado_orden,
    o.fecha AS fecha_orden
FROM ordenes o
JOIN compradores c ON c.id_comprador = o.id_comprador
JOIN productos p ON p.id_producto = o.id_producto
JOIN vendedores v ON v.id_vendedor = p.id_vendedor;

-- 12. Consulta para decision de negocio: producto con mayor cantidad total vendida
SELECT p.nombre, SUM(o.cantidad) AS total_vendido
FROM ordenes o
JOIN productos p ON p.id_producto = o.id_producto
GROUP BY p.nombre
ORDER BY total_vendido DESC
LIMIT 1;
