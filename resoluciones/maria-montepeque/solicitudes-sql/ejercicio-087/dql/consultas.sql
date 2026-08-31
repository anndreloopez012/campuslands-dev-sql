.headers on
.mode column

-- Ejercicio 087: Club Futbol Sala
-- Consultas que responden preguntas reales del cliente.

-- 1. Que registros principales existen: se usa la vista
-- vista_resumen_partidos (creada en ddl/schema.sql).
SELECT *
FROM vista_resumen_partidos;

-- 2. Que partidos estan programados, en curso, finalizados o
-- suspendidos.
SELECT id_partido, fecha_partido, estado
FROM partidos
ORDER BY estado;

-- 3. Que jugador tiene mas goles (ranking de actividad).
SELECT j.nombre_jugador, COUNT(*) AS total_goles
FROM jugadores j
JOIN goles g ON g.id_jugador = j.id_jugador
GROUP BY j.id_jugador, j.nombre_jugador
ORDER BY total_goles DESC, j.nombre_jugador;

-- 4. Goles ordenados por partido y, dentro de cada partido, por
-- minuto.
SELECT id_partido, id_jugador, minuto
FROM goles
ORDER BY id_partido, minuto;

-- 5. Reporte para decision de negocio: jugadores con 2 o mas goles,
-- candidatos a mejor jugador del torneo (GROUP BY + HAVING).
SELECT j.nombre_jugador,
       COUNT(*) AS total_goles
FROM jugadores j
JOIN goles g ON g.id_jugador = j.id_jugador
GROUP BY j.id_jugador, j.nombre_jugador
HAVING COUNT(*) >= 2
ORDER BY total_goles DESC, j.nombre_jugador;
