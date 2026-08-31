.headers on
.mode column

-- Ejercicio 086: Delivery de Comida
-- Consultas que responden preguntas reales del cliente.

-- 1. Que registros principales existen: se usa la vista
-- vista_pedidos_completos (creada en ddl/schema.sql).
SELECT *
FROM vista_pedidos_completos;

-- 2. Que pedidos estan recibidos, en camino, entregados o
-- cancelados.
SELECT id_pedido, id_cliente, estado
FROM pedidos
ORDER BY estado;

-- 3. Que cliente tiene mas pedidos (ranking de actividad).
SELECT c.nombre_cliente, COUNT(*) AS total_pedidos
FROM clientes c
JOIN pedidos p ON p.id_cliente = c.id_cliente
GROUP BY c.id_cliente, c.nombre_cliente
ORDER BY total_pedidos DESC, c.nombre_cliente;

-- 4. Pedidos ordenados por fecha y, como segundo criterio, por monto
-- pagado (de mayor a menor), usando la vista para tener ambas
-- columnas listas.
SELECT id_pedido, fecha_pedido, monto_pagado
FROM vista_pedidos_completos
ORDER BY fecha_pedido, monto_pagado DESC;

-- 5. Reporte para decision de negocio: ingresos totales por
-- categoria de menu, para decidir en cual enfocar promociones
-- (GROUP BY + HAVING, usando la vista para no repetir el JOIN).
SELECT categoria,
       SUM(monto_pagado) AS ingresos_totales
FROM vista_pedidos_completos
WHERE monto_pagado IS NOT NULL
GROUP BY categoria
HAVING SUM(monto_pagado) > 0
ORDER BY ingresos_totales DESC;
