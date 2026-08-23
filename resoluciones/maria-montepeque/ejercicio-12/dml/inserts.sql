-- Ejercicio 12: Streaming Musica
-- Datos base: 5 artistas, 5 albumes, 5 canciones, 10 reproducciones

INSERT INTO artistas (nombre, pais) VALUES
    ('Los Andes', 'Guatemala'),
    ('Mariana Sol', 'Mexico'),
    ('Ritmo Urbano', 'Colombia'),
    ('Voces del Sur', 'Argentina'),
    ('Neon Beat', 'Estados Unidos');

INSERT INTO albumes (id_artista, titulo, anio_lanzamiento) VALUES
    (1, 'Raices', 2019),
    (2, 'Luz de Luna', 2021),
    (3, 'Calle Viva', 2020),
    (4, 'Horizonte', 2022),
    (5, 'Pixel', 2023);

INSERT INTO canciones (id_album, titulo, duracion_segundos, genero) VALUES
    (1, 'Amanecer', 210, 'Folk'),
    (2, 'Suspiro', 195, 'Pop'),
    (3, 'Barrio Alto', 180, 'Reggaeton'),
    (4, 'Camino Largo', 240, 'Rock'),
    (5, 'Circuito', 205, 'Electronica');

INSERT INTO reproducciones (id_cancion, usuario, fecha_hora, dispositivo) VALUES
    (1, 'usuario01', '2026-08-01 08:00', 'movil'),
    (2, 'usuario02', '2026-08-01 09:15', 'web'),
    (3, 'usuario03', '2026-08-01 10:30', 'movil'),
    (4, 'usuario04', '2026-08-02 07:45', 'escritorio'),
    (5, 'usuario05', '2026-08-02 11:00', 'tablet'),
    (1, 'usuario02', '2026-08-02 12:20', 'movil'),
    (3, 'usuario01', '2026-08-03 06:50', 'web'),
    (3, 'usuario04', '2026-08-03 14:10', 'movil'),
    (5, 'usuario03', '2026-08-03 18:30', 'movil'),
    (2, 'usuario05', '2026-08-04 09:00', 'escritorio');
