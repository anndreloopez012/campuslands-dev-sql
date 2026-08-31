PRAGMA foreign_keys = ON;

-- Ejercicio 017: Streaming Musica
INSERT INTO reproducciones (cancion_id, usuario, fecha) VALUES (1, 'User_03', '2026-08-22');

UPDATE canciones SET duracion_seg = 325 WHERE id = 1;

DELETE FROM artistas WHERE id = 2 AND NOT EXISTS (SELECT 1 FROM canciones WHERE artista_id = artistas.id);