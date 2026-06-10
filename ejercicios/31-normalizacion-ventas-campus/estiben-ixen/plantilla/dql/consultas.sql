.headers on
.mode column

-- Ejercicio 31: Normalizacion Ventas Campus
-- Escriba aqui las consultas de validacion.

-- 1. Reconstruir vista similar al CSV original usando JOIN.
SELECT 
    v.fecha_venta AS Fecha,
    c.nombre_cliente AS Cliente,
    c.cliente_email AS Email,
    p.nombre_producto AS Producto,
    ve.nombre_vendedor AS Vendedor,
    ve.sucursal AS Sucursal,
    v.cantidad AS Cantidad_Vendida,
    p.precio AS Precio_Unitario,
    (v.cantidad * p.precio) AS Total_Venta
FROM venta v
JOIN cliente c ON v.id_cliente = c.id_cliente
JOIN producto p ON v.id_producto = p.id_producto
JOIN vendedor ve ON v.id_vendedor = ve.id_vendedor;

-- 2. Listar entidades principales sin duplicados.

SELECT DISTINCT nombre_cliente
FROM cliente;
JOIN venta on cliente.id_cliente = venta.id_cliente;

SELECT DISTINCT nombre_producto
FROM producto;
JOIN venta on producto.id_producto = venta.id_producto;

SELECT DISTINCT nombre_vendedor
FROM vendedor;
JOIN venta on vendedor.id_vendedor = venta.id vendedor;

-- 3. Contar registros por categoria o estado.
-- ventas registradas por sucursal
SELECT
    ve.sucursal AS Sucursal,
    COUNT(*) AS Total_Ventas
FROM venta v
JOIN vendedor ve ON v.id_vendedor = ve.id_vendedor
GROUP BY ve.sucursal;

-- vetas registradas por producto

SELECT
    p.nombre_producto AS Producto,
    COUNT(*) AS Total_Ventas
FROM venta v
JOIN producto p ON v.id_producto = p.id_producto
GROUP BY p.nombre_producto;


-- 4. Calcular total por transaccion.

SELECT 
    id_venta, 
    (cantidad * (SELECT precio FROM producto WHERE producto.id_producto = venta.id_producto)) AS total_transaccion
FROM venta;

-- 5. Calcular promedio, minimo o maximo.

SELECT
    p.nombre_producto AS Producto,
    AVG(v.cantidad) AS Promedio_Cantidad,
    MIN(v.cantidad) AS Min_Cantidad,
    MAX(v.cantidad) AS Max_Cantidad
FROM venta v;

-- 6. Buscar registros con LIKE.

SELECT * FROM producto WHERE nombre_producto LIKE '%gamer%';
SELECT * FROM cliente WHERE nombre_cliente LIKE 'ana%';

-- 7. Filtrar por fecha o rango numerico.

SELECT * FROM venta 
WHERE fecha_venta BETWEEN '2024-01-15' AND '2024-01-18';

SELECT * FROM venta 
WHERE cantidad > 1;

-- 8. Mostrar top 5 por cantidad o monto.

SELECT * FROM venta
order by cantidad DESC
LIMIT 5;

-- 9. Detectar registros relacionados sin detalle, si aplica.

SELECT p.nombre_producto 
FROM producto p
LEFT JOIN venta v ON p.id_producto = v.id_producto
WHERE v.id_producto IS NULL;

-- 10. Reporte final con alias legibles.

SELECT 
    v.fecha_venta AS "Fecha de Venta",
    c.nombre_cliente AS "Cliente",
    p.nombre_producto AS "Producto Adquirido",
    v.cantidad AS "Unidades",
    (v.cantidad * p.precio) AS "Subtotal en USD"
FROM venta v
JOIN cliente c ON v.id_cliente = c.id_cliente
JOIN producto p ON v.id_producto = p.id_producto
ORDER BY v.fecha_venta ASC;