PRAGMA foreign_keys = ON;

-- 1. LISTAR TODOS LOS REGISTROS DE LA ENTIDAD CENTRAL

SELECT
    id_reserva,
    id_huesped,
    id_habitacion,
    fecha_entrada,
    fecha_salida,
    cantidad_huespedes,
    estado
FROM reservas;

-- 2. MOSTRAR DOS COLUMNAS RELEVANTES

SELECT
    fecha_entrada,
    fecha_salida
FROM reservas;

-- 3. FILTRAR RESERVAS POR FECHA

SELECT
    id_reserva,
    id_huesped,
    fecha_entrada,
    fecha_salida,
    estado
FROM reservas
WHERE fecha_entrada >= '2026-08-18';

-- 4. ORDENAR RESERVAS POR FECHA DE ENTRADA

SELECT
    id_reserva,
    fecha_entrada,
    fecha_salida,
    estado
FROM reservas
ORDER BY fecha_entrada ASC;

-- 5. CINCO RESERVAS MAS LARGAS SEGUN CANTIDAD DE NOCHES

SELECT
    id_reserva,
    id_huesped,
    id_habitacion,
    fecha_entrada,
    fecha_salida,
    CAST(julianday(fecha_salida) - julianday(fecha_entrada) AS INTEGER) AS noches
FROM reservas
ORDER BY noches DESC
LIMIT 5;

-- 6. CONTAR REGISTROS TOTALES

SELECT
    COUNT(*) AS total_reservas
FROM reservas;

-- 7. CALCULAR PROMEDIO, MINIMO Y MAXIMO DE PAGOS

SELECT
    ROUND(AVG(monto), 2) AS promedio_pago,
    MIN(monto) AS pago_minimo,
    MAX(monto) AS pago_maximo
FROM pagos
WHERE estado = 'Completado';

-- 8. AGRUPAR RESERVAS POR ESTADO

SELECT
    estado,
    COUNT(*) AS total_reservas
FROM reservas
GROUP BY estado
ORDER BY total_reservas DESC;

-- 9. RELACIONAR HUESPEDES Y RESERVAS

SELECT
    h.nombre_completo AS huesped,
    r.fecha_entrada,
    r.fecha_salida,
    r.estado
FROM huespedes AS h
INNER JOIN reservas AS r
    ON r.id_huesped = h.id_huesped
ORDER BY r.fecha_entrada ASC;

-- 10. WHERE, ORDER BY Y LIMIT

SELECT
    id_reserva,
    id_habitacion,
    fecha_entrada,
    fecha_salida,
    estado
FROM reservas
WHERE estado = 'Confirmada'
ORDER BY fecha_entrada ASC
LIMIT 5;

-- 11. REPORTE CON ALIAS LEGIBLES

SELECT
    r.id_reserva AS "ID Reserva",
    h.nombre_completo AS "Huesped",
    ha.numero AS "Habitacion",
    ha.tipo AS "Tipo Habitacion",
    r.fecha_entrada AS "Entrada",
    r.fecha_salida AS "Salida",
    r.cantidad_huespedes AS "Huespedes",
    r.estado AS "Estado",
    ROUND(
        (julianday(r.fecha_salida) - julianday(r.fecha_entrada))
        * ha.precio_noche,
        2
    ) AS "Total Estimado"
FROM reservas AS r
INNER JOIN huespedes AS h
    ON h.id_huesped = r.id_huesped
INNER JOIN habitaciones AS ha
    ON ha.id_habitacion = r.id_habitacion
ORDER BY r.fecha_entrada ASC;

-- 12. DECISION DE NEGOCIO: HABITACIONES CON MAYOR DEMANDA

SELECT
    ha.numero AS "Habitacion",
    ha.tipo AS "Tipo",
    COUNT(r.id_reserva) AS "Total Reservas",
    ROUND(
        AVG(julianday(r.fecha_salida) - julianday(r.fecha_entrada)),
        2
    ) AS "Promedio Noches",
    CASE
        WHEN COUNT(r.id_reserva) >= 3 THEN 'Alta demanda'
        WHEN COUNT(r.id_reserva) = 2 THEN 'Demanda media'
        ELSE 'Baja demanda'
    END AS "Nivel de Demanda"
FROM habitaciones AS ha
LEFT JOIN reservas AS r
    ON r.id_habitacion = ha.id_habitacion
    AND r.estado <> 'Cancelada'
GROUP BY
    ha.id_habitacion,
    ha.numero,
    ha.tipo
ORDER BY COUNT(r.id_reserva) DESC;