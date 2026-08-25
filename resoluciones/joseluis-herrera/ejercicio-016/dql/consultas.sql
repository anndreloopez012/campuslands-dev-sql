SELECT
    id_vuelo,
    codigo_vuelo,
    id_avion,
    id_origen,
    id_destino,
    fecha_salida,
    fecha_llegada,
    precio,
    estado
FROM vuelos;

SELECT
    codigo_vuelo,
    precio
FROM vuelos;

SELECT
    id_vuelo,
    codigo_vuelo,
    fecha_salida,
    precio
FROM vuelos
WHERE precio >= 250;

SELECT
    id_vuelo,
    codigo_vuelo,
    fecha_salida,
    precio
FROM vuelos
ORDER BY fecha_salida ASC;

SELECT
    id_vuelo,
    codigo_vuelo,
    precio
FROM vuelos
ORDER BY precio DESC
LIMIT 5;

SELECT COUNT(*) AS total_vuelos
FROM vuelos;

SELECT
    AVG(precio) AS precio_promedio,
    MIN(precio) AS precio_minimo,
    MAX(precio) AS precio_maximo
FROM vuelos;

SELECT
    estado,
    COUNT(*) AS cantidad_vuelos
FROM vuelos
GROUP BY estado;

SELECT
    v.codigo_vuelo,
    ao.ciudad AS origen,
    ad.ciudad AS destino,
    v.fecha_salida,
    v.precio
FROM vuelos AS v
JOIN aeropuertos AS ao
    ON v.id_origen = ao.id_aeropuerto
JOIN aeropuertos AS ad
    ON v.id_destino = ad.id_aeropuerto;

SELECT
    v.codigo_vuelo,
    v.fecha_salida,
    v.precio,
    COUNT(r.id_reserva) AS reservas
FROM vuelos AS v
LEFT JOIN reservas AS r
    ON v.id_vuelo = r.id_vuelo
WHERE v.estado = 'programado'
GROUP BY v.id_vuelo, v.codigo_vuelo, v.fecha_salida, v.precio
ORDER BY reservas DESC
LIMIT 5;

SELECT
    a.ciudad AS aeropuerto,
    COUNT(v.id_vuelo) AS vuelos_conectados
FROM aeropuertos AS a
LEFT JOIN vuelos AS v
    ON a.id_aeropuerto = v.id_origen
GROUP BY a.id_aeropuerto, a.ciudad
ORDER BY vuelos_conectados DESC;

SELECT
    v.codigo_vuelo AS vuelo,
    ao.ciudad AS origen,
    ad.ciudad AS destino,
    COUNT(r.id_reserva) AS pasajeros_reservados,
    v.precio AS precio_boleto,
    COUNT(r.id_reserva) * v.precio AS ingresos_estimados
FROM vuelos AS v
JOIN aeropuertos AS ao
    ON v.id_origen = ao.id_aeropuerto
JOIN aeropuertos AS ad
    ON v.id_destino = ad.id_aeropuerto
LEFT JOIN reservas AS r
    ON v.id_vuelo = r.id_vuelo
GROUP BY
    v.id_vuelo,
    v.codigo_vuelo,
    ao.ciudad,
    ad.ciudad,
    v.precio
ORDER BY ingresos_estimados DESC;

SELECT
    v.codigo_vuelo AS vuelo,
    ao.ciudad AS origen,
    ad.ciudad AS destino,
    a.modelo AS avion,
    a.capacidad,
    COUNT(r.id_reserva) AS reservas,
    CASE
        WHEN COUNT(r.id_reserva) >= a.capacidad * 0.8
            THEN 'Alta ocupacion: considerar avion adicional'
        WHEN COUNT(r.id_reserva) >= a.capacidad * 0.5
            THEN 'Ocupacion media: monitorear ventas'
        ELSE 'Baja ocupacion: considerar promocion'
    END AS decision_comercial
FROM vuelos AS v
JOIN aeropuertos AS ao
    ON v.id_origen = ao.id_aeropuerto
JOIN aeropuertos AS ad
    ON v.id_destino = ad.id_aeropuerto
JOIN aviones AS a
    ON v.id_avion = a.id_avion
LEFT JOIN reservas AS r
    ON v.id_vuelo = r.id_vuelo
WHERE v.estado = 'programado'
GROUP BY
    v.id_vuelo,
    v.codigo_vuelo,
    ao.ciudad,
    ad.ciudad,
    a.modelo,
    a.capacidad
ORDER BY reservas DESC;