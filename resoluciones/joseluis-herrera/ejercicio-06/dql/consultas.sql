SELECT
    id_partida,
    id_equipo_1,
    id_equipo_2,
    fecha_partida,
    ronda,
    estado
FROM partidas;

SELECT
    id_partida,
    fecha_partida
FROM partidas;

SELECT
    id_partida,
    fecha_partida,
    ronda,
    estado
FROM partidas
WHERE fecha_partida >= '2026-07-03';

SELECT
    id_partida,
    fecha_partida,
    ronda
FROM partidas
ORDER BY fecha_partida ASC;

SELECT
    p.id_partida,
    e1.nombre AS equipo_1,
    e2.nombre AS equipo_2,
    r.puntos_equipo_1,
    r.puntos_equipo_2,
    ABS(r.puntos_equipo_1 - r.puntos_equipo_2) AS diferencia
FROM partidas AS p
JOIN resultados AS r
    ON p.id_partida = r.id_partida
JOIN equipos AS e1
    ON p.id_equipo_1 = e1.id_equipo
JOIN equipos AS e2
    ON p.id_equipo_2 = e2.id_equipo
ORDER BY diferencia DESC
LIMIT 5;

SELECT COUNT(*) AS total_partidas
FROM partidas;

SELECT
    ROUND(AVG(puntos_equipo_1), 2) AS promedio_puntos_equipo_1,
    MIN(puntos_equipo_1) AS minimo_puntos_equipo_1,
    MAX(puntos_equipo_1) AS maximo_puntos_equipo_1
FROM resultados;

SELECT
    ronda,
    COUNT(*) AS cantidad_partidas
FROM partidas
GROUP BY ronda;

SELECT
    p.id_partida,
    e1.nombre AS equipo_1,
    e2.nombre AS equipo_2,
    p.fecha_partida,
    p.ronda
FROM partidas AS p
JOIN equipos AS e1
    ON p.id_equipo_1 = e1.id_equipo
JOIN equipos AS e2
    ON p.id_equipo_2 = e2.id_equipo;

SELECT
    p.id_partida,
    e1.nombre AS equipo_1,
    e2.nombre AS equipo_2,
    r.puntos_equipo_1,
    r.puntos_equipo_2
FROM partidas AS p
JOIN equipos AS e1
    ON p.id_equipo_1 = e1.id_equipo
JOIN equipos AS e2
    ON p.id_equipo_2 = e2.id_equipo
JOIN resultados AS r
    ON p.id_partida = r.id_partida
WHERE r.puntos_equipo_1 >= 15
ORDER BY r.puntos_equipo_1 DESC
LIMIT 5;

SELECT
    p.id_partida AS "Partida",
    e1.nombre AS "Equipo 1",
    e2.nombre AS "Equipo 2",
    r.puntos_equipo_1 AS "Puntos Equipo 1",
    r.puntos_equipo_2 AS "Puntos Equipo 2",
    r.ganador AS "Ganador"
FROM partidas AS p
JOIN equipos AS e1
    ON p.id_equipo_1 = e1.id_equipo
JOIN equipos AS e2
    ON p.id_equipo_2 = e2.id_equipo
JOIN resultados AS r
    ON p.id_partida = r.id_partida
ORDER BY p.fecha_partida;

SELECT
    e.nombre AS equipo,
    COUNT(CASE
        WHEN r.ganador = 'EQUIPO_1'
             AND p.id_equipo_1 = e.id_equipo THEN 1
        WHEN r.ganador = 'EQUIPO_2'
             AND p.id_equipo_2 = e.id_equipo THEN 1
    END) AS victorias,
    COUNT(p.id_partida) AS partidas_jugadas,
    CASE
        WHEN COUNT(p.id_partida) = 0 THEN 'SIN PARTIDAS'
        WHEN CAST(COUNT(CASE
            WHEN r.ganador = 'EQUIPO_1'
                 AND p.id_equipo_1 = e.id_equipo THEN 1
            WHEN r.ganador = 'EQUIPO_2'
                 AND p.id_equipo_2 = e.id_equipo THEN 1
        END) AS REAL) / COUNT(p.id_partida) >= 0.75 THEN 'CANDIDATO AL TITULO'
        WHEN CAST(COUNT(CASE
            WHEN r.ganador = 'EQUIPO_1'
                 AND p.id_equipo_1 = e.id_equipo THEN 1
            WHEN r.ganador = 'EQUIPO_2'
                 AND p.id_equipo_2 = e.id_equipo THEN 1
        END) AS REAL) / COUNT(p.id_partida) >= 0.50 THEN 'COMPETITIVO'
        ELSE 'NECESITA MEJORAR'
    END AS decision
FROM equipos AS e
LEFT JOIN partidas AS p
    ON e.id_equipo = p.id_equipo_1
    OR e.id_equipo = p.id_equipo_2
LEFT JOIN resultados AS r
    ON p.id_partida = r.id_partida
GROUP BY e.id_equipo, e.nombre
ORDER BY victorias DESC;