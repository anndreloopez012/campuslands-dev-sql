.headers on
.mode column

-- Ejercicio 067: Streaming Musica
-- 1. Canciones por artista
SELECT c.titulo, c.duracion_seg, a.nombre AS artista FROM canciones c JOIN artistas a ON a.id = c.artista_id;

-- 2. Historial de reproducciones
SELECT r.id, r.usuario, c.titulo, a.nombre AS artista FROM reproducciones r JOIN canciones c ON c.id = r.cancion_id JOIN artistas a ON a.id = c.artista_id;

-- 3. Top canciones mas reproducidas
SELECT c.titulo, COUNT(r.id) AS total_reproducciones FROM reproducciones r JOIN canciones c ON c.id = r.cancion_id GROUP BY c.id, c.titulo ORDER BY total_reproducciones DESC;