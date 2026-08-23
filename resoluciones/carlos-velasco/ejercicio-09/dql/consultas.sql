PRAGMA foreign_keys = ON;

-- 1. LISTAR TODOS LOS REGISTROS DE LA ENTIDAD CENTRAL

SELECT
    id_membresia,
    id_cliente,
    id_plan,
    fecha_inicio,
    fecha_fin,
    estado
FROM membresias;

-- 2. MOSTRAR DOS COLUMNAS RELEVANTES

SELECT
    fecha_inicio,
    estado
FROM membresias;

-- 3. FILTRAR MEMBRESIAS POR FECHA

SELECT
    id_membresia,
    id_cliente,
    fecha_fin,
    estado
FROM membresias
WHERE fecha_fin >= '2026-08-01';

-- 4. ORDENAR MEMBRESIAS POR FECHA DE FINALIZACION

SELECT
    id_membresia,
    id_cliente,
    fecha_inicio,
    fecha_fin,
    estado
FROM membresias
ORDER BY fecha_fin ASC;

-- 5. CINCO MEMBRESIAS MAS PROXIMAS A VENCER

SELECT
    id_membresia,
    id_cliente,
    fecha_fin,
    estado
FROM membresias
WHERE estado = 'Activa'
ORDER BY fecha_fin ASC
LIMIT 5;

-- 6. CONTAR REGISTROS TOTALES

SELECT
    COUNT(*) AS total_membresias
FROM membresias;

-- 7. PROMEDIO, MINIMO Y MAXIMO DE LOS PAGOS

SELECT
    ROUND(AVG(monto), 2) AS promedio_pago,
    MIN(monto) AS pago_minimo,
    MAX(monto) AS pago_maximo
FROM pagos
WHERE estado = 'Completado';

-- 8. AGRUPAR MEMBRESIAS POR ESTADO

SELECT
    estado,
    COUNT(*) AS total_membresias
FROM membresias
GROUP BY estado
ORDER BY total_membresias DESC;

-- 9. RELACIONAR CLIENTES, MEMBRESIAS Y PLANES

SELECT
    c.nombre_completo AS cliente,
    p.nombre AS plan,
    m.fecha_inicio,
    m.fecha_fin,
    m.estado
FROM clientes AS c
INNER JOIN membresias AS m
    ON m.id_cliente = c.id_cliente
INNER JOIN planes AS p
    ON p.id_plan = m.id_plan
ORDER BY m.fecha_inicio ASC;

-- 10. WHERE, ORDER BY Y LIMIT

SELECT
    id_membresia,
    id_cliente,
    fecha_fin,
    estado
FROM membresias
WHERE estado = 'Activa'
ORDER BY fecha_fin ASC
LIMIT 5;

-- 11. REPORTE CON ALIAS LEGIBLES

SELECT
    m.id_membresia AS "ID Membresia",
    c.nombre_completo AS "Cliente",
    p.nombre AS "Plan",
    p.duracion_meses AS "Duracion Meses",
    p.precio AS "Precio Plan",
    m.fecha_inicio AS "Fecha Inicio",
    m.fecha_fin AS "Fecha Fin",
    m.estado AS "Estado"
FROM membresias AS m
INNER JOIN clientes AS c
    ON c.id_cliente = m.id_cliente
INNER JOIN planes AS p
    ON p.id_plan = m.id_plan
ORDER BY m.fecha_fin ASC;

-- 12. DECISION DE NEGOCIO: PLANES CON MAYOR DEMANDA

SELECT
    p.nombre AS "Plan",
    COUNT(m.id_membresia) AS "Membresias",
    ROUND(AVG(p.precio), 2) AS "Precio Promedio",
    CASE
        WHEN COUNT(m.id_membresia) >= 3 THEN 'Alta demanda'
        WHEN COUNT(m.id_membresia) = 2 THEN 'Demanda media'
        ELSE 'Baja demanda'
    END AS "Nivel de Demanda"
FROM planes AS p
LEFT JOIN membresias AS m
    ON m.id_plan = p.id_plan
GROUP BY
    p.id_plan,
    p.nombre
ORDER BY COUNT(m.id_membresia) DESC;