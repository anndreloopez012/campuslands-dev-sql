INSERT INTO artistas (id_artista, nombre, genero_principal, pais_origen)
VALUES
    (6, 'Echo Nova', 'Indie Pop', 'Canada');

INSERT INTO albumes (id_album, id_artista, titulo, fecha_lanzamiento)
VALUES
    (6, 6, 'Midnight Echoes', '2025-02-14');

UPDATE canciones
SET duracion_segundos = 220
WHERE id_cancion = 1;

UPDATE artistas
SET genero_principal = 'Electropop Alternativo'
WHERE id_artista = 1;

DELETE FROM reproducciones
WHERE id_reproduccion = 9;

DELETE FROM reproducciones
WHERE id_reproduccion = 10;

-- Operación inválida: viola UNIQUE en artistas.nombre
-- INSERT INTO artistas (id_artista, nombre, genero_principal, pais_origen)
-- VALUES (7, 'Aurora Digital', 'Pop', 'Suecia');

-- Operación inválida: viola FOREIGN KEY en albumes.id_artista
-- INSERT INTO albumes (id_album, id_artista, titulo, fecha_lanzamiento)
-- VALUES (7, 999, 'Album Invalido', '2026-08-20');