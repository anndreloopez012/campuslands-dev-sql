-- Ejercicio 11: Transporte Rutas
-- Entidad central: viajes

-- 1. Listar todos los registros principales de la entidad central
SELECT * FROM viajes;

-- 2. Mostrar solo dos columnas relevantes
SELECT fecha_hora, pasajeros FROM viajes;

-- 3. Filtrar registros por una condicion numerica
SELECT * FROM viajes WHERE pasajeros > 35;

-- 4. Ordenar resultados por fecha
SELECT * FROM viajes ORDER BY fecha_hora;

-- 5. Mostrar los 5 viajes con mas pasajeros
SELECT * FROM viajes ORDER BY pasajeros DESC LIMIT 5;

-- 6. Contar registros totales
SELECT COUNT(*) AS total_viajes FROM viajes;

-- 7. Promedio, minimo y maximo de pasajeros
SELECT
    AVG(pasajeros) AS promedio,
    MIN(pasajeros) AS minimo,
    MAX(pasajeros) AS maximo
FROM viajes;

-- 8. Agrupar viajes por estado
SELECT estado, COUNT(*) AS cantidad
FROM viajes
GROUP BY estado;

-- 9. Relacionar viajes, rutas y buses con JOIN
SELECT v.id_viaje, r.origen, r.destino, b.placa
FROM viajes v
JOIN rutas r ON r.id_ruta = v.id_ruta
JOIN buses b ON b.id_bus = v.id_bus;

-- 10. WHERE + ORDER BY + LIMIT
SELECT * FROM viajes
WHERE estado = 'programado'
ORDER BY fecha_hora
LIMIT 3;

-- 11. Reporte con alias legibles
SELECT
    r.origen AS origen,
    r.destino AS destino,
    b.placa AS bus,
    c.nombre AS conductor,
    v.fecha_hora AS fecha,
    v.pasajeros AS pasajeros
FROM viajes v
JOIN rutas r ON r.id_ruta = v.id_ruta
JOIN buses b ON b.id_bus = v.id_bus
JOIN conductores c ON c.id_conductor = v.id_conductor;

-- 12. Consulta para decision de negocio: ruta con mas pasajeros transportados
SELECT r.origen, r.destino, SUM(v.pasajeros) AS total_pasajeros
FROM viajes v
JOIN rutas r ON r.id_ruta = v.id_ruta
GROUP BY r.origen, r.destino
ORDER BY total_pasajeros DESC
LIMIT 1;
