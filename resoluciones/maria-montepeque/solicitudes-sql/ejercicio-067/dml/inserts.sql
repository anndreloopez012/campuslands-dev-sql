PRAGMA foreign_keys = ON;

-- Ejercicio 067: Streaming Musica
-- Datos base: 4 artistas, 6 canciones, 5 usuarios, 5 playlists,
-- 12 reproducciones (una de ellas duplicada por error).

INSERT INTO artistas (nombre) VALUES
    ('Bad Bunny'),
    ('Dua Lipa'),
    ('Daft Punk'),
    ('The Weeknd');

INSERT INTO canciones (id_artista, titulo, duracion_segundos, genero) VALUES
    (1, 'Titi Me Pregunto', 240, 'reggaeton'),
    (1, 'Callaita', 220, 'reggaeton'),
    (2, 'Levitating', 203, 'pop'),
    (2, 'Dont Start Now', 183, 'pop'),
    (3, 'One More Time', 320, 'electronica'),
    (4, 'Blinding Lights', 200, 'pop');

INSERT INTO usuarios (nombre, email, plan) VALUES
    ('Manuel Estrada', 'manuel.estrada@correo.com', 'gratuito'),
    ('Alejandra Chinchilla', 'alejandra.chinchilla@correo.com', 'premium'),
    ('Byron Xicay', 'byron.xicay@correo.com', 'premium'),
    ('Cristina Barrios', 'cristina.barrios@correo.com', 'gratuito'),
    ('Douglas Pineda', 'douglas.pineda@correo.com', 'premium');

INSERT INTO playlists (id_usuario, nombre) VALUES
    (1, 'Favoritas Manuel'),
    (2, 'Fiesta Alejandra'),
    (3, 'Entrenamiento Byron'),
    (4, 'Relax Cristina'),
    (2, 'Vieja playlist 2024');

INSERT INTO reproducciones (id_usuario, id_cancion, fecha_reproduccion) VALUES
    (1, 1, '2026-08-01 08:00'),
    (2, 3, '2026-08-01 09:00'),
    (3, 5, '2026-08-01 10:00'),
    (4, 6, '2026-08-02 11:00'),
    (5, 4, '2026-08-02 12:00'),
    (2, 3, '2026-08-03 09:00'),
    (3, 5, '2026-08-03 10:00'),
    (5, 6, '2026-08-04 08:00'),
    (2, 6, '2026-08-04 09:00'),
    (1, 2, '2026-08-05 08:00'),
    (3, 5, '2026-08-05 10:00'),
    (3, 5, '2026-08-05 10:00');
-- La ultima reproduccion es un duplicado exacto (mismo usuario, cancion
-- y fecha/hora), registrado por error al reintentar la peticion. Se
-- corrige en operaciones.sql.

-- Caso que debe fallar (queda comentado): un segundo artista con el
-- mismo nombre viola UNIQUE (artistas.nombre).
-- INSERT INTO artistas (nombre) VALUES ('Bad Bunny');
