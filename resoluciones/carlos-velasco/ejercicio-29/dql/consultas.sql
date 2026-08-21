PRAGMA foreign_keys = ON;

-- 1. LISTAR TODOS LOS REGISTROS PRINCIPALES

SELECT
    id_reserva,
    id_usuario,
    id_recurso,
    fecha_inicio,
    fecha_fin,
    estado,
    total
FROM reservas;

-- 2. MOSTRAR DOS COLUMNAS RELEVANTES

SELECT
    id_reserva,
    total
FROM reservas;

-- 3. FILTRAR POR CONDICION NUMERICA

SELECT
    id_reserva,
    id_recurso,
    total,
    estado
FROM reservas
WHERE total >= 400.00;

-- 4. ORDENAR POR FECHA

SELECT
    id_reserva,
    fecha_inicio,
    fecha_fin,
    estado
FROM reservas
ORDER BY fecha_inicio ASC;

-- 5. MOSTRAR LAS 5 RESERVAS MAS IMPORTANTES

SELECT
    id_reserva,
    id_usuario,
    id_recurso,
    total,
    fecha_inicio
FROM reservas
ORDER BY total DESC
LIMIT 5;

-- 6. CONTAR REGISTROS TOTALES

SELECT
    COUNT(*) AS total_reservas
FROM reservas;

-- 7. CALCULAR PROMEDIO, MINIMO Y MAXIMO

SELECT
    AVG(total) AS reserva_promedio,
    MIN(total) AS reserva_minima,
    MAX(total) AS reserva_maxima
FROM reservas;

-- 8. AGRUPAR RESERVAS POR RECURSO

SELECT
    id_recurso,
    COUNT(*) AS total_reservas,
    SUM(total) AS ingresos_generados
FROM reservas
GROUP BY id_recurso
ORDER BY ingresos_generados DESC;

-- 9. RELACIONAR TABLAS CON JOIN

SELECT
    r.id_reserva,
    u.nombre_completo AS usuario,
    rec.nombre AS recurso,
    r.fecha_inicio,
    r.fecha_fin,
    r.total,
    r.estado
FROM reservas AS r
INNER JOIN usuarios AS u
    ON u.id_usuario = r.id_usuario
INNER JOIN recursos AS rec
    ON rec.id_recurso = r.id_recurso
ORDER BY r.fecha_inicio ASC;

-- 10. WHERE + ORDER BY + LIMIT

SELECT
    id_reserva,
    id_usuario,
    id_recurso,
    total,
    fecha_inicio
FROM reservas
WHERE estado = 'Confirmada'
ORDER BY total DESC
LIMIT 5;

-- 11. REPORTE CON ALIAS LEGIBLES

SELECT
    r.id_reserva AS 'ID Reserva',
    u.nombre_completo AS 'Usuario',
    rec.nombre AS 'Recurso',
    rec.tipo AS 'Tipo de Recurso',
    r.fecha_inicio AS 'Inicio',
    r.fecha_fin AS 'Fin',
    r.total AS 'Total',
    r.estado AS 'Estado'
FROM reservas AS r
INNER JOIN usuarios AS u
    ON u.id_usuario = r.id_usuario
INNER JOIN recursos AS rec
    ON rec.id_recurso = r.id_recurso
ORDER BY r.fecha_inicio ASC;

-- 12. DECISION DE NEGOCIO: RECURSOS CON MAYOR DEMANDA

SELECT
    rec.nombre AS recurso,
    COUNT(r.id_reserva) AS total_reservas,
    COALESCE(SUM(r.total), 0) AS ingresos_generados,
    CASE
        WHEN COUNT(r.id_reserva) >= 3 THEN 'Alta demanda'
        WHEN COUNT(r.id_reserva) >= 2 THEN 'Demanda media'
        ELSE 'Baja demanda'
    END AS nivel_demanda,
    CASE
        WHEN COUNT(r.id_reserva) >= 3 THEN 'Evaluar ampliacion de disponibilidad'
        WHEN COUNT(r.id_reserva) >= 2 THEN 'Mantener disponibilidad'
        ELSE 'Evaluar promocion'
    END AS decision
FROM recursos AS rec
LEFT JOIN reservas AS r
    ON r.id_recurso = rec.id_recurso
    AND r.estado <> 'Cancelada'
GROUP BY
    rec.id_recurso,
    rec.nombre
ORDER BY ingresos_generados DESC;

-- REPORTE DE PAGOS

SELECT
    r.id_reserva AS 'ID Reserva',
    u.nombre_completo AS 'Usuario',
    r.total AS 'Total Reserva',
    COALESCE(SUM(
        CASE
            WHEN p.estado = 'Confirmado' THEN p.monto
            ELSE 0
        END
    ), 0) AS 'Total Pagado',
    r.total - COALESCE(SUM(
        CASE
            WHEN p.estado = 'Confirmado' THEN p.monto
            ELSE 0
        END
    ), 0) AS 'Saldo Pendiente'
FROM reservas AS r
INNER JOIN usuarios AS u
    ON u.id_usuario = r.id_usuario
LEFT JOIN pagos AS p
    ON p.id_reserva = r.id_reserva
GROUP BY
    r.id_reserva,
    u.nombre_completo,
    r.total
ORDER BY 'Saldo Pendiente' DESC;

-- RESERVAS CON SALDO PENDIENTE

SELECT
    r.id_reserva AS 'ID Reserva',
    u.nombre_completo AS 'Usuario',
    rec.nombre AS 'Recurso',
    r.total AS 'Total',
    COALESCE(SUM(
        CASE
            WHEN p.estado = 'Confirmado' THEN p.monto
            ELSE 0
        END
    ), 0) AS 'Pagado',
    r.total - COALESCE(SUM(
        CASE
            WHEN p.estado = 'Confirmado' THEN p.monto
            ELSE 0
        END
    ), 0) AS 'Saldo'
FROM reservas AS r
INNER JOIN usuarios AS u
    ON u.id_usuario = r.id_usuario
INNER JOIN recursos AS rec
    ON rec.id_recurso = r.id_recurso
LEFT JOIN pagos AS p
    ON p.id_reserva = r.id_reserva
GROUP BY
    r.id_reserva,
    u.nombre_completo,
    rec.nombre,
    r.total
HAVING 'Saldo' > 0
ORDER BY 'Saldo' DESC;

-- VERIFICACION DE TRANSACCIONES

SELECT
    r.id_reserva,
    r.estado AS estado_reserva,
    p.estado AS estado_pago
FROM reservas AS r
INNER JOIN pagos AS p
    ON p.id_reserva = r.id_reserva
ORDER BY r.id_reserva;