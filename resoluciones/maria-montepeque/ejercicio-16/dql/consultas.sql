-- Ejercicio 16: Aerolinea Vuelos
-- Entidad central: reservas

-- 1. Listar todos los registros principales de la entidad central
SELECT * FROM reservas;

-- 2. Mostrar solo dos columnas relevantes
SELECT pasajero, estado FROM reservas;

-- 3. Filtrar registros por una condicion numerica
SELECT * FROM reservas WHERE precio_pagado > 300;

-- 4. Ordenar resultados alfabeticamente por pasajero
SELECT * FROM reservas ORDER BY pasajero;

-- 5. Mostrar las 5 reservas de mayor precio pagado
SELECT * FROM reservas ORDER BY precio_pagado DESC LIMIT 5;

-- 6. Contar registros totales
SELECT COUNT(*) AS total_reservas FROM reservas;

-- 7. Promedio, minimo y maximo del precio pagado
SELECT
    AVG(precio_pagado) AS promedio,
    MIN(precio_pagado) AS minimo,
    MAX(precio_pagado) AS maximo
FROM reservas;

-- 8. Agrupar reservas por estado
SELECT estado, COUNT(*) AS cantidad_reservas
FROM reservas
GROUP BY estado;

-- 9. Relacionar reservas, vuelos y aeropuertos con JOIN
SELECT r.id_reserva, r.pasajero, a.codigo AS origen
FROM reservas r
JOIN vuelos v ON v.id_vuelo = r.id_vuelo
JOIN aeropuertos a ON a.id_aeropuerto = v.id_aeropuerto_origen;

-- 10. WHERE + ORDER BY + LIMIT
SELECT * FROM reservas
WHERE estado = 'confirmada'
ORDER BY precio_pagado DESC
LIMIT 3;

-- 11. Reporte con alias legibles
SELECT
    r.pasajero AS pasajero,
    ao.codigo AS origen,
    ad.codigo AS destino,
    v.fecha_salida AS fecha_vuelo,
    r.asiento AS asiento,
    r.estado AS estado_reserva
FROM reservas r
JOIN vuelos v ON v.id_vuelo = r.id_vuelo
JOIN aeropuertos ao ON ao.id_aeropuerto = v.id_aeropuerto_origen
JOIN aeropuertos ad ON ad.id_aeropuerto = v.id_aeropuerto_destino;

-- 12. Consulta para decision de negocio: vuelo con mayores ingresos por reservas confirmadas
SELECT v.id_vuelo, ao.codigo AS origen, ad.codigo AS destino, SUM(r.precio_pagado) AS total_ingresos
FROM reservas r
JOIN vuelos v ON v.id_vuelo = r.id_vuelo
JOIN aeropuertos ao ON ao.id_aeropuerto = v.id_aeropuerto_origen
JOIN aeropuertos ad ON ad.id_aeropuerto = v.id_aeropuerto_destino
WHERE r.estado = 'confirmada'
GROUP BY v.id_vuelo
ORDER BY total_ingresos DESC
LIMIT 1;
