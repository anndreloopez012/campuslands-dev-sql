SELECT *
FROM canciones;

SELECT titulo, duracion_segundos
FROM canciones;

SELECT *
FROM canciones
WHERE duracion_segundos > 220;

SELECT *
FROM canciones
ORDER BY titulo ASC;

SELECT
    c.titulo,
    COUNT(r.id_reproduccion) AS total_reproducciones
FROM canciones c
LEFT JOIN reproducciones r
    ON c.id_cancion = r.id_cancion
GROUP BY c.id_cancion, c.titulo
ORDER BY total_reproducciones DESC
LIMIT 5;

SELECT COUNT(*) AS total_reproducciones
FROM reproducciones;

SELECT
    AVG(duracion_segundos) AS duracion_promedio,
    MIN(duracion_segundos) AS duracion_minima,
    MAX(duracion_segundos) AS duracion_maxima
FROM canciones;

SELECT
    dispositivo,
    COUNT(*) AS cantidad_reproducciones
FROM reproducciones
GROUP BY dispositivo
ORDER BY cantidad_reproducciones DESC;

SELECT
    c.titulo AS cancion,
    a.nombre AS artista,
    al.titulo AS album,
    c.duracion_segundos
FROM canciones c
JOIN albumes al
    ON c.id_album = al.id_album
JOIN artistas a
    ON al.id_artista = a.id_artista
ORDER BY a.nombre, c.titulo;

SELECT
    id_reproduccion,
    id_cancion,
    fecha_reproduccion,
    dispositivo
FROM reproducciones
WHERE segundos_reproducidos >= 200
ORDER BY fecha_reproduccion DESC
LIMIT 5;

SELECT
    a.nombre AS artista,
    al.titulo AS album,
    c.titulo AS cancion,
    COUNT(r.id_reproduccion) AS reproducciones
FROM artistas a
JOIN albumes al
    ON a.id_artista = al.id_artista
JOIN canciones c
    ON al.id_album = c.id_album
LEFT JOIN reproducciones r
    ON c.id_cancion = r.id_cancion
GROUP BY a.id_artista, a.nombre, al.id_album, al.titulo, c.id_cancion, c.titulo
ORDER BY reproducciones DESC;

SELECT
    c.titulo AS cancion,
    a.nombre AS artista,
    COUNT(r.id_reproduccion) AS reproducciones,
    CASE
        WHEN COUNT(r.id_reproduccion) >= 2 THEN 'Priorizar promocion'
        ELSE 'Mantener en catalogo'
    END AS decision
FROM canciones c
JOIN albumes al
    ON c.id_album = al.id_album
JOIN artistas a
    ON al.id_artista = a.id_artista
LEFT JOIN reproducciones r
    ON c.id_cancion = r.id_cancion
GROUP BY c.id_cancion, c.titulo, a.nombre
ORDER BY reproducciones DESC;