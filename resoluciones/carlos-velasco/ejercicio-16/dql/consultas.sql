PRAGMA foreign_keys = ON;

-- 1. LISTAR TODOS LOS VUELOS

SELECT
    id_vuelo,
    codigo_vuelo,
    aeropuerto_origen_id,
    aeropuerto_destino_id,
    avion_id,
    fecha_salida,
    fecha_llegada,
    estado
FROM vuelos;

-- 2. DOS COLUMNAS RELEVANTES DE VUELOS

SELECT
    codigo_vuelo,
    fecha_salida
FROM vuelos;

-- 3. VUELOS DESPUES DE UNA FECHA

SELECT
    codigo_vuelo,
    fecha_salida,
    estado
FROM vuelos
WHERE fecha_salida >= '2026-09-03 00:00';

-- 4. VUELOS ORDENADOS POR FECHA

SELECT
    codigo_vuelo,
    fecha_salida,
    fecha_llegada
FROM vuelos
ORDER BY fecha_salida ASC;

-- 5. CINCO VUELOS CON MAS RESERVAS

SELECT
    v.codigo_vuelo,
    COUNT(r.id_reserva) AS total_reservas
FROM vuelos v
LEFT JOIN reservas r ON r.vuelo_id = v.id_vuelo
GROUP BY v.id_vuelo, v.codigo_vuelo
ORDER BY total_reservas DESC, v.codigo_vuelo ASC
LIMIT 5;

-- 6. TOTAL DE RESERVAS

SELECT
    COUNT(*) AS total_reservas
FROM reservas;

-- 7. PROMEDIO, MINIMO Y MAXIMO DE CAPACIDAD

SELECT
    ROUND(AVG(capacidad), 2) AS capacidad_promedio,
    MIN(capacidad) AS capacidad_minima,
    MAX(capacidad) AS capacidad_maxima
FROM aviones;

-- 8. RESERVAS AGRUPADAS POR ESTADO

SELECT
    estado,
    COUNT(*) AS cantidad_reservas
FROM reservas
GROUP BY estado
ORDER BY cantidad_reservas DESC;

-- 9. VUELOS CON AEROPUERTOS DE ORIGEN Y DESTINO

SELECT
    v.codigo_vuelo,
    origen.ciudad AS ciudad_origen,
    destino.ciudad AS ciudad_destino,
    v.fecha_salida,
    v.estado
FROM vuelos v
INNER JOIN aeropuertos origen
    ON origen.id_aeropuerto = v.aeropuerto_origen_id
INNER JOIN aeropuertos destino
    ON destino.id_aeropuerto = v.aeropuerto_destino_id
ORDER BY v.fecha_salida;

-- 10. VUELOS PROGRAMADOS ORDENADOS POR FECHA Y LIMITADOS

SELECT
    codigo_vuelo,
    fecha_salida,
    estado
FROM vuelos
WHERE estado IN ('PROGRAMADO', 'ABORDANDO')
ORDER BY fecha_salida ASC
LIMIT 5;

-- 11. REPORTE DE RESERVAS

SELECT
    r.id_reserva AS "ID Reserva",
    r.nombre_pasajero AS "Pasajero",
    v.codigo_vuelo AS "Vuelo",
    r.asiento AS "Asiento",
    r.estado AS "Estado Reserva",
    v.fecha_salida AS "Fecha de Salida"
FROM reservas r
INNER JOIN vuelos v
    ON v.id_vuelo = r.vuelo_id
ORDER BY v.fecha_salida, r.nombre_pasajero;

-- 12. DECISION DE NEGOCIO: VUELOS CON ALTA OCUPACION

SELECT
    v.codigo_vuelo,
    a.modelo AS avion,
    a.capacidad,
    COUNT(r.id_reserva) AS reservas,
    ROUND(
        COUNT(r.id_reserva) * 100.0 / a.capacidad,
        2
    ) AS porcentaje_ocupacion,
    CASE
        WHEN COUNT(r.id_reserva) * 100.0 / a.capacidad >= 70
            THEN 'CONSIDERAR AVION DE MAYOR CAPACIDAD'
        WHEN COUNT(r.id_reserva) * 100.0 / a.capacidad >= 40
            THEN 'OCUPACION MODERADA'
        ELSE 'CAPACIDAD DISPONIBLE'
    END AS recomendacion
FROM vuelos v
INNER JOIN aviones a
    ON a.id_avion = v.avion_id
LEFT JOIN reservas r
    ON r.vuelo_id = v.id_vuelo
    AND r.estado <> 'CANCELADA'
GROUP BY
    v.id_vuelo,
    v.codigo_vuelo,
    a.modelo,
    a.capacidad
HAVING COUNT(r.id_reserva) > 0
ORDER BY porcentaje_ocupacion DESC;