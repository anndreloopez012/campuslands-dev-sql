-- Ejercicio 06: Torneo Esports
-- Entidad central: resultados

-- 1. Listar todos los registros principales de la entidad central
SELECT * FROM resultados;

-- 2. Mostrar solo dos columnas relevantes
SELECT kills, puntos FROM resultados;

-- 3. Filtrar registros por una condicion numerica
SELECT * FROM resultados WHERE kills >= 20;

-- 4. Ordenar resultados por puntos
SELECT * FROM resultados ORDER BY puntos DESC;

-- 5. Mostrar los 5 mejores resultados segun puntos
SELECT * FROM resultados ORDER BY puntos DESC LIMIT 5;

-- 6. Contar registros totales
SELECT COUNT(*) AS total_resultados FROM resultados;

-- 7. Promedio, minimo y maximo de puntos
SELECT
    AVG(puntos) AS promedio,
    MIN(puntos) AS minimo,
    MAX(puntos) AS maximo
FROM resultados;

-- 8. Agrupar resultados por jugador
SELECT id_jugador, COUNT(*) AS partidas_jugadas, SUM(puntos) AS puntos_totales
FROM resultados
GROUP BY id_jugador;

-- 9. Relacionar resultados, jugadores y partidas con JOIN
SELECT r.id_resultado, j.nickname, p.mapa
FROM resultados r
JOIN jugadores j ON j.id_jugador = r.id_jugador
JOIN partidas p ON p.id_partida = r.id_partida;

-- 10. WHERE + ORDER BY + LIMIT
SELECT * FROM resultados
WHERE muertes < 15
ORDER BY kills DESC
LIMIT 3;

-- 11. Reporte con alias legibles
SELECT
    j.nickname AS jugador,
    e.nombre AS equipo,
    p.mapa AS mapa,
    r.kills AS bajas,
    r.muertes AS muertes,
    r.puntos AS puntos
FROM resultados r
JOIN jugadores j ON j.id_jugador = r.id_jugador
JOIN equipos e ON e.id_equipo = j.id_equipo
JOIN partidas p ON p.id_partida = r.id_partida;

-- 12. Consulta para decision de negocio: jugador con mas puntos acumulados (MVP)
SELECT j.nickname, SUM(r.puntos) AS puntos_totales
FROM resultados r
JOIN jugadores j ON j.id_jugador = r.id_jugador
GROUP BY j.nickname
ORDER BY puntos_totales DESC
LIMIT 1;
