-- Ejercicio 09: Gimnasio Membresias
-- Entidad central: pagos

-- 1. Listar todos los registros principales de la entidad central
SELECT * FROM pagos;

-- 2. Mostrar solo dos columnas relevantes
SELECT monto, metodo FROM pagos;

-- 3. Filtrar registros por una condicion numerica
SELECT * FROM pagos WHERE monto > 200;

-- 4. Ordenar resultados por fecha
SELECT * FROM pagos ORDER BY fecha_pago;

-- 5. Mostrar los 5 pagos de mayor monto
SELECT * FROM pagos ORDER BY monto DESC LIMIT 5;

-- 6. Contar registros totales
SELECT COUNT(*) AS total_pagos FROM pagos;

-- 7. Promedio, minimo y maximo de monto pagado
SELECT
    AVG(monto) AS promedio,
    MIN(monto) AS minimo,
    MAX(monto) AS maximo
FROM pagos;

-- 8. Agrupar pagos por metodo
SELECT metodo, COUNT(*) AS cantidad
FROM pagos
GROUP BY metodo;

-- 9. Relacionar pagos, membresias y clientes con JOIN
SELECT p.id_pago, c.nombre AS cliente, pl.nombre AS plan
FROM pagos p
JOIN membresias m ON m.id_membresia = p.id_membresia
JOIN clientes c ON c.id_cliente = m.id_cliente
JOIN planes pl ON pl.id_plan = m.id_plan;

-- 10. WHERE + ORDER BY + LIMIT
SELECT * FROM pagos
WHERE metodo = 'tarjeta'
ORDER BY monto DESC
LIMIT 3;

-- 11. Reporte con alias legibles
SELECT
    c.nombre AS cliente,
    pl.nombre AS plan,
    p.monto AS monto_pagado,
    p.metodo AS metodo_pago,
    p.fecha_pago AS fecha
FROM pagos p
JOIN membresias m ON m.id_membresia = p.id_membresia
JOIN clientes c ON c.id_cliente = m.id_cliente
JOIN planes pl ON pl.id_plan = m.id_plan;

-- 12. Consulta para decision de negocio: cliente que mas ha pagado en total
SELECT c.nombre, SUM(p.monto) AS total_pagado
FROM pagos p
JOIN membresias m ON m.id_membresia = p.id_membresia
JOIN clientes c ON c.id_cliente = m.id_cliente
GROUP BY c.nombre
ORDER BY total_pagado DESC
LIMIT 1;
