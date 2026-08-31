-- 1. Listar todos los registros principales de la entidad central
SELECT * FROM detalle_pedido;

-- 2. Mostrar solo dos columnas relevantes
SELECT cantidad, precio_unitario FROM detalle_pedido;

-- 3. Filtrar registros por una condicion numerica
SELECT * FROM detalle_pedido WHERE cantidad > 1;

-- 4. Ordenar resultados por id de pedido
SELECT * FROM detalle_pedido ORDER BY id_pedido;

-- 5. Mostrar los 5 renglones con mayor monto (cantidad * precio_unitario)
SELECT *, (cantidad * precio_unitario) AS monto
FROM detalle_pedido
ORDER BY monto DESC
LIMIT 5;

-- 6. Contar registros totales
SELECT COUNT(*) AS total_lineas FROM detalle_pedido;

-- 7. Promedio, minimo y maximo del monto por linea
SELECT
    AVG(cantidad * precio_unitario) AS promedio,
    MIN(cantidad * precio_unitario) AS minimo,
    MAX(cantidad * precio_unitario) AS maximo
FROM detalle_pedido;
