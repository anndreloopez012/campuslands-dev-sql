PRAGMA foreign_keys = ON;

-- 1. LISTAR TODOS LOS REGISTROS DE LA ENTIDAD CENTRAL

SELECT
    id_viaje,
    id_ruta,
    id_bus,
    id_conductor,
    fecha_hora,
    pasajeros_registrados,
    estado
FROM viajes;

-- 2. MOSTRAR DOS COLUMNAS RELEVANTES

SELECT
    fecha_hora,
    pasajeros_registrados
FROM viajes;

-- 3. FILTRAR VIAJES POR FECHA

SELECT
    id_viaje,
    id_ruta,
    fecha_hora,
    pasajeros_registrados,
    estado
FROM viajes
WHERE fecha_hora >= '2026-08-22 00:00';

-- 4. ORDENAR VIAJES POR FECHA

SELECT
    id_viaje,
    fecha_hora,
    pasajeros_registrados,
    estado
FROM viajes
ORDER BY fecha_hora ASC;

-- 5. CINCO VIAJES CON MAYOR CANTIDAD DE PASAJEROS

SELECT
    id_viaje,
    id_ruta,
    id_bus,
    fecha_hora,
    pasajeros_registrados
FROM viajes
ORDER BY pasajeros_registrados DESC
LIMIT 5;

-- 6. CONTAR REGISTROS TOTALES

SELECT
    COUNT(*) AS total_viajes
FROM viajes;

-- 7. PROMEDIO, MINIMO Y MAXIMO DE PASAJEROS

SELECT
    ROUND(AVG(pasajeros_registrados), 2) AS promedio_pasajeros,
    MIN(pasajeros_registrados) AS minimo_pasajeros,
    MAX(pasajeros_registrados) AS maximo_pasajeros
FROM viajes;

-- 8. AGRUPAR VIAJES POR ESTADO

SELECT
    estado,
    COUNT(*) AS total_viajes
FROM viajes
GROUP BY estado
ORDER BY total_viajes DESC;

-- 9. RELACIONAR RUTAS Y VIAJES

SELECT
    r.codigo AS ruta,
    r.origen,
    r.destino,
    v.fecha_hora,
    v.pasajeros_registrados,
    v.estado
FROM rutas AS r
INNER JOIN viajes AS v
    ON v.id_ruta = r.id_ruta
ORDER BY v.fecha_hora ASC;

-- 10. WHERE, ORDER BY Y LIMIT

SELECT
    id_viaje,
    fecha_hora,
    pasajeros_registrados,
    estado
FROM viajes
WHERE estado = 'Programado'
ORDER BY pasajeros_registrados DESC
LIMIT 5;

-- 11. REPORTE CON ALIAS LEGIBLES

SELECT
    v.id_viaje AS "ID Viaje",
    r.codigo AS "Ruta",
    r.origen AS "Origen",
    r.destino AS "Destino",
    b.placa AS "Bus",
    b.capacidad AS "Capacidad",
    c.nombre_completo AS "Conductor",
    v.fecha_hora AS "Fecha y Hora",
    v.pasajeros_registrados AS "Pasajeros",
    v.estado AS "Estado",
    ROUND(
        (CAST(v.pasajeros_registrados AS REAL) / b.capacidad) * 100,
        2
    ) AS "Ocupacion Porcentaje"
FROM viajes AS v
INNER JOIN rutas AS r
    ON r.id_ruta = v.id_ruta
INNER JOIN buses AS b
    ON b.id_bus = v.id_bus
INNER JOIN conductores AS c
    ON c.id_conductor = v.id_conductor
ORDER BY v.fecha_hora ASC;

-- 12. DECISION DE NEGOCIO: RUTAS CON MAYOR DEMANDA

SELECT
    r.codigo AS "Ruta",
    r.origen AS "Origen",
    r.destino AS "Destino",
    COUNT(v.id_viaje) AS "Viajes Programados",
    SUM(v.pasajeros_registrados) AS "Pasajeros Totales",
    ROUND(AVG(v.pasajeros_registrados), 2) AS "Promedio Pasajeros",
    CASE
        WHEN AVG(
            CAST(v.pasajeros_registrados AS REAL) / b.capacidad
        ) >= 0.80 THEN 'Alta demanda'
        WHEN AVG(
            CAST(v.pasajeros_registrados AS REAL) / b.capacidad
        ) >= 0.50 THEN 'Demanda media'
        ELSE 'Baja demanda'
    END AS "Nivel de Demanda"
FROM rutas AS r
INNER JOIN viajes AS v
    ON v.id_ruta = r.id_ruta
INNER JOIN buses AS b
    ON b.id_bus = v.id_bus
WHERE v.estado <> 'Cancelado'
GROUP BY
    r.id_ruta,
    r.codigo,
    r.origen,
    r.destino
ORDER BY "Pasajeros Totales" DESC;