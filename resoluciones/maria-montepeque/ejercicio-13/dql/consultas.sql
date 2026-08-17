-- Ejercicio 13: Banco Cuentas
-- Entidad central: transacciones

-- 1. Listar todos los registros principales de la entidad central
SELECT * FROM transacciones;

-- 2. Mostrar solo dos columnas relevantes
SELECT tipo, monto FROM transacciones;

-- 3. Filtrar registros por una condicion numerica
SELECT * FROM transacciones WHERE monto > 300;

-- 4. Ordenar resultados por fecha
SELECT * FROM transacciones ORDER BY fecha;

-- 5. Mostrar las 5 transacciones de mayor monto
SELECT * FROM transacciones ORDER BY monto DESC LIMIT 5;

-- 6. Contar registros totales
SELECT COUNT(*) AS total_transacciones FROM transacciones;

-- 7. Promedio, minimo y maximo del monto transaccionado
SELECT
    AVG(monto) AS promedio,
    MIN(monto) AS minimo,
    MAX(monto) AS maximo
FROM transacciones;

-- 8. Agrupar transacciones por tipo
SELECT tipo, COUNT(*) AS cantidad
FROM transacciones
GROUP BY tipo;

-- 9. Relacionar transacciones, cuentas y clientes con JOIN
SELECT t.id_transaccion, c.nombre AS cliente, cu.numero_cuenta
FROM transacciones t
JOIN cuentas cu ON cu.id_cuenta = t.id_cuenta
JOIN clientes c ON c.id_cliente = cu.id_cliente;

-- 10. WHERE + ORDER BY + LIMIT
SELECT * FROM transacciones
WHERE tipo = 'deposito'
ORDER BY monto DESC
LIMIT 3;

-- 11. Reporte con alias legibles
SELECT
    c.nombre AS cliente,
    cu.numero_cuenta AS cuenta,
    t.tipo AS tipo_movimiento,
    t.monto AS monto_movimiento,
    t.fecha AS fecha_movimiento
FROM transacciones t
JOIN cuentas cu ON cu.id_cuenta = t.id_cuenta
JOIN clientes c ON c.id_cliente = cu.id_cliente;

-- 12. Consulta para decision de negocio: cliente con mayor monto total transaccionado
SELECT c.nombre, SUM(t.monto) AS total_transaccionado
FROM transacciones t
JOIN cuentas cu ON cu.id_cuenta = t.id_cuenta
JOIN clientes c ON c.id_cliente = cu.id_cliente
GROUP BY c.nombre
ORDER BY total_transaccionado DESC
LIMIT 1;
