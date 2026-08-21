PRAGMA foreign_keys = ON;

-- 1. LISTAR TODOS LOS REGISTROS DE LA ENTIDAD CENTRAL

SELECT
    id_transaccion,
    id_cuenta,
    tipo_transaccion,
    monto,
    fecha_hora,
    descripcion
FROM transacciones;

-- 2. MOSTRAR DOS COLUMNAS RELEVANTES

SELECT
    tipo_transaccion,
    monto
FROM transacciones;

-- 3. FILTRAR TRANSACCIONES POR MONTO

SELECT
    id_transaccion,
    id_cuenta,
    tipo_transaccion,
    monto
FROM transacciones
WHERE monto >= 1000
ORDER BY monto DESC;

-- 4. ORDENAR TRANSACCIONES POR FECHA

SELECT
    id_transaccion,
    fecha_hora,
    monto
FROM transacciones
ORDER BY fecha_hora DESC;

-- 5. CINCO CUENTAS CON MAYOR SALDO

SELECT
    id_cuenta,
    numero_cuenta,
    saldo
FROM cuentas
ORDER BY saldo DESC
LIMIT 5;

-- 6. CONTAR TRANSACCIONES TOTALES

SELECT
    COUNT(*) AS total_transacciones
FROM transacciones;

-- 7. PROMEDIO, MINIMO Y MAXIMO DE LOS MOVIMIENTOS

SELECT
    ROUND(AVG(monto), 2) AS promedio_monto,
    MIN(monto) AS monto_minimo,
    MAX(monto) AS monto_maximo
FROM transacciones;

-- 8. AGRUPAR TRANSACCIONES POR TIPO

SELECT
    tipo_transaccion,
    COUNT(*) AS cantidad_transacciones,
    ROUND(SUM(monto), 2) AS monto_total
FROM transacciones
GROUP BY tipo_transaccion
ORDER BY monto_total DESC;

-- 9. RELACIONAR CLIENTES Y CUENTAS

SELECT
    cl.nombre_completo,
    c.numero_cuenta,
    c.tipo_cuenta,
    c.saldo
FROM clientes AS cl
INNER JOIN cuentas AS c
    ON c.id_cliente = cl.id_cliente
ORDER BY cl.nombre_completo ASC;

-- 10. WHERE, ORDER BY Y LIMIT

SELECT
    id_transaccion,
    id_cuenta,
    tipo_transaccion,
    monto,
    fecha_hora
FROM transacciones
WHERE tipo_transaccion IN ('Deposito', 'Transferencia')
ORDER BY monto DESC
LIMIT 5;

-- 11. REPORTE CON ALIAS LEGIBLES

SELECT
    cl.nombre_completo AS "Cliente",
    c.numero_cuenta AS "Cuenta",
    t.tipo_transaccion AS "Tipo de Movimiento",
    t.monto AS "Monto",
    t.fecha_hora AS "Fecha y Hora",
    t.descripcion AS "Descripcion"
FROM transacciones AS t
INNER JOIN cuentas AS c
    ON c.id_cuenta = t.id_cuenta
INNER JOIN clientes AS cl
    ON cl.id_cliente = c.id_cliente
ORDER BY t.fecha_hora DESC;

-- 12. DECISION DE NEGOCIO: CUENTAS CON MAYOR ACTIVIDAD

SELECT
    c.numero_cuenta AS "Cuenta",
    cl.nombre_completo AS "Cliente",
    c.saldo AS "Saldo Actual",
    COUNT(t.id_transaccion) AS "Total Movimientos",
    ROUND(COALESCE(SUM(t.monto), 0), 2) AS "Monto Movido",
    CASE
        WHEN COUNT(t.id_transaccion) >= 4
             AND c.saldo >= 5000
            THEN 'Cliente de alta actividad'
        WHEN COUNT(t.id_transaccion) >= 3
            THEN 'Cliente de actividad media'
        ELSE 'Revisar actividad'
    END AS "Clasificacion"
FROM cuentas AS c
INNER JOIN clientes AS cl
    ON cl.id_cliente = c.id_cliente
LEFT JOIN transacciones AS t
    ON t.id_cuenta = c.id_cuenta
GROUP BY
    c.id_cuenta,
    c.numero_cuenta,
    cl.nombre_completo,
    c.saldo
ORDER BY
    "Total Movimientos" DESC,
    "Saldo Actual" DESC;