SELECT
    id_reserva,
    id_usuario,
    id_recurso,
    fecha_reserva,
    hora_inicio,
    hora_fin,
    cantidad_horas,
    total,
    estado
FROM reservas;

SELECT
    fecha_reserva,
    total
FROM reservas;

SELECT
    id_reserva,
    fecha_reserva,
    total,
    estado
FROM reservas
WHERE total >= 500;

SELECT
    id_reserva,
    fecha_reserva,
    hora_inicio,
    hora_fin
FROM reservas
ORDER BY fecha_reserva ASC;

SELECT
    id_reserva,
    fecha_reserva,
    total
FROM reservas
WHERE estado IN ('confirmada', 'finalizada')
ORDER BY total DESC
LIMIT 5;

SELECT COUNT(*) AS total_reservas
FROM reservas;

SELECT
    AVG(total) AS promedio_reserva,
    MIN(total) AS reserva_minima,
    MAX(total) AS reserva_maxima
FROM reservas;

SELECT
    estado,
    COUNT(*) AS cantidad_reservas,
    SUM(total) AS total_reservado
FROM reservas
GROUP BY estado
ORDER BY cantidad_reservas DESC;

SELECT
    r.id_reserva,
    u.nombre_completo AS usuario,
    re.nombre AS recurso,
    r.fecha_reserva,
    r.total,
    r.estado
FROM reservas AS r
INNER JOIN usuarios AS u
    ON u.id_usuario = r.id_usuario
INNER JOIN recursos AS re
    ON re.id_recurso = r.id_recurso
ORDER BY r.fecha_reserva ASC;

SELECT
    id_reserva,
    fecha_reserva,
    total
FROM reservas
WHERE estado = 'confirmada'
ORDER BY total DESC
LIMIT 5;

SELECT
    r.id_reserva AS "Reserva",
    u.nombre_completo AS "Usuario",
    re.nombre AS "Recurso",
    r.fecha_reserva AS "Fecha",
    r.total AS "Total",
    r.estado AS "Estado"
FROM reservas AS r
INNER JOIN usuarios AS u
    ON u.id_usuario = r.id_usuario
INNER JOIN recursos AS re
    ON re.id_recurso = r.id_recurso
ORDER BY r.fecha_reserva DESC;

SELECT
    re.nombre AS recurso,
    re.capacidad,
    COUNT(r.id_reserva) AS cantidad_reservas,
    COALESCE(SUM(r.total), 0) AS ingresos_generados
FROM recursos AS re
LEFT JOIN reservas AS r
    ON r.id_recurso = re.id_recurso
    AND r.estado IN ('confirmada', 'finalizada')
GROUP BY
    re.id_recurso,
    re.nombre,
    re.capacidad
ORDER BY ingresos_generados DESC;

SELECT
    u.nombre_completo AS usuario,
    COUNT(r.id_reserva) AS reservas_realizadas,
    COALESCE(SUM(r.total), 0) AS gasto_total
FROM usuarios AS u
INNER JOIN reservas AS r
    ON r.id_usuario = u.id_usuario
WHERE r.estado <> 'cancelada'
GROUP BY
    u.id_usuario,
    u.nombre_completo
ORDER BY gasto_total DESC;

SELECT
    re.nombre AS recurso,
    COUNT(r.id_reserva) AS reservas_confirmadas,
    COALESCE(SUM(r.total), 0) AS ingresos,
    CASE
        WHEN COUNT(r.id_reserva) >= 3 THEN 'Alta demanda'
        WHEN COUNT(r.id_reserva) >= 2 THEN 'Demanda media'
        ELSE 'Baja demanda'
    END AS nivel_demanda
FROM recursos AS re
LEFT JOIN reservas AS r
    ON r.id_recurso = re.id_recurso
    AND r.estado = 'confirmada'
GROUP BY
    re.id_recurso,
    re.nombre
ORDER BY reservas_confirmadas DESC, ingresos DESC;

SELECT
    r.id_reserva AS "Reserva",
    u.nombre_completo AS "Usuario",
    re.nombre AS "Recurso",
    r.total AS "Total Reserva",
    COALESCE(p.monto, 0) AS "Monto Pagado",
    r.total - COALESCE(p.monto, 0) AS "Saldo",
    CASE
        WHEN COALESCE(p.monto, 0) >= r.total THEN 'Pagada'
        WHEN COALESCE(p.monto, 0) > 0 THEN 'Pago parcial'
        ELSE 'Pendiente de pago'
    END AS "Estado Financiero"
FROM reservas AS r
INNER JOIN usuarios AS u
    ON u.id_usuario = r.id_usuario
INNER JOIN recursos AS re
    ON re.id_recurso = r.id_recurso
LEFT JOIN pagos AS p
    ON p.id_reserva = r.id_reserva
WHERE r.estado <> 'cancelada'
ORDER BY "Saldo" DESC;