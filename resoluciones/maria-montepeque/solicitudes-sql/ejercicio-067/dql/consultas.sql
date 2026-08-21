.headers on
.mode column

-- Ejercicio 067: Streaming Musica
-- Consultas que responden preguntas reales del cliente.

-- 1. Que registros principales existen: todas las reproducciones con
-- usuario y cancion.
SELECT r.id_reproduccion,
       u.nombre AS usuario,
       c.titulo AS cancion,
       c.genero,
       r.fecha_reproduccion
FROM reproducciones r
JOIN usuarios u ON u.id_usuario = r.id_usuario
JOIN canciones c ON c.id_cancion = r.id_cancion;

-- 2. Que registros estan activos o archivados.
SELECT id_playlist, nombre, estado
FROM playlists
ORDER BY estado;

-- 3. Que cancion tiene mas reproducciones (ranking de popularidad).
SELECT c.titulo AS cancion,
       COUNT(*) AS total_reproducciones
FROM reproducciones r
JOIN canciones c ON c.id_cancion = r.id_cancion
GROUP BY c.id_cancion
ORDER BY total_reproducciones DESC;

-- 4. Reproducciones ordenadas por fecha, de la mas reciente a la mas
-- antigua.
SELECT id_reproduccion, fecha_reproduccion
FROM reproducciones
ORDER BY fecha_reproduccion DESC;

-- 5. Reporte para decision de negocio: genero mas reproducido entre
-- usuarios premium, para decidir en que genero enfocar las
-- recomendaciones (GROUP BY + HAVING).
SELECT c.genero,
       COUNT(*) AS total_reproducciones
FROM reproducciones r
JOIN canciones c ON c.id_cancion = r.id_cancion
JOIN usuarios u ON u.id_usuario = r.id_usuario
WHERE u.plan = 'premium'
GROUP BY c.genero
HAVING COUNT(*) > 1
ORDER BY total_reproducciones DESC;
