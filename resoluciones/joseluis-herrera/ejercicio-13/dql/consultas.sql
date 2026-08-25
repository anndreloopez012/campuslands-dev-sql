SELECT *
FROM cuentas;

SELECT numero_cuenta, saldo
FROM cuentas;

SELECT *
FROM cuentas
WHERE saldo > 5000;

SELECT *
FROM cuentas
ORDER BY saldo DESC;

SELECT
    c.numero_cuenta,
    c.saldo,
    COUNT(t.id_transaccion) AS total_transacciones
FROM cuentas c
LEFT JOIN transacciones t
    ON c.id_cuenta = t.id_cuenta
GROUP BY c.id_cuenta, c.numero_cuenta, c.saldo
ORDER BY total_transacciones DESC
LIMIT 5;

SELECT COUNT(*) AS total_transacciones
FROM transacciones;

SELECT
    AVG(monto) AS monto_promedio,
    MIN(monto) AS monto_minimo,
    MAX(monto) AS monto_maximo
FROM transacciones;

SELECT
    tipo_transaccion,
    COUNT(*) AS cantidad,
    SUM(monto) AS monto_total
FROM transacciones
GROUP BY tipo_transaccion
ORDER BY monto_total DESC;

SELECT
    cl.nombre_completo,
    c.numero_cuenta,
    c.tipo_cuenta,
    c.saldo
FROM clientes cl
JOIN cuentas c
    ON cl.id_cliente = c.id_cliente
ORDER BY cl.nombre_completo;

SELECT
    id_transaccion,
    id_cuenta,
    tipo_transaccion,
    monto,
    fecha_transaccion
FROM transacciones
WHERE monto >= 500
ORDER BY monto DESC
LIMIT 5;

SELECT
    cl.nombre_completo AS cliente,
    c.numero_cuenta AS cuenta,
    t.tipo_transaccion AS tipo,
    t.monto AS monto,
    t.fecha_transaccion AS fecha
FROM clientes cl
JOIN cuentas c
    ON cl.id_cliente = c.id_cliente
JOIN transacciones t
    ON c.id_cuenta = t.id_cuenta
ORDER BY t.fecha_transaccion DESC;

SELECT
    c.numero_cuenta AS cuenta,
    cl.nombre_completo AS cliente,
    c.saldo AS saldo_actual,
    CASE
        WHEN c.saldo >= 8000 THEN 'Cuenta con saldo alto'
        WHEN c.saldo >= 4000 THEN 'Cuenta con saldo medio'
        ELSE 'Cuenta con saldo bajo'
    END AS clasificacion
FROM cuentas c
JOIN clientes cl
    ON c.id_cliente = cl.id_cliente
ORDER BY c.saldo DESC;

SELECT
    c.numero_cuenta AS cuenta,
    cl.nombre_completo AS cliente,
    SUM(
        CASE
            WHEN t.tipo_transaccion = 'Deposito' THEN t.monto
            ELSE 0
        END
    ) AS total_depositos,
    SUM(
        CASE
            WHEN t.tipo_transaccion IN ('Retiro', 'Transferencia') THEN t.monto
            ELSE 0
        END
    ) AS total_salidas,
    CASE
        WHEN SUM(
            CASE
                WHEN t.tipo_transaccion = 'Deposito' THEN t.monto
                ELSE 0
            END
        ) >
        SUM(
            CASE
                WHEN t.tipo_transaccion IN ('Retiro', 'Transferencia') THEN t.monto
                ELSE 0
            END
        )
        THEN 'Priorizar ahorro'
        ELSE 'Revisar flujo de salida'
    END AS decision
FROM cuentas c
JOIN clientes cl
    ON c.id_cliente = cl.id_cliente
JOIN transacciones t
    ON c.id_cuenta = t.id_cuenta
GROUP BY c.id_cuenta, c.numero_cuenta, cl.nombre_completo
ORDER BY c.saldo DESC;