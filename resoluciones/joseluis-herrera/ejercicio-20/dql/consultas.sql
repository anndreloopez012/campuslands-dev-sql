SELECT
    id_boleto,
    id_evento,
    id_asistente,
    codigo,
    fecha_compra,
    precio_pagado,
    estado
FROM boletos;

SELECT
    codigo,
    precio_pagado
FROM boletos;

SELECT
    id_boleto,
    codigo,
    precio_pagado,
    fecha_compra
FROM boletos
WHERE precio_pagado >= 120;

SELECT
    id_boleto,
    codigo,
    fecha_compra,
    estado
FROM boletos
ORDER BY fecha_compra DESC;

SELECT
    id_boleto,
    codigo,
    precio_pagado
FROM boletos
ORDER BY precio_pagado DESC
LIMIT 5;

SELECT
    COUNT(*) AS total_boletos
FROM boletos;

SELECT
    AVG(precio_pagado) AS precio_promedio,
    MIN(precio_pagado) AS precio_minimo,
    MAX(precio_pagado) AS precio_maximo
FROM boletos;

SELECT
    id_evento,
    COUNT(*) AS boletos_vendidos,
    SUM(precio_pagado) AS ingresos
FROM boletos
GROUP BY id_evento
ORDER BY ingresos DESC;

SELECT
    b.codigo,
    e.nombre AS evento,
    a.nombre_completo AS asistente,
    b.precio_pagado,
    b.estado
FROM boletos AS b
JOIN eventos AS e
    ON b.id_evento = e.id_evento
JOIN asistentes AS a
    ON b.id_asistente = a.id_asistente;

SELECT
    b.codigo,
    e.nombre AS evento,
    b.precio_pagado
FROM boletos AS b
JOIN eventos AS e
    ON b.id_evento = e.id_evento
WHERE b.estado = 'ACTIVO'
ORDER BY b.precio_pagado DESC
LIMIT 5;

SELECT
    e.nombre AS evento,
    l.nombre AS lugar,
    l.ciudad AS ciudad,
    e.fecha_evento AS fecha,
    e.precio_base AS precio_base
FROM eventos AS e
JOIN lugares AS l
    ON e.id_lugar = l.id_lugar
ORDER BY e.fecha_evento;

SELECT
    e.nombre AS evento,
    COUNT(b.id_boleto) AS boletos_vendidos,
    SUM(b.precio_pagado) AS ingresos_generados
FROM eventos AS e
LEFT JOIN boletos AS b
    ON e.id_evento = b.id_evento
GROUP BY e.id_evento, e.nombre
ORDER BY ingresos_generados DESC;

SELECT
    l.nombre AS lugar,
    l.capacidad AS capacidad,
    COUNT(b.id_boleto) AS boletos_vendidos,
    ROUND(
        COUNT(b.id_boleto) * 100.0 / l.capacidad,
        2
    ) AS porcentaje_ocupacion
FROM lugares AS l
JOIN eventos AS e
    ON l.id_lugar = e.id_lugar
LEFT JOIN boletos AS b
    ON e.id_evento = b.id_evento
GROUP BY l.id_lugar, l.nombre, l.capacidad
ORDER BY porcentaje_ocupacion DESC;

SELECT
    e.nombre AS evento,
    e.fecha_evento AS fecha,
    l.nombre AS lugar,
    COUNT(b.id_boleto) AS boletos_vendidos,
    CASE
        WHEN COUNT(b.id_boleto) >= 3 THEN 'Priorizar promocion'
        WHEN COUNT(b.id_boleto) >= 2 THEN 'Mantener promocion'
        ELSE 'Reforzar promocion'
    END AS decision_comercial
FROM eventos AS e
JOIN lugares AS l
    ON e.id_lugar = l.id_lugar
LEFT JOIN boletos AS b
    ON e.id_evento = b.id_evento
GROUP BY e.id_evento, e.nombre, e.fecha_evento, l.nombre
ORDER BY boletos_vendidos DESC;