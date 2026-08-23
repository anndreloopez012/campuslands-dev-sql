.headers on
.mode column

-- Ejercicio 025: Track Day Hiperdeportivos
-- Consultas de validacion.

-- 1. Que registros principales existen (con JOIN para mostrar el
--    piloto y el modelo en vez de solo los id numericos).
SELECT
    s.id_sesion,
    p.nombre_piloto,
    v.modelo,
    s.tiempo_vuelta_segundos,
    s.clima,
    s.estado
FROM sesiones s
JOIN vehiculos v ON v.id_vehiculo = s.id_vehiculo
JOIN pilotos p ON p.id_piloto = v.id_piloto;

-- 2. Que sesiones no estan validas todavia.
SELECT id_sesion, id_vehiculo, tiempo_vuelta_segundos, estado
FROM sesiones
WHERE estado <> 'valida';

-- 3. Que piloto tiene mas sesiones corridas.
SELECT p.nombre_piloto, COUNT(*) AS total_sesiones
FROM pilotos p
JOIN vehiculos v ON v.id_piloto = p.id_piloto
JOIN sesiones s ON s.id_vehiculo = v.id_vehiculo
GROUP BY p.id_piloto, p.nombre_piloto
ORDER BY total_sesiones DESC;

-- 4. Sesiones ordenadas por fecha.
SELECT p.nombre_piloto, v.modelo, s.fecha_sesion, s.tiempo_vuelta_segundos
FROM sesiones s
JOIN vehiculos v ON v.id_vehiculo = s.id_vehiculo
JOIN pilotos p ON p.id_piloto = v.id_piloto
ORDER BY s.fecha_sesion;

-- 5. Mejor tiempo de vuelta (record) de cada piloto, solo sesiones
--    validas, para armar la tabla de tiempos de la pista.
SELECT
    p.nombre_piloto,
    v.modelo,
    MIN(s.tiempo_vuelta_segundos) AS mejor_tiempo
FROM pilotos p
JOIN vehiculos v ON v.id_piloto = p.id_piloto
JOIN sesiones s ON s.id_vehiculo = v.id_vehiculo
WHERE s.estado = 'valida'
GROUP BY p.id_piloto, p.nombre_piloto, v.modelo
ORDER BY mejor_tiempo ASC;
