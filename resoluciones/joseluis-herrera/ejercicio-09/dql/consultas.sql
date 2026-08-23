SELECT
    id_membresia,
    id_cliente,
    id_plan,
    fecha_inicio,
    fecha_fin,
    estado
FROM membresias;

SELECT
    id_membresia,
    estado
FROM membresias;

SELECT
    id_membresia,
    id_cliente,
    fecha_fin,
    estado
FROM membresias
WHERE fecha_fin >= '2026-08-01';

SELECT
    id_membresia,
    fecha_inicio,
    fecha_fin,
    estado
FROM membresias
ORDER BY fecha_inicio ASC;

SELECT
    p.nombre AS plan,
    COUNT(m.id_membresia) AS cantidad_membresias
FROM planes AS p
JOIN membresias AS m
    ON p.id_plan = m.id_plan
GROUP BY p.id_plan, p.nombre
ORDER BY cantidad_membresias DESC
LIMIT 5;

SELECT COUNT(*) AS total_membresias
FROM membresias;

SELECT
    AVG(monto) AS promedio_pago,
    MIN(monto) AS pago_minimo,
    MAX(monto) AS pago_maximo
FROM pagos;

SELECT
    estado,
    COUNT(*) AS cantidad_membresias
FROM membresias
GROUP BY estado;

SELECT
    m.id_membresia,
    c.nombre_completo AS cliente,
    p.nombre AS plan,
    m.fecha_inicio,
    m.fecha_fin,
    m.estado
FROM membresias AS m
JOIN clientes AS c
    ON m.id_cliente = c.id_cliente
JOIN planes AS p
    ON m.id_plan = p.id_plan;

SELECT
    m.id_membresia,
    c.nombre_completo AS cliente,
    p.nombre AS plan,
    m.fecha_fin
FROM membresias AS m
JOIN clientes AS c
    ON m.id_cliente = c.id_cliente
JOIN planes AS p
    ON m.id_plan = p.id_plan
WHERE m.estado = 'ACTIVA'
ORDER BY m.fecha_fin ASC
LIMIT 5;

SELECT
    m.id_membresia AS "Membresia",
    c.nombre_completo AS "Cliente",
    p.nombre AS "Plan",
    p.precio AS "Precio",
    m.fecha_inicio AS "Inicio",
    m.fecha_fin AS "Finalizacion",
    m.estado AS "Estado"
FROM membresias AS m
JOIN clientes AS c
    ON m.id_cliente = c.id_cliente
JOIN planes AS p
    ON m.id_plan = p.id_plan
ORDER BY m.fecha_fin;

SELECT
    p.nombre AS plan,
    p.precio AS precio,
    COUNT(m.id_membresia) AS clientes,
    CASE
        WHEN COUNT(m.id_membresia) >= 3 THEN 'MANTENER COMO PLAN PRINCIPAL'
        WHEN COUNT(m.id_membresia) = 2 THEN 'PROMOCIONAR'
        ELSE 'EVALUAR DEMANDA'
    END AS decision
FROM planes AS p
LEFT JOIN membresias AS m
    ON p.id_plan = m.id_plan
GROUP BY p.id_plan, p.nombre, p.precio
ORDER BY clientes DESC;

SELECT
    c.nombre_completo AS cliente,
    p.nombre AS plan,
    m.fecha_fin AS fecha_vencimiento,
    CASE
        WHEN m.fecha_fin < '2026-08-20' THEN 'RENOVACION VENCIDA'
        WHEN m.fecha_fin <= '2026-09-20' THEN 'RENOVACION PROXIMA'
        ELSE 'MEMBRESIA VIGENTE'
    END AS estado_renovacion
FROM membresias AS m
JOIN clientes AS c
    ON m.id_cliente = c.id_cliente
JOIN planes AS p
    ON m.id_plan = p.id_plan
ORDER BY m.fecha_fin ASC;