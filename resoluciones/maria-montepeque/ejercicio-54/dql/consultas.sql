.headers on
.mode column

-- Ejercicio 54: NOT NULL Nivel Intermedio
-- Consultas de validacion.

-- 1. Mostrar todos los datos principales.
SELECT * FROM partidas;

-- 2. Consulta con WHERE.
SELECT id_partida, id_equipo_local, id_equipo_visitante, fecha_partida
FROM partidas
WHERE estado = 'programada';

-- 3. Consulta con ORDER BY.
SELECT id_partida, fecha_partida, estado
FROM partidas
ORDER BY fecha_partida;

-- 4. Conteo o resumen: jugadores registrados por equipo.
SELECT e.nombre_equipo, COUNT(j.id_jugador) AS total_jugadores
FROM equipos e
LEFT JOIN jugadores j ON j.id_equipo = e.id_equipo
GROUP BY e.nombre_equipo
ORDER BY e.nombre_equipo;

-- 5. Validacion especifica del tema NOT NULL:
--    a) ningun partido puede tener fecha_partida vacia: el conteo de
--       partidas con fecha_partida no nulo es igual al total de partidas.
SELECT
    COUNT(*) AS total_partidas,
    COUNT(fecha_partida) AS partidas_con_fecha
FROM partidas;

--    b) contraste con un campo OPCIONAL (puntaje_local): aqui si es normal
--       que falten valores mientras el partido no se ha jugado, y NOT NULL
--       nunca lo exigio.
SELECT
    COUNT(*) AS total_partidas,
    COUNT(puntaje_local) AS partidas_con_puntaje,
    COUNT(*) - COUNT(puntaje_local) AS partidas_sin_puntaje
FROM partidas;
