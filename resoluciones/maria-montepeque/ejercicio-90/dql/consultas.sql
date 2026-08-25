.headers on
.mode column

-- Ejercicio 90: GROUP BY Nivel Intermedio
-- Consultas de validacion.

-- 1. Mostrar todos los datos principales.
SELECT p.id_partida, e.nombre_equipo, p.fecha_partida, p.puntaje, p.resultado
FROM partidas p
JOIN equipos e ON e.id_equipo = p.id_equipo;

-- 2. Consulta con WHERE: solo las partidas ganadas.
SELECT id_partida, id_equipo, fecha_partida, puntaje
FROM partidas
WHERE resultado = 'victoria';

-- 3. Consulta con ORDER BY: partidas ordenadas por fecha.
SELECT id_partida, fecha_partida, resultado
FROM partidas
ORDER BY fecha_partida;

-- 4. Conteo o resumen: total de partidas jugadas por equipo (GROUP BY simple).
SELECT id_equipo, COUNT(*) AS total_partidas
FROM partidas
GROUP BY id_equipo;

-- 5. Validacion especifica de GROUP BY: por cada equipo, suma y
-- promedio del puntaje de sus partidas, filtrando con HAVING solo a
-- los equipos cuyo promedio supera los 70 puntos. HAVING filtra
-- despues de agrupar (a diferencia de WHERE, que filtraria filas
-- individuales antes de que existan los grupos).
SELECT e.nombre_equipo,
       COUNT(*) AS total_partidas,
       SUM(p.puntaje) AS puntaje_total,
       ROUND(AVG(p.puntaje), 2) AS promedio_puntaje
FROM partidas p
JOIN equipos e ON e.id_equipo = p.id_equipo
GROUP BY e.id_equipo, e.nombre_equipo
HAVING AVG(p.puntaje) > 70;

-- Caso comentado que no es recomendable, dejar comentado: agrupar por
-- equipo pero mostrar nombre_jugador sin agregarlo ni incluirlo en el
-- GROUP BY. SQLite lo permite (a diferencia de MySQL en modo
-- estricto ONLY_FULL_GROUP_BY, donde fallaria), pero el valor de
-- nombre_jugador que devuelve es arbitrario: no representa a todo el
-- grupo, porque un equipo puede tener varios jugadores.
-- SELECT e.nombre_equipo, j.nombre_jugador, COUNT(*)
-- FROM partidas p
-- JOIN equipos e ON e.id_equipo = p.id_equipo
-- JOIN jugadores j ON j.id_equipo = e.id_equipo
-- GROUP BY e.id_equipo;
