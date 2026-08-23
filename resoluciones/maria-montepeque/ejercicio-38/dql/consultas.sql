-- Ejercicio 38: Normalizacion Ecommerce Envios

-- 1. Reconstruir una vista similar al archivo original usando JOIN
-- (productos de cada orden concatenados con '|', como en el CSV original)
SELECT
    o.id_orden,
    c.nombre AS comprador,
    (SELECT GROUP_CONCAT(p.nombre, '|')
        FROM detalle_orden d JOIN productos p ON p.id_producto = d.id_producto
        WHERE d.id_orden = o.id_orden) AS productos,
    COALESCE(cu.codigo, 'SIN_CUPON') AS cupon,
    pa.metodo_pago AS metodo_pago,
    e.direccion_envio AS direccion_envio,
    e.transportadora AS transportadora
FROM ordenes o
JOIN compradores c ON c.id_comprador = o.id_comprador
LEFT JOIN cupones cu ON cu.id_cupon = o.id_cupon
JOIN pagos pa ON pa.id_orden = o.id_orden
JOIN envios e ON e.id_orden = o.id_orden
ORDER BY o.id_orden;

-- 2. Listar entidades principales sin duplicados
SELECT DISTINCT nombre FROM compradores;
SELECT DISTINCT nombre, precio FROM productos;
SELECT DISTINCT codigo FROM cupones;

-- 3. Contar registros por categoria o estado (ordenes por metodo de pago)
SELECT metodo_pago, COUNT(*) AS cantidad_ordenes
FROM pagos
GROUP BY metodo_pago;

-- 4. Calcular un total por transaccion (monto por orden, via detalle_orden)
SELECT o.id_orden, SUM(d.cantidad * d.precio_unitario) AS total_orden
FROM ordenes o
JOIN detalle_orden d ON d.id_orden = o.id_orden
GROUP BY o.id_orden;

-- 5. Calcular promedio, minimo y maximo del monto pagado
SELECT
    AVG(monto) AS promedio,
    MIN(monto) AS minimo,
    MAX(monto) AS maximo
FROM pagos;

-- 6. Buscar registros por texto con LIKE
SELECT * FROM productos WHERE nombre LIKE '%Audifonos%';
SELECT * FROM compradores WHERE nombre LIKE 'Nadia%';

-- 7. Filtrar por fecha o rango numerico
SELECT * FROM pagos WHERE monto BETWEEN 100 AND 500;
SELECT * FROM productos WHERE precio > 1000;

-- 8. Mostrar top 5 por cantidad o monto (productos con mas unidades vendidas)
SELECT p.nombre AS producto, SUM(d.cantidad) AS unidades_vendidas
FROM detalle_orden d
JOIN productos p ON p.id_producto = d.id_producto
GROUP BY p.nombre
ORDER BY unidades_vendidas DESC
LIMIT 5;

-- 9. Detectar registros relacionados sin detalle (ordenes sin cupon aplicado)
SELECT o.id_orden, c.nombre AS comprador
FROM ordenes o
JOIN compradores c ON c.id_comprador = o.id_comprador
WHERE o.id_cupon IS NULL;

-- 10. Reporte final con alias legibles
SELECT
    c.nombre AS comprador,
    (SELECT GROUP_CONCAT(p.nombre, ', ')
        FROM detalle_orden d JOIN productos p ON p.id_producto = d.id_producto
        WHERE d.id_orden = o.id_orden) AS productos_comprados,
    COALESCE(cu.codigo, 'Sin cupon') AS cupon_usado,
    pa.metodo_pago AS metodo_pago,
    pa.monto AS monto_pagado,
    e.direccion_envio AS direccion_envio,
    e.transportadora AS transportadora
FROM ordenes o
JOIN compradores c ON c.id_comprador = o.id_comprador
LEFT JOIN cupones cu ON cu.id_cupon = o.id_cupon
JOIN pagos pa ON pa.id_orden = o.id_orden
JOIN envios e ON e.id_orden = o.id_orden
ORDER BY o.id_orden;
