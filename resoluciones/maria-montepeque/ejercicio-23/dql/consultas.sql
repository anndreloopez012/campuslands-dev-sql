-- Ejercicio 23: Facturacion Simple
-- Entidad central: detalle_factura

-- 1. Listar todos los registros principales de la entidad central
SELECT * FROM detalle_factura;

-- 2. Mostrar solo dos columnas relevantes
SELECT cantidad, precio_unitario FROM detalle_factura;

-- 3. Filtrar registros por una condicion numerica
SELECT * FROM detalle_factura WHERE cantidad > 1;

-- 4. Ordenar resultados por id de factura
SELECT * FROM detalle_factura ORDER BY id_factura;

-- 5. Mostrar los 5 detalles con mayor subtotal de linea
SELECT *, (cantidad * precio_unitario) AS subtotal_linea
FROM detalle_factura
ORDER BY subtotal_linea DESC
LIMIT 5;

-- 6. Contar registros totales
SELECT COUNT(*) AS total_detalles FROM detalle_factura;

-- 7. Promedio, minimo y maximo de la cantidad vendida
SELECT
    AVG(cantidad) AS promedio,
    MIN(cantidad) AS minimo,
    MAX(cantidad) AS maximo
FROM detalle_factura;

-- 8. Agrupar detalles por producto
SELECT id_producto, COUNT(*) AS cantidad_lineas, SUM(cantidad) AS unidades_vendidas
FROM detalle_factura
GROUP BY id_producto;

-- 9. Relacionar detalle_factura, facturas y clientes con JOIN
SELECT d.id_detalle, c.nombre AS cliente, f.fecha AS fecha_factura
FROM detalle_factura d
JOIN facturas f ON f.id_factura = d.id_factura
JOIN clientes c ON c.id_cliente = f.id_cliente;

-- 10. WHERE + ORDER BY + LIMIT
SELECT * FROM detalle_factura
WHERE cantidad >= 2
ORDER BY id_factura DESC
LIMIT 3;

-- 11. Reporte con alias legibles
SELECT
    c.nombre AS cliente,
    p.nombre AS producto,
    d.cantidad AS cantidad_vendida,
    d.precio_unitario AS precio_unitario,
    (d.cantidad * d.precio_unitario) AS subtotal_linea,
    f.fecha AS fecha_factura
FROM detalle_factura d
JOIN facturas f ON f.id_factura = d.id_factura
JOIN clientes c ON c.id_cliente = f.id_cliente
JOIN productos p ON p.id_producto = d.id_producto;

-- 12. Consulta para decision de negocio: producto con mayores ingresos totales
SELECT p.nombre, SUM(d.cantidad * d.precio_unitario) AS total_ingresos
FROM detalle_factura d
JOIN productos p ON p.id_producto = d.id_producto
GROUP BY p.nombre
ORDER BY total_ingresos DESC
LIMIT 1;
