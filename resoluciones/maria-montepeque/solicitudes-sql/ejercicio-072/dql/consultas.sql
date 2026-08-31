.headers on
.mode column

-- Ejercicio 072: Liga MOBA
-- Consultas que responden preguntas reales del cliente.

-- 1. Que registros principales existen: todas las estadisticas con su
-- jugador, su heroe y su partida.
SELECT e.id_estadistica,
       j.nickname,
       h.nombre_heroe,
       p.fecha_partida,
       e.kills,
       e.muertes,
       e.asistencias,
       e.oro_conseguido
FROM estadisticas e
JOIN jugadores j ON j.id_jugador = e.id_jugador
JOIN heroes h ON h.id_heroe = e.id_heroe
JOIN partidas p ON p.id_partida = e.id_partida;

-- 2. Que partidas estan programadas, jugadas o canceladas.
SELECT id_partida, fecha_partida, estado, id_equipo_ganador
FROM partidas
ORDER BY estado;

-- 3. Que jugador tiene mas kills acumulados (ranking de actividad).
SELECT j.nickname, SUM(e.kills) AS kills_totales
FROM jugadores j
JOIN estadisticas e ON e.id_jugador = j.id_jugador
GROUP BY j.id_jugador, j.nickname
ORDER BY kills_totales DESC, j.nickname
LIMIT 5;

-- 4. Estadisticas ordenadas por oro conseguido, de mayor a menor.
SELECT j.nickname, h.nombre_heroe, e.oro_conseguido
FROM estadisticas e
JOIN jugadores j ON j.id_jugador = e.id_jugador
JOIN heroes h ON h.id_heroe = e.id_heroe
ORDER BY e.oro_conseguido DESC;

-- 5. Reporte para decision de negocio: oro total generado por cada
-- equipo, para saber cual domina economicamente la liga (GROUP BY +
-- HAVING).
SELECT eq.nombre_equipo,
       SUM(e.oro_conseguido) AS oro_total
FROM estadisticas e
JOIN jugadores j ON j.id_jugador = e.id_jugador
JOIN equipos eq ON eq.id_equipo = j.id_equipo
GROUP BY eq.id_equipo, eq.nombre_equipo
HAVING SUM(e.oro_conseguido) > 0
ORDER BY oro_total DESC;
