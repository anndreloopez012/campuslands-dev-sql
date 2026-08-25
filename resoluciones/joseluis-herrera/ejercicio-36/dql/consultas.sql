SELECT
    h.nombre_completo AS huesped,
    h.documento,
    ha.numero AS habitacion,
    GROUP_CONCAT(s.nombre, ', ') AS servicios,
    GROUP_CONCAT(ds.costo_unitario * ds.cantidad, ', ') AS costos_servicios,
    r.fecha_entrada || ' a ' || r.fecha_salida AS fechas,
    r.estado
FROM reservas r
JOIN huespedes h
    ON r.id_huesped = h.id_huesped
JOIN habitaciones ha
    ON r.id_habitacion = ha.id_habitacion
LEFT JOIN detalle_servicio ds
    ON r.id_reserva = ds.id_reserva
LEFT JOIN servicios s
    ON ds.id_servicio = s.id_servicio
GROUP BY
    r.id_reserva,
    h.nombre_completo,
    h.documento,
    ha.numero,
    r.fecha_entrada,
    r.fecha_salida,
    r.estado
ORDER BY r.id_reserva;

SELECT DISTINCT
    id_huesped,
    nombre_completo AS huesped
FROM huespedes
ORDER BY nombre_completo;

SELECT DISTINCT
    id_habitacion,
    numero,
    tipo
FROM habitaciones
ORDER BY numero;

SELECT DISTINCT
    id_servicio,
    nombre AS servicio
FROM servicios
ORDER BY nombre;

SELECT
    estado,
    COUNT(*) AS cantidad_reservas
FROM reservas
GROUP BY estado
ORDER BY cantidad_reservas DESC;

SELECT
    tipo,
    COUNT(*) AS cantidad_habitaciones
FROM habitaciones
GROUP BY tipo
ORDER BY cantidad_habitaciones DESC;

SELECT
    r.id_reserva,
    h.nombre_completo AS huesped,
    ha.numero AS habitacion,
    ROUND(
        (julianday(r.fecha_salida) - julianday(r.fecha_entrada))
        * ha.precio_noche,
        2
    ) AS total_habitacion
FROM reservas r
JOIN huespedes h
    ON r.id_huesped = h.id_huesped
JOIN habitaciones ha
    ON r.id_habitacion = ha.id_habitacion
ORDER BY r.id_reserva;

SELECT
    r.id_reserva,
    h.nombre_completo AS huesped,
    ROUND(SUM(ds.cantidad * ds.costo_unitario), 2) AS total_servicios
FROM reservas r
JOIN huespedes h
    ON r.id_huesped = h.id_huesped
JOIN detalle_servicio ds
    ON r.id_reserva = ds.id_reserva
GROUP BY r.id_reserva, h.nombre_completo
ORDER BY total_servicios DESC;

SELECT
    r.id_reserva,
    h.nombre_completo AS huesped,
    ROUND(
        ((julianday(r.fecha_salida) - julianday(r.fecha_entrada))
        * ha.precio_noche)
        + COALESCE(SUM(ds.cantidad * ds.costo_unitario), 0),
        2
    ) AS total_reserva
FROM reservas r
JOIN huespedes h
    ON r.id_huesped = h.id_huesped
JOIN habitaciones ha
    ON r.id_habitacion = ha.id_habitacion
LEFT JOIN detalle_servicio ds
    ON r.id_reserva = ds.id_reserva
GROUP BY
    r.id_reserva,
    h.nombre_completo,
    ha.precio_noche,
    r.fecha_entrada,
    r.fecha_salida
ORDER BY total_reserva DESC;

SELECT
    ROUND(AVG(precio_noche), 2) AS promedio_precio_noche,
    MIN(precio_noche) AS precio_minimo,
    MAX(precio_noche) AS precio_maximo
FROM habitaciones;

SELECT
    ROUND(AVG(costo), 2) AS promedio_costo_servicio,
    MIN(costo) AS costo_minimo,
    MAX(costo) AS costo_maximo
FROM servicios;

SELECT
    id_huesped,
    nombre_completo,
    documento
FROM huespedes
WHERE nombre_completo LIKE '%a%'
ORDER BY nombre_completo;

SELECT
    id_servicio,
    nombre,
    costo
FROM servicios
WHERE nombre LIKE '%Spa%'
   OR nombre LIKE '%Room%'
ORDER BY nombre;

SELECT
    id_reserva,
    id_huesped,
    fecha_entrada,
    fecha_salida,
    estado
FROM reservas
WHERE fecha_entrada BETWEEN '2026-08-01' AND '2026-08-10'
ORDER BY fecha_entrada;

SELECT
    id_habitacion,
    numero,
    tipo,
    precio_noche
FROM habitaciones
WHERE precio_noche BETWEEN 500 AND 1200
ORDER BY precio_noche;

SELECT
    s.nombre AS servicio,
    SUM(ds.cantidad) AS cantidad_solicitada,
    ROUND(SUM(ds.cantidad * ds.costo_unitario), 2) AS monto_total
FROM detalle_servicio ds
JOIN servicios s
    ON ds.id_servicio = s.id_servicio
GROUP BY s.id_servicio, s.nombre
ORDER BY cantidad_solicitada DESC
LIMIT 5;

SELECT
    r.id_reserva,
    h.nombre_completo AS huesped,
    r.fecha_entrada,
    r.fecha_salida
FROM reservas r
JOIN huespedes h
    ON r.id_huesped = h.id_huesped
LEFT JOIN detalle_servicio ds
    ON r.id_reserva = ds.id_reserva
WHERE ds.id_detalle IS NULL
ORDER BY r.id_reserva;

SELECT
    h.id_habitacion,
    h.numero,
    h.tipo
FROM habitaciones h
LEFT JOIN reservas r
    ON h.id_habitacion = r.id_habitacion
WHERE r.id_reserva IS NULL
ORDER BY h.numero;

SELECT
    r.id_reserva,
    h.nombre_completo AS huesped,
    ha.numero AS habitacion,
    ha.tipo AS tipo_habitacion,
    r.fecha_entrada AS entrada,
    r.fecha_salida AS salida,
    r.estado,
    ROUND(
        (julianday(r.fecha_salida) - julianday(r.fecha_entrada))
        * ha.precio_noche,
        2
    ) AS alojamiento,
    ROUND(
        COALESCE(SUM(ds.cantidad * ds.costo_unitario), 0),
        2
    ) AS servicios,
    ROUND(
        ((julianday(r.fecha_salida) - julianday(r.fecha_entrada))
        * ha.precio_noche)
        + COALESCE(SUM(ds.cantidad * ds.costo_unitario), 0),
        2
    ) AS total
FROM reservas r
JOIN huespedes h
    ON r.id_huesped = h.id_huesped
JOIN habitaciones ha
    ON r.id_habitacion = ha.id_habitacion
LEFT JOIN detalle_servicio ds
    ON r.id_reserva = ds.id_reserva
GROUP BY
    r.id_reserva,
    h.nombre_completo,
    ha.numero,
    ha.tipo,
    r.fecha_entrada,
    r.fecha_salida,
    r.estado,
    ha.precio_noche
ORDER BY total DESC;