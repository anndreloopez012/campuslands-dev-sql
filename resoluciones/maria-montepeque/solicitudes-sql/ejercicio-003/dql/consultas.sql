.headers on
.mode column

-- Ejercicio 003: Torneo Esports
-- Consultas de validacion.

-- 1. Que registros principales existen.
SELECT * FROM jugadores;

-- 2. Que registros estan activos, pendientes o finalizados (aqui:
--    jugadores que NO estan disponibles para competir).
SELECT id_jugador, nickname, id_equipo, estado
FROM jugadores
WHERE estado <> 'activo';

-- 3. Que equipo tiene mas jugadores activos.
SELECT e.nombre_equipo, COUNT(*) AS jugadores_activos
FROM equipos e
JOIN jugadores j ON j.id_equipo = e.id_equipo
WHERE j.estado = 'activo'
GROUP BY e.id_equipo, e.nombre_equipo
ORDER BY jugadores_activos DESC;

-- 4. Jugadores ordenados por puntos, de mayor a menor.
SELECT nickname, nombre_real, puntos_totales
FROM jugadores
ORDER BY puntos_totales DESC;

-- 5. Reporte util para el cliente: ranking de equipos por puntos totales
--    acumulados de sus jugadores, para decidir a que equipo asignar el
--    proximo torneo.
SELECT
    e.nombre_equipo,
    SUM(j.puntos_totales) AS puntos_totales_equipo,
    COUNT(j.id_jugador) AS total_jugadores
FROM equipos e
JOIN jugadores j ON j.id_equipo = e.id_equipo
GROUP BY e.id_equipo, e.nombre_equipo
ORDER BY puntos_totales_equipo DESC;
