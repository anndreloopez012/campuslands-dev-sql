.headers on
.mode column

-- Ejercicio 56: CHECK Nivel Basico
-- Consultas de validacion.

-- 1. Mostrar todos los datos principales.
SELECT * FROM partidas;

-- 2. Consulta con WHERE.
SELECT id_partida, id_equipo_local, id_equipo_visitante, fecha_partida
FROM partidas
WHERE estado = 'jugada';

-- 3. Consulta con ORDER BY.
SELECT id_partida, fecha_partida, estado
FROM partidas
ORDER BY fecha_partida;

-- 4. Conteo o resumen: partidas por estado.
SELECT estado, COUNT(*) AS total
FROM partidas
GROUP BY estado
ORDER BY estado;

-- 5. Validacion especifica del tema CHECK:
--    a) ningun puntaje registrado es negativo (el CHECK de rango numerico
--       nunca dejo entrar un valor invalido).
SELECT
    MIN(puntaje_local) AS puntaje_local_minimo,
    MIN(puntaje_visitante) AS puntaje_visitante_minimo
FROM partidas
WHERE estado = 'jugada';

--    b) ninguna partida tiene el mismo equipo como local y visitante (el
--       CHECK a nivel de tabla lo impide).
SELECT COUNT(*) AS partidas_equipo_contra_si_mismo
FROM partidas
WHERE id_equipo_local = id_equipo_visitante;
