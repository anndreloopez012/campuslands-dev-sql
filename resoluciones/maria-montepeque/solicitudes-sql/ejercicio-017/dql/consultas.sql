.headers on
.mode column

-- Ejercicio 017: Streaming Musica
-- Consultas de validacion.

-- 1. Que registros principales existen.
SELECT * FROM canciones;

-- 2. Que canciones no estan disponibles.
SELECT id_cancion, titulo, id_artista, estado
FROM canciones
WHERE estado <> 'disponible';

-- 3. Que artista tiene mas canciones en el catalogo.
SELECT a.nombre_artista, COUNT(*) AS total_canciones
FROM artistas a
JOIN canciones c ON c.id_artista = a.id_artista
GROUP BY a.id_artista, a.nombre_artista
ORDER BY total_canciones DESC;

-- 4. Canciones ordenadas por fecha de lanzamiento.
SELECT id_cancion, titulo, fecha_lanzamiento, estado
FROM canciones
ORDER BY fecha_lanzamiento;

-- 5. Duracion total de contenido por artista, para armar playlists o
--    decisiones de programacion.
SELECT
    a.nombre_artista,
    a.genero_principal,
    SUM(c.duracion_segundos) AS duracion_total_segundos
FROM artistas a
JOIN canciones c ON c.id_artista = a.id_artista
GROUP BY a.id_artista, a.nombre_artista, a.genero_principal
ORDER BY duracion_total_segundos DESC;
