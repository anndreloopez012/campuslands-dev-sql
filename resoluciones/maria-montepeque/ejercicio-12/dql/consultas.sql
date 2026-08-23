-- Ejercicio 12: Streaming Musica
-- Entidad central: reproducciones

-- 1. Listar todos los registros principales de la entidad central
SELECT * FROM reproducciones;

-- 2. Mostrar solo dos columnas relevantes
SELECT usuario, fecha_hora FROM reproducciones;

-- 3. Filtrar registros por una condicion de fecha
SELECT * FROM reproducciones WHERE fecha_hora >= '2026-08-03';

-- 4. Ordenar resultados por fecha
SELECT * FROM reproducciones ORDER BY fecha_hora;

-- 5. Mostrar las 5 reproducciones mas recientes
SELECT * FROM reproducciones ORDER BY fecha_hora DESC LIMIT 5;

-- 6. Contar registros totales
SELECT COUNT(*) AS total_reproducciones FROM reproducciones;

-- 7. Promedio, minimo y maximo de duracion de las canciones
SELECT
    AVG(duracion_segundos) AS promedio_duracion,
    MIN(duracion_segundos) AS minima_duracion,
    MAX(duracion_segundos) AS maxima_duracion
FROM canciones;

-- 8. Agrupar reproducciones por dispositivo
SELECT dispositivo, COUNT(*) AS cantidad
FROM reproducciones
GROUP BY dispositivo;

-- 9. Relacionar reproducciones y canciones con JOIN
SELECT r.id_reproduccion, c.titulo, r.usuario, r.fecha_hora
FROM reproducciones r
JOIN canciones c ON c.id_cancion = r.id_cancion;

-- 10. WHERE + ORDER BY + LIMIT
SELECT * FROM reproducciones
WHERE dispositivo = 'movil'
ORDER BY fecha_hora
LIMIT 3;

-- 11. Reporte con alias legibles
SELECT
    ar.nombre AS artista,
    al.titulo AS album,
    c.titulo AS cancion,
    r.usuario AS usuario,
    r.fecha_hora AS fecha,
    r.dispositivo AS dispositivo
FROM reproducciones r
JOIN canciones c ON c.id_cancion = r.id_cancion
JOIN albumes al ON al.id_album = c.id_album
JOIN artistas ar ON ar.id_artista = al.id_artista;

-- 12. Consulta para decision de negocio: cancion mas reproducida
SELECT c.titulo, COUNT(*) AS total_reproducciones
FROM reproducciones r
JOIN canciones c ON c.id_cancion = r.id_cancion
GROUP BY c.titulo
ORDER BY total_reproducciones DESC
LIMIT 1;
