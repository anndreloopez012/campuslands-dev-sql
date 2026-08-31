.headers on
.mode column

-- Ejercicio 88: ORDER BY Nivel Aplicado
-- Consultas de validacion.

-- 1. Mostrar todos los datos principales.
SELECT p.id_partida,
       eloc.nombre_equipo AS equipo_local,
       evis.nombre_equipo AS equipo_visitante,
       p.puntaje_local,
       p.puntaje_visitante,
       p.estado
FROM partidas p
JOIN equipos eloc ON eloc.id_equipo = p.id_equipo_local
JOIN equipos evis ON evis.id_equipo = p.id_equipo_visitante;

-- 2. Consulta con WHERE: partidas ya jugadas.
SELECT id_partida, fecha_partida, puntaje_local, puntaje_visitante
FROM partidas
WHERE estado = 'jugada';

-- 3. Consulta con ORDER BY: partidas ordenadas por fecha.
SELECT id_partida, fecha_partida, estado
FROM partidas
ORDER BY fecha_partida;

-- 4. Conteo o resumen: total de partidas por estado.
SELECT estado, COUNT(*) AS total
FROM partidas
GROUP BY estado;

-- 5. Caso de negocio con reporte final (nivel aplicado): tabla de
-- posiciones del torneo. Cada columna (puntos, goles a favor, goles
-- en contra) se calcula con una subconsulta correlacionada sobre las
-- partidas 'jugada' de cada equipo, y el ORDER BY final usa varios
-- criterios de desempate, igual que una tabla de posiciones real:
-- primero puntos (de mas a menos), despues diferencia de goles (de
-- mas a menos), y por ultimo nombre del equipo (alfabetico) para los
-- casos que sigan empatados.
SELECT
    e.nombre_equipo,
    (
        SELECT COALESCE(SUM(
            CASE
                WHEN (p.id_equipo_local = e.id_equipo AND p.puntaje_local > p.puntaje_visitante)
                  OR (p.id_equipo_visitante = e.id_equipo AND p.puntaje_visitante > p.puntaje_local)
                THEN 3
                WHEN p.puntaje_local = p.puntaje_visitante THEN 1
                ELSE 0
            END
        ), 0)
        FROM partidas p
        WHERE p.estado = 'jugada'
          AND (p.id_equipo_local = e.id_equipo OR p.id_equipo_visitante = e.id_equipo)
    ) AS puntos,
    (
        SELECT COALESCE(SUM(CASE WHEN p.id_equipo_local = e.id_equipo THEN p.puntaje_local ELSE p.puntaje_visitante END), 0)
        FROM partidas p
        WHERE p.estado = 'jugada'
          AND (p.id_equipo_local = e.id_equipo OR p.id_equipo_visitante = e.id_equipo)
    ) AS goles_favor,
    (
        SELECT COALESCE(SUM(CASE WHEN p.id_equipo_local = e.id_equipo THEN p.puntaje_visitante ELSE p.puntaje_local END), 0)
        FROM partidas p
        WHERE p.estado = 'jugada'
          AND (p.id_equipo_local = e.id_equipo OR p.id_equipo_visitante = e.id_equipo)
    ) AS goles_contra
FROM equipos e
ORDER BY puntos DESC, (goles_favor - goles_contra) DESC, e.nombre_equipo ASC;

-- Caso comentado que debe fallar (no ser recomendable), dejar
-- comentado: ordenar por la posicion de una columna que no existe en
-- el resultado (la consulta 1 solo tiene 6 columnas, no 9).
-- SELECT p.id_partida, eloc.nombre_equipo, evis.nombre_equipo, p.puntaje_local, p.puntaje_visitante, p.estado
-- FROM partidas p JOIN equipos eloc ON eloc.id_equipo=p.id_equipo_local JOIN equipos evis ON evis.id_equipo=p.id_equipo_visitante
-- ORDER BY 9;
