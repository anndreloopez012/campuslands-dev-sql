PRAGMA foreign_keys = ON;

-- =========================================================
-- 1. Listar todos los registros principales
-- Entidad central: partidas
-- =========================================================

SELECT
    id_partida,
    id_equipo_local,
    id_equipo_visitante,
    fecha_partida,
    fase
FROM partidas;

-- =========================================================
-- 2. Mostrar solo dos columnas relevantes
-- =========================================================

SELECT
    fecha_partida,
    fase
FROM partidas;

-- =========================================================
-- 3. Filtrar por condición de fecha
-- Partidas realizadas desde el 10 de julio.
-- =========================================================

SELECT
    id_partida,
    fecha_partida,
    fase
FROM partidas
WHERE fecha_partida >= '2026-07-10';

-- =========================================================
-- 4. Ordenar resultados por fecha
-- =========================================================

SELECT
    id_partida,
    fecha_partida,
    fase
FROM partidas
ORDER BY fecha_partida DESC;

-- =========================================================
-- 5. Top 5 equipos según cantidad de victorias
-- =========================================================

SELECT
    e.nombre,
    COUNT(r.id_resultado) AS victorias
FROM equipos AS e
INNER JOIN resultados AS r
    ON e.id_equipo = r.ganador_id_equipo
GROUP BY
    e.id_equipo,
    e.nombre
ORDER BY victorias DESC
LIMIT 5;

-- =========================================================
-- 6. Contar registros totales
-- =========================================================

SELECT
    COUNT(*) AS total_partidas
FROM partidas;

-- =========================================================
-- 7. Promedio, mínimo y máximo de duración
-- =========================================================

SELECT
    ROUND(AVG(duracion_minutos), 2) AS duracion_promedio,
    MIN(duracion_minutos) AS duracion_minima,
    MAX(duracion_minutos) AS duracion_maxima
FROM resultados;

-- =========================================================
-- 8. Agrupar resultados por fase
-- =========================================================

SELECT
    p.fase,
    COUNT(*) AS cantidad_partidas,
    ROUND(AVG(r.duracion_minutos), 2) AS duracion_promedio
FROM partidas AS p
INNER JOIN resultados AS r
    ON p.id_partida = r.id_partida
GROUP BY p.fase;

-- =========================================================
-- 9. Relacionar mínimo dos tablas con JOIN
-- Mostrar partidas con nombres de equipos.
-- =========================================================

SELECT
    p.id_partida,
    local.nombre AS equipo_local,
    visitante.nombre AS equipo_visitante,
    p.fecha_partida,
    p.fase
FROM partidas AS p
INNER JOIN equipos AS local
    ON p.id_equipo_local = local.id_equipo
INNER JOIN equipos AS visitante
    ON p.id_equipo_visitante = visitante.id_equipo;

-- =========================================================
-- 10. WHERE + ORDER BY + LIMIT
-- Partidas de semifinal y final más recientes.
-- =========================================================

SELECT
    id_partida,
    fecha_partida,
    fase
FROM partidas
WHERE fase IN ('SEMIFINAL', 'FINAL')
ORDER BY fecha_partida DESC
LIMIT 5;

-- =========================================================
-- 11. Reporte con alias legibles
-- =========================================================

SELECT
    p.id_partida AS 'ID Partida',
    local.nombre AS 'Equipo Local',
    visitante.nombre AS 'Equipo Visitante',
    ganador.nombre AS 'Equipo Ganador',
    r.puntos_local AS 'Puntos Local',
    r.puntos_visitante AS 'Puntos Visitante',
    r.duracion_minutos AS 'Duracion Minutos',
    p.fase AS 'Fase'
FROM partidas AS p
INNER JOIN resultados AS r
    ON p.id_partida = r.id_partida
INNER JOIN equipos AS local
    ON p.id_equipo_local = local.id_equipo
INNER JOIN equipos AS visitante
    ON p.id_equipo_visitante = visitante.id_equipo
INNER JOIN equipos AS ganador
    ON r.ganador_id_equipo = ganador.id_equipo
ORDER BY p.fecha_partida;

-- =========================================================
-- 12. Consulta para apoyar una decisión de negocio
-- Identificar equipos con mejor rendimiento.
--
-- Se calcula:
--   - partidas jugadas
--   - victorias
--   - porcentaje de victorias
-- =========================================================

WITH participaciones AS (
    SELECT
        id_equipo_local AS id_equipo
    FROM partidas

    UNION ALL

    SELECT
        id_equipo_visitante AS id_equipo
    FROM partidas
),
victorias AS (
    SELECT
        ganador_id_equipo AS id_equipo,
        COUNT(*) AS total_victorias
    FROM resultados
    GROUP BY ganador_id_equipo
)
SELECT
    e.nombre AS 'Equipo',
    COUNT(pa.id_equipo) AS 'Partidas Jugadas',
    COALESCE(v.total_victorias, 0) AS 'Victorias',
    ROUND(
        COALESCE(v.total_victorias, 0) * 100.0
        / COUNT(pa.id_equipo),
        2
    ) AS 'Porcentaje Victorias',
    CASE
        WHEN COALESCE(v.total_victorias, 0) * 1.0
             / COUNT(pa.id_equipo) >= 0.70
            THEN 'Candidato prioritario para patrocinio'
        WHEN COALESCE(v.total_victorias, 0) * 1.0
             / COUNT(pa.id_equipo) >= 0.50
            THEN 'Mantener seguimiento competitivo'
        ELSE 'Evaluar estrategia competitiva'
    END AS 'Decision'
FROM equipos AS e
INNER JOIN participaciones AS pa
    ON e.id_equipo = pa.id_equipo
LEFT JOIN victorias AS v
    ON e.id_equipo = v.id_equipo
GROUP BY
    e.id_equipo,
    e.nombre,
    v.total_victorias
ORDER BY
    [Porcentaje Victorias] DESC;