.headers on
.mode column

-- Ejercicio 075: Track Day Hiperdeportivos
-- Consultas que responden preguntas reales del cliente.

-- 1. Que registros principales existen: todos los tiempos con su
-- piloto, su vehiculo y su sesion.
SELECT t.id_tiempo,
       p.nombre_piloto,
       v.modelo,
       s.fecha_sesion,
       t.vuelta,
       t.tiempo_segundos
FROM tiempos t
JOIN pilotos p ON p.id_piloto = t.id_piloto
JOIN vehiculos v ON v.id_vehiculo = t.id_vehiculo
JOIN sesiones s ON s.id_sesion = t.id_sesion;

-- 2. Que sesiones estan programadas, en curso, finalizadas o
-- canceladas.
SELECT id_sesion, fecha_sesion, pista, estado
FROM sesiones
ORDER BY estado;

-- 3. Que piloto tiene mas vueltas registradas (ranking de actividad).
SELECT p.nombre_piloto, COUNT(*) AS total_vueltas
FROM pilotos p
JOIN tiempos t ON t.id_piloto = p.id_piloto
GROUP BY p.id_piloto, p.nombre_piloto
ORDER BY total_vueltas DESC, p.nombre_piloto;

-- 4. Tiempos ordenados de la vuelta mas rapida a la mas lenta.
SELECT p.nombre_piloto, v.modelo, t.tiempo_segundos
FROM tiempos t
JOIN pilotos p ON p.id_piloto = t.id_piloto
JOIN vehiculos v ON v.id_vehiculo = t.id_vehiculo
ORDER BY t.tiempo_segundos;

-- 5. Reporte para decision de negocio: tiempo promedio por piloto,
-- para decidir a quienes invitar al siguiente evento (candidatos:
-- promedio menor a 93 segundos).
SELECT p.nombre_piloto,
       ROUND(AVG(t.tiempo_segundos), 3) AS promedio_segundos
FROM tiempos t
JOIN pilotos p ON p.id_piloto = t.id_piloto
GROUP BY p.id_piloto, p.nombre_piloto
HAVING AVG(t.tiempo_segundos) < 93
ORDER BY promedio_segundos;
