PRAGMA foreign_keys = ON;

-- 1. LISTAR TODOS LOS REGISTROS DE LA ENTIDAD CENTRAL

SELECT
    id_reproduccion,
    id_cancion,
    fecha_hora,
    dispositivo,
    segundos_escuchados
FROM reproducciones;

-- 2. MOSTRAR DOS COLUMNAS RELEVANTES

SELECT
    fecha_hora,
    dispositivo
FROM reproducciones;

-- 3. FILTRAR REPRODUCCIONES POR FECHA

SELECT
    id_reproduccion,
    id_cancion,
    fecha_hora,
    segundos_escuchados
FROM reproducciones
WHERE fecha_hora >= '2026-08-20 18:00';

-- 4. ORDENAR REPRODUCCIONES POR FECHA

SELECT
    id_reproduccion,
    fecha_hora,
    segundos_escuchados
FROM reproducciones
ORDER BY fecha_hora ASC;

-- 5. CINCO CANCIONES CON MAYOR CANTIDAD DE REPRODUCCIONES

SELECT
    c.id_cancion,
    c.titulo,
    COUNT(r.id_reproduccion) AS total_reproducciones
FROM canciones AS c
INNER JOIN reproducciones AS r
    ON r.id_cancion = c.id_cancion
GROUP BY
    c.id_cancion,
    c.titulo
ORDER BY total_reproducciones DESC, c.titulo ASC
LIMIT 5;

-- 6. CONTAR REPRODUCCIONES TOTALES

SELECT
    COUNT(*) AS total_reproducciones
FROM reproducciones;

-- 7. PROMEDIO, MINIMO Y MAXIMO DE TIEMPO ESCUCHADO

SELECT
    ROUND(AVG(segundos_escuchados), 2) AS promedio_segundos,
    MIN(segundos_escuchados) AS minimo_segundos,
    MAX(segundos_escuchados) AS maximo_segundos
FROM reproducciones;

-- 8. AGRUPAR REPRODUCCIONES POR DISPOSITIVO

SELECT
    dispositivo,
    COUNT(*) AS total_reproducciones
FROM reproducciones
GROUP BY dispositivo
ORDER BY total_reproducciones DESC;

-- 9. RELACIONAR CANCIONES Y ALBUMES

SELECT
    c.titulo AS cancion,
    a.titulo AS album,
    c.duracion_segundos,
    c.numero_pista
FROM canciones AS c
INNER JOIN albumes AS a
    ON a.id_album = c.id_album
ORDER BY a.titulo, c.numero_pista;

-- 10. WHERE, ORDER BY Y LIMIT

SELECT
    id_reproduccion,
    id_cancion,
    fecha_hora,
    segundos_escuchados
FROM reproducciones
WHERE segundos_escuchados >= 220
ORDER BY segundos_escuchados DESC
LIMIT 5;

-- 11. REPORTE CON ALIAS LEGIBLES

SELECT
    r.id_reproduccion AS "ID Reproduccion",
    c.titulo AS "Cancion",
    a.titulo AS "Album",
    ar.nombre AS "Artista",
    r.fecha_hora AS "Fecha y Hora",
    r.dispositivo AS "Dispositivo",
    r.segundos_escuchados AS "Segundos Escuchados"
FROM reproducciones AS r
INNER JOIN canciones AS c
    ON c.id_cancion = r.id_cancion
INNER JOIN albumes AS a
    ON a.id_album = c.id_album
INNER JOIN artistas AS ar
    ON ar.id_artista = a.id_artista
ORDER BY r.fecha_hora ASC;

-- 12. DECISION DE NEGOCIO: ARTISTAS CON MAYOR DEMANDA

SELECT
    ar.nombre AS "Artista",
    COUNT(r.id_reproduccion) AS "Reproducciones",
    COUNT(DISTINCT c.id_cancion) AS "Canciones Escuchadas",
    ROUND(AVG(r.segundos_escuchados), 2) AS "Promedio Segundos",
    CASE
        WHEN COUNT(r.id_reproduccion) >= 5 THEN 'Priorizar promocion'
        WHEN COUNT(r.id_reproduccion) >= 3 THEN 'Mantener promocion'
        ELSE 'Evaluar promocion'
    END AS "Decision"
FROM artistas AS ar
INNER JOIN albumes AS a
    ON a.id_artista = ar.id_artista
INNER JOIN canciones AS c
    ON c.id_album = a.id_album
LEFT JOIN reproducciones AS r
    ON r.id_cancion = c.id_cancion
GROUP BY
    ar.id_artista,
    ar.nombre
ORDER BY Reproducciones DESC;