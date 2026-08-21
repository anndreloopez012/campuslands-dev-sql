SELECT
    id_reserva,
    id_huesped,
    id_habitacion,
    fecha_entrada,
    fecha_salida,
    cantidad_huespedes,
    estado
FROM reservas;

SELECT
    id_reserva,
    estado
FROM reservas;

SELECT
    id_reserva,
    fecha_entrada,
    fecha_salida,
    estado
FROM reservas
WHERE fecha_entrada >= '2026-08-01';

SELECT
    id_reserva,
    fecha_entrada,
    fecha_salida,
    estado
FROM reservas
ORDER BY fecha_entrada ASC;

SELECT
    h.numero AS habitacion,
    COUNT(r.id_reserva) AS cantidad_reservas
FROM habitaciones AS h
JOIN reservas AS r
    ON h.id_habitacion = r.id_habitacion
GROUP BY h.id_habitacion, h.numero
ORDER BY cantidad_reservas DESC
LIMIT 5;

SELECT COUNT(*) AS total_reservas
FROM reservas;

SELECT
    AVG(monto) AS promedio_pago,
    MIN(monto) AS pago_minimo,
    MAX(monto) AS pago_maximo
FROM pagos;

SELECT
    estado,
    COUNT(*) AS cantidad_reservas
FROM reservas
GROUP BY estado;

SELECT
    r.id_reserva,
    h.nombre_completo AS huesped,
    ha.numero AS habitacion,
    r.fecha_entrada,
    r.fecha_salida,
    r.estado
FROM reservas AS r
JOIN huespedes AS h
    ON r.id_huesped = h.id_huesped
JOIN habitaciones AS ha
    ON r.id_habitacion = ha.id_habitacion;

SELECT
    r.id_reserva,
    h.nombre_completo AS huesped,
    ha.numero AS habitacion,
    r.fecha_entrada,
    r.fecha_salida
FROM reservas AS r
JOIN huespedes AS h
    ON r.id_huesped = h.id_huesped
JOIN habitaciones AS ha
    ON r.id_habitacion = ha.id_habitacion
WHERE r.estado = 'CONFIRMADA'
ORDER BY r.fecha_entrada ASC
LIMIT 5;

SELECT
    r.id_reserva AS "Reserva",
    h.nombre_completo AS "Huesped",
    ha.numero AS "Habitacion",
    ha.tipo AS "Tipo de Habitacion",
    r.fecha_entrada AS "Entrada",
    r.fecha_salida AS "Salida",
    r.cantidad_huespedes AS "Huespedes",
    r.estado AS "Estado"
FROM reservas AS r
JOIN huespedes AS h
    ON r.id_huesped = h.id_huesped
JOIN habitaciones AS ha
    ON r.id_habitacion = ha.id_habitacion
ORDER BY r.fecha_entrada;

SELECT
    ha.numero AS habitacion,
    ha.tipo,
    ha.capacidad,
    COUNT(r.id_reserva) AS reservas,
    CASE
        WHEN COUNT(r.id_reserva) >= 3 THEN 'PRIORIZAR DISPONIBILIDAD'
        WHEN COUNT(r.id_reserva) = 2 THEN 'MANTENER OFERTA'
        ELSE 'IMPULSAR RESERVAS'
    END AS decision
FROM habitaciones AS ha
LEFT JOIN reservas AS r
    ON ha.id_habitacion = r.id_habitacion
GROUP BY ha.id_habitacion, ha.numero, ha.tipo, ha.capacidad
ORDER BY reservas DESC;

SELECT
    ha.numero AS habitacion,
    ha.tipo,
    r.fecha_entrada,
    r.fecha_salida,
    r.estado,
    CASE
        WHEN r.estado = 'CHECK_IN' THEN 'OCUPACION ACTUAL'
        WHEN r.estado = 'CONFIRMADA' THEN 'RESERVA FUTURA'
        ELSE 'SIN OCUPACION ACTUAL'
    END AS situacion
FROM habitaciones AS ha
LEFT JOIN reservas AS r
    ON ha.id_habitacion = r.id_habitacion
WHERE r.estado IN ('CHECK_IN', 'CONFIRMADA')
ORDER BY r.fecha_entrada ASC;