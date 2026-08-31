.headers on
.mode column

-- Ejercicio 92: HAVING Nivel Basico
-- Consultas de validacion.

-- 1. Mostrar todos los datos principales.
SELECT p.id_partida, e.nombre_equipo, p.fecha_partida, p.resultado
FROM partidas p
JOIN equipos e ON e.id_equipo = p.id_equipo;

-- 2. Consulta con WHERE: solo las partidas ganadas.
SELECT id_partida, id_equipo, fecha_partida
FROM partidas
WHERE resultado = 'victoria';

-- 3. Consulta con ORDER BY: partidas ordenadas por fecha.
SELECT id_partida, fecha_partida, resultado
FROM partidas
ORDER BY fecha_partida;

-- 4. Conteo o resumen: total de partidas jugadas por equipo (GROUP BY, sin filtrar grupos todavia).
SELECT id_equipo, COUNT(*) AS total_partidas
FROM partidas
GROUP BY id_equipo;

-- 5. Validacion especifica de HAVING: equipos con 2 o mas victorias.
-- Primero WHERE deja solo las partidas ganadas (filtro por fila), luego
-- GROUP BY agrupa esas victorias por equipo, y HAVING filtra los
-- grupos resultantes quedandose solo con los que tienen COUNT(*) >= 2
-- (a diferencia de WHERE, HAVING evalua el resultado ya agregado).
SELECT e.nombre_equipo, COUNT(*) AS total_victorias
FROM partidas p
JOIN equipos e ON e.id_equipo = p.id_equipo
WHERE p.resultado = 'victoria'
GROUP BY p.id_equipo, e.nombre_equipo
HAVING COUNT(*) >= 2;

-- Caso comentado que no es recomendable, dejar comentado: usar HAVING
-- con una columna que no esta ni en el GROUP BY ni dentro de una
-- funcion de agregacion, esperando que filtre solo las victorias.
-- SQLite no lanza error (a diferencia de MySQL en modo estricto
-- ONLY_FULL_GROUP_BY), pero el valor de "resultado" que evalua es
-- arbitrario (uno cualquiera de los resultados del grupo), y
-- COUNT(*) sigue contando TODAS las partidas del equipo, no solo las
-- victorias: se verifico con Python (sqlite3) que devuelve los
-- equipos 1, 2 y 3 con total_partidas 4, 2 y 3 (sus totales de
-- partidas, no sus victorias reales de 3, 1 y 2), y solo excluye al
-- equipo 4 por coincidencia (su primer resultado es 'derrota'). La
-- forma correcta es la de la consulta 5: filtrar con WHERE antes de
-- agrupar, y usar HAVING sobre el conteo ya agregado.
-- SELECT id_equipo, COUNT(*) AS total_partidas
-- FROM partidas
-- GROUP BY id_equipo
-- HAVING resultado = 'victoria';
