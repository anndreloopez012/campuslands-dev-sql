-- Ejercicio 28: Vistas y Reportes
-- Entidad central: pagos

-- 1. Listar todos los registros principales de la entidad central
SELECT * FROM pagos;

-- 2. Mostrar solo dos columnas relevantes
SELECT monto, metodo FROM pagos;

-- 3. Filtrar registros por una condicion numerica
SELECT * FROM pagos WHERE monto > 200;

-- 4. Ordenar resultados por fecha
SELECT * FROM pagos ORDER BY fecha;

-- 5. Mostrar los 5 pagos de mayor monto
SELECT * FROM pagos ORDER BY monto DESC LIMIT 5;

-- 6. Contar registros totales
SELECT COUNT(*) AS total_pagos FROM pagos;

-- 7. Promedio, minimo y maximo del monto pagado
SELECT
    AVG(monto) AS promedio,
    MIN(monto) AS minimo,
    MAX(monto) AS maximo
FROM pagos;

-- 8. Agrupar pagos por metodo
SELECT metodo, COUNT(*) AS cantidad_pagos, SUM(monto) AS total_recaudado
FROM pagos
GROUP BY metodo;

-- 9. Relacionar pagos, ventas y clientes con JOIN
SELECT p.id_pago, c.nombre AS cliente, v.total AS total_venta
FROM pagos p
JOIN ventas v ON v.id_venta = p.id_venta
JOIN clientes c ON c.id_cliente = v.id_cliente;

-- 10. WHERE + ORDER BY + LIMIT
SELECT * FROM pagos
WHERE metodo = 'tarjeta'
ORDER BY monto DESC
LIMIT 3;

-- 11. Reporte con alias legibles
SELECT
    c.nombre AS cliente,
    ve.nombre AS vendedor,
    p.monto AS monto_pagado,
    p.metodo AS metodo_pago,
    p.fecha AS fecha_pago
FROM pagos p
JOIN ventas v ON v.id_venta = p.id_venta
JOIN clientes c ON c.id_cliente = v.id_cliente
JOIN vendedores ve ON ve.id_vendedor = v.id_vendedor;

-- 12. Consulta para decision de negocio: cliente con mayor saldo pendiente por pagar
SELECT cliente, saldo_pendiente
FROM vista_resumen_ventas
ORDER BY saldo_pendiente DESC
LIMIT 1;

-- Consultas adicionales usando las vistas del ejercicio

-- Resumen completo de ventas (total facturado, pagado y saldo pendiente)
SELECT * FROM vista_resumen_ventas;

-- Ranking de vendedores por total vendido
SELECT * FROM vista_ranking_vendedores
ORDER BY total_vendido DESC;
