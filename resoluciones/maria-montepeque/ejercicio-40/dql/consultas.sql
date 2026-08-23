-- Ejercicio 40: Normalizacion Integrador Avanzado

-- 1. Reconstruir una vista similar al archivo original usando JOIN
-- (productos y movimientos de cada operacion concatenados con '|', como en el CSV original)
SELECT
    o.id_operacion,
    c.nombre AS cliente,
    v.nombre AS vendedor,
    (SELECT GROUP_CONCAT(p.nombre, '|')
        FROM detalle_producto dp JOIN productos p ON p.id_producto = dp.id_producto
        WHERE dp.id_operacion = o.id_operacion) AS productos,
    (SELECT GROUP_CONCAT(m.metodo_pago, '|') FROM movimientos m WHERE m.id_operacion = o.id_operacion) AS pagos,
    (SELECT GROUP_CONCAT(m.cuotas, '|') FROM movimientos m WHERE m.id_operacion = o.id_operacion) AS cuotas,
    (SELECT GROUP_CONCAT(m.zona_entrega, '|') FROM movimientos m WHERE m.id_operacion = o.id_operacion) AS entregas,
    (SELECT GROUP_CONCAT(m.estado, '|') FROM movimientos m WHERE m.id_operacion = o.id_operacion) AS estados
FROM operaciones o
JOIN clientes c ON c.id_cliente = o.id_cliente
JOIN vendedores v ON v.id_vendedor = o.id_vendedor
ORDER BY o.id_operacion;

-- 2. Listar entidades principales sin duplicados
SELECT DISTINCT nombre FROM clientes;
SELECT DISTINCT nombre FROM vendedores;
SELECT DISTINCT nombre FROM productos;

-- 3. Contar registros por categoria o estado (movimientos por estado)
SELECT estado, COUNT(*) AS cantidad
FROM movimientos
GROUP BY estado;

-- 4. Calcular un total por transaccion (cantidad de productos por operacion)
SELECT o.id_operacion, COUNT(*) AS cantidad_productos
FROM detalle_producto dp
JOIN operaciones o ON o.id_operacion = dp.id_operacion
GROUP BY o.id_operacion;

-- 5. Calcular promedio, minimo y maximo (cuotas de los movimientos)
SELECT
    AVG(cuotas) AS promedio,
    MIN(cuotas) AS minimo,
    MAX(cuotas) AS maximo
FROM movimientos;

-- 6. Buscar registros por texto con LIKE
SELECT * FROM clientes WHERE nombre LIKE 'Sergio%';
SELECT * FROM productos WHERE nombre LIKE '%Cable%';

-- 7. Filtrar por fecha o rango numerico
SELECT * FROM movimientos WHERE cuotas > 1;

-- 8. Mostrar top 5 por cantidad o monto (clientes con mas productos comprados)
SELECT c.nombre AS cliente, COUNT(*) AS cantidad_productos
FROM detalle_producto dp
JOIN operaciones o ON o.id_operacion = dp.id_operacion
JOIN clientes c ON c.id_cliente = o.id_cliente
GROUP BY c.nombre
ORDER BY cantidad_productos DESC
LIMIT 5;

-- 9. Detectar registros relacionados sin detalle (operaciones sin movimientos de pago registrados)
SELECT o.id_operacion, c.nombre AS cliente
FROM operaciones o
JOIN clientes c ON c.id_cliente = o.id_cliente
LEFT JOIN movimientos m ON m.id_operacion = o.id_operacion
WHERE m.id_movimiento IS NULL;

-- 10. Reporte final con alias legibles
SELECT
    c.nombre AS cliente,
    v.nombre AS vendedor,
    (SELECT GROUP_CONCAT(p.nombre, ', ')
        FROM detalle_producto dp JOIN productos p ON p.id_producto = dp.id_producto
        WHERE dp.id_operacion = o.id_operacion) AS productos_comprados,
    m.metodo_pago AS metodo_pago,
    m.cuotas AS cuotas,
    m.zona_entrega AS zona_entrega,
    m.estado AS estado
FROM operaciones o
JOIN clientes c ON c.id_cliente = o.id_cliente
JOIN vendedores v ON v.id_vendedor = o.id_vendedor
JOIN movimientos m ON m.id_operacion = o.id_operacion
ORDER BY o.id_operacion, m.id_movimiento;
