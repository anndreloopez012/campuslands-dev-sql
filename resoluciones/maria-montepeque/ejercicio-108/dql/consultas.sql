.headers on
.mode column

-- Ejercicio 108: Indices Nivel Intermedio
-- Consultas de validacion.

-- 1. Mostrar todos los datos principales.
SELECT p.id_partida, e.nombre_equipo, p.puntaje, p.fecha_partida, p.resultado
FROM partidas p
JOIN equipos e ON e.id_equipo = p.id_equipo;

-- 2. Consulta con WHERE: las partidas del equipo 1 (usa idx_partidas_equipo_fecha por su columna izquierda).
SELECT id_partida, puntaje, fecha_partida, resultado
FROM partidas
WHERE id_equipo = 1;

-- 3. Consulta con ORDER BY: partidas ordenadas por fecha.
SELECT id_partida, id_equipo, puntaje, fecha_partida
FROM partidas
ORDER BY fecha_partida;

-- 4. Conteo o resumen: total de partidas por equipo.
SELECT id_equipo, COUNT(*) AS total_partidas
FROM partidas
GROUP BY id_equipo;

-- 5. Validacion especifica de Indices: EXPLAIN QUERY PLAN confirma
-- que filtrar por id_equipo Y fecha_partida (las dos columnas del
-- indice compuesto, en orden) usa
-- "SEARCH ... USING INDEX idx_partidas_equipo_fecha
-- (id_equipo=? AND fecha_partida=?)" en vez de revisar toda la
-- tabla. Este es el proposito central de un indice compuesto:
-- acelerar las consultas que filtran por su columna izquierda, sola
-- o combinada con las siguientes.
EXPLAIN QUERY PLAN
SELECT id_partida, puntaje, resultado
FROM partidas
WHERE id_equipo = 1 AND fecha_partida = '2026-08-10';

-- Caso comentado que no es recomendable, dejar comentado: esperar
-- que idx_partidas_equipo_fecha tambien acelere una consulta que
-- filtra SOLO por fecha_partida (la columna de la DERECHA del
-- indice, sin id_equipo). Un indice compuesto solo sirve para
-- busquedas que usan su columna mas a la izquierda (id_equipo);
-- saltarsela invalida el indice para esa consulta. Se verifico con
-- Python (sqlite3) que el EXPLAIN QUERY PLAN de esta consulta muestra
-- "SCAN partidas" (revisa las 10 filas una por una), NO
-- "SEARCH ... USING INDEX idx_partidas_equipo_fecha", a pesar de que
-- fecha_partida SI forma parte del indice.
-- EXPLAIN QUERY PLAN
-- SELECT id_partida, id_equipo, resultado
-- FROM partidas
-- WHERE fecha_partida = '2026-08-13';
