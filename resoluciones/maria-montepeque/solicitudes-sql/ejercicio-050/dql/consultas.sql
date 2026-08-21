.headers on
.mode column

-- Ejercicio 050: Track Day Hiperdeportivos
-- Consultas de validacion.

-- 1. Que registros principales existen (con JOIN triple: piloto,
--    vehiculo y sesion).
SELECT
    t.id_tiempo,
    p.nombre_piloto,
    v.modelo,
    s.numero_sesion,
    t.vuelta,
    t.tiempo_segundos,
    t.estado
FROM tiempos t
JOIN pilotos p ON p.id_piloto = t.id_piloto
JOIN vehiculos v ON v.id_vehiculo = t.id_vehiculo
JOIN sesiones s ON s.id_sesion = t.id_sesion;

-- 2. Que tiempos no estan validos todavia.
SELECT id_tiempo, id_piloto, id_sesion, vuelta, estado
FROM tiempos
WHERE estado <> 'valido';

-- 3. Que piloto tiene mas vueltas registradas.
SELECT p.nombre_piloto, COUNT(*) AS total_vueltas
FROM pilotos p
JOIN tiempos t ON t.id_piloto = p.id_piloto
GROUP BY p.id_piloto, p.nombre_piloto
ORDER BY total_vueltas DESC, p.nombre_piloto;

-- 4. Tiempos ordenados de menor a mayor (el mas rapido primero).
SELECT p.nombre_piloto, v.modelo, t.tiempo_segundos, t.estado
FROM tiempos t
JOIN pilotos p ON p.id_piloto = t.id_piloto
JOIN vehiculos v ON v.id_vehiculo = t.id_vehiculo
ORDER BY t.tiempo_segundos ASC;

-- 5. Mejor tiempo de cada piloto (solo vueltas validas), para armar
--    el ranking del dia.
SELECT p.nombre_piloto, MIN(t.tiempo_segundos) AS mejor_tiempo
FROM pilotos p
JOIN tiempos t ON t.id_piloto = p.id_piloto
WHERE t.estado = 'valido'
GROUP BY p.id_piloto, p.nombre_piloto
ORDER BY mejor_tiempo ASC;
