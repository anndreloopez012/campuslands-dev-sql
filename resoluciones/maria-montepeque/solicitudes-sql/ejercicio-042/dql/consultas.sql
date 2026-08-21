.headers on
.mode column

-- Ejercicio 042: Streaming Musica
-- Consultas de validacion.

-- 1. Que registros principales existen (con JOIN triple: usuario,
--    cancion y artista).
SELECT
    r.id_reproduccion,
    u.nombre_usuario,
    c.titulo,
    a.nombre_artista,
    r.fecha_reproduccion,
    r.monto_regalia,
    r.estado
FROM reproducciones r
JOIN usuarios u ON u.id_usuario = r.id_usuario
JOIN canciones c ON c.id_cancion = r.id_cancion
JOIN artistas a ON a.id_artista = c.id_artista;

-- 2. Que reproducciones no estan contabilizadas todavia.
SELECT id_reproduccion, id_usuario, id_cancion, fecha_reproduccion, estado
FROM reproducciones
WHERE estado <> 'contabilizada';

-- 3. Que artista tiene mas reproducciones contabilizadas.
SELECT a.nombre_artista, COUNT(*) AS total_reproducciones
FROM artistas a
JOIN canciones c ON c.id_artista = a.id_artista
JOIN reproducciones r ON r.id_cancion = c.id_cancion
WHERE r.estado = 'contabilizada'
GROUP BY a.id_artista, a.nombre_artista
ORDER BY total_reproducciones DESC, a.nombre_artista;

-- 4. Reproducciones ordenadas por fecha.
SELECT u.nombre_usuario, c.titulo, r.fecha_reproduccion
FROM reproducciones r
JOIN usuarios u ON u.id_usuario = r.id_usuario
JOIN canciones c ON c.id_cancion = r.id_cancion
ORDER BY r.fecha_reproduccion;

-- 5. Cuanto dinero en regalias genera cada artista (solo
--    reproducciones contabilizadas), para decidir a quien pagar
--    primero.
SELECT a.nombre_artista, ROUND(SUM(r.monto_regalia), 4) AS total_regalias
FROM artistas a
JOIN canciones c ON c.id_artista = a.id_artista
JOIN reproducciones r ON r.id_cancion = c.id_cancion
WHERE r.estado = 'contabilizada'
GROUP BY a.id_artista, a.nombre_artista
ORDER BY total_regalias DESC, a.nombre_artista;
