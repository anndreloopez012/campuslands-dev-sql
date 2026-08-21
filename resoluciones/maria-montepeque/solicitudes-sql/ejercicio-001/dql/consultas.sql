.headers on
.mode column

-- Ejercicio 001: Cafeteria Campus
-- Consultas de validacion.

-- 1. Que registros principales existen.
SELECT * FROM ventas;

-- 2. Que registros estan activos, pendientes o finalizados (aqui: ventas
--    que NO se cobraron, ya sea porque siguen pendientes o se cancelaron).
--    Despues de dml/operaciones.sql ya no queda ninguna 'pendiente' (se
--    corrigio la de Karen Solis), asi que esta consulta muestra la que
--    sigue sin resolverse: la cancelada.
SELECT id_venta, nombre_cliente, precio_pagado, fecha_venta, estado
FROM ventas
WHERE estado <> 'pagada';

-- 3. Que cliente tiene mas actividad (mas ventas pagadas).
SELECT nombre_cliente, COUNT(*) AS total_compras_pagadas
FROM ventas
WHERE estado = 'pagada'
GROUP BY nombre_cliente
ORDER BY total_compras_pagadas DESC;

-- 4. Ventas ordenadas por fecha.
SELECT id_venta, nombre_cliente, fecha_venta, estado
FROM ventas
ORDER BY fecha_venta;

-- 5. Reporte util para el cliente: ingresos por producto (solo ventas
--    pagadas), para decidir que reabastecer primero.
SELECT
    p.nombre_producto,
    p.categoria,
    SUM(v.precio_pagado) AS total_recaudado,
    COUNT(v.id_venta) AS ventas_pagadas
FROM productos p
JOIN ventas v ON v.id_producto = p.id_producto
WHERE v.estado = 'pagada'
GROUP BY p.id_producto, p.nombre_producto, p.categoria
ORDER BY total_recaudado DESC;
