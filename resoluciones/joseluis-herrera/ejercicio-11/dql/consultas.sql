SELECT
    id_viaje,
    id_ruta,
    id_bus,
    id_conductor,
    fecha_viaje,
    hora_salida,
    pasajeros,
    estado
FROM viajes;

SELECT
    fecha_viaje,
    hora_salida
FROM viajes;

SELECT
    id_viaje,
    fecha_viaje,
    pasajeros,
    estado
FROM viajes
WHERE pasajeros >= 40;

SELECT
    id_viaje,
    fecha_viaje,
    hora_salida,
    pasajeros
FROM viajes
ORDER BY fecha_viaje ASC, hora_salida ASC;

SELECT
    id_viaje,
    pasajeros,
    fecha_viaje
FROM viajes
ORDER BY pasajeros DESC
LIMIT 5;

SELECT COUNT(*) AS total_viajes
FROM viajes;

SELECT
    AVG(pasajeros) AS promedio_pasajeros,
    MIN(pasajeros) AS minimo_pasajeros,
    MAX(pasajeros) AS maximo_pasajeros
FROM viajes;

SELECT
    id_ruta,
    COUNT(*) AS total_viajes,
    AVG(pasajeros) AS promedio_pasajeros
FROM viajes
GROUP BY id_ruta
ORDER BY total_viajes DESC;

SELECT
    v.id_viaje,
    r.origen,
    r.destino,
    b.placa,
    c.nombre_completo AS conductor,
    v.fecha_viaje,
    v.pasajeros
FROM viajes AS v
JOIN rutas AS r ON v.id_ruta = r.id_ruta
JOIN buses AS b ON v.id_bus = b.id_bus
JOIN conductores AS c ON v.id_conductor = c.id_conductor;

SELECT
    id_viaje,
    fecha_viaje,
    pasajeros,
    estado
FROM viajes
WHERE estado = 'Programado'
ORDER BY pasajeros DESC
LIMIT 5;

SELECT
    v.id_viaje AS "ID Viaje",
    r.origen AS "Origen",
    r.destino AS "Destino",
    b.placa AS "Placa del Bus",
    c.nombre_completo AS "Conductor",
    v.fecha_viaje AS "Fecha",
    v.hora_salida AS "Hora de Salida",
    v.pasajeros AS "Pasajeros",
    v.estado AS "Estado"
FROM viajes AS v
JOIN rutas AS r ON v.id_ruta = r.id_ruta
JOIN buses AS b ON v.id_bus = b.id_bus
JOIN conductores AS c ON v.id_conductor = c.id_conductor
ORDER BY v.fecha_viaje, v.hora_salida;

SELECT
    r.origen,
    r.destino,
    COUNT(v.id_viaje) AS total_viajes,
    SUM(v.pasajeros) AS pasajeros_transportados,
    ROUND(AVG(v.pasajeros), 2) AS promedio_pasajeros
FROM rutas AS r
JOIN viajes AS v ON r.id_ruta = v.id_ruta
GROUP BY r.id_ruta
HAVING AVG(v.pasajeros) >= 35
ORDER BY pasajeros_transportados DESC;