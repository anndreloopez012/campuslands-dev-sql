INSERT INTO artistas (id_artista, nombre, genero_principal, pais_origen)
VALUES
    (1, 'Aurora Digital', 'Electropop', 'Noruega'),
    (2, 'Neon Waves', 'Synthpop', 'Estados Unidos'),
    (3, 'Luna Stereo', 'Pop', 'Colombia'),
    (4, 'Pixel Sound', 'Electronic', 'Reino Unido'),
    (5, 'Solar Beats', 'Dance', 'España');

INSERT INTO albumes (id_album, id_artista, titulo, fecha_lanzamiento)
VALUES
    (1, 1, 'Northern Lights', '2023-03-15'),
    (2, 2, 'Electric Dreams', '2022-08-20'),
    (3, 3, 'Horizonte', '2024-01-12'),
    (4, 4, 'Digital Pulse', '2021-11-05'),
    (5, 5, 'Energia Solar', '2023-07-28');

INSERT INTO canciones (id_cancion, id_album, titulo, duracion_segundos, numero_pista)
VALUES
    (1, 1, 'Frozen Sky', 214, 1),
    (2, 2, 'Electric Heart', 245, 1),
    (3, 3, 'Nuevo Horizonte', 198, 1),
    (4, 4, 'Digital World', 276, 1),
    (5, 5, 'Solar Energy', 231, 1);

INSERT INTO reproducciones (id_reproduccion, id_cancion, fecha_reproduccion, segundos_reproducidos, dispositivo)
VALUES
    (1, 1, '2026-08-01 08:30', 214, 'Movil'),
    (2, 2, '2026-08-02 10:15', 245, 'Computador'),
    (3, 3, '2026-08-03 12:45', 198, 'Tablet'),
    (4, 4, '2026-08-04 15:20', 276, 'Movil'),
    (5, 5, '2026-08-05 18:10', 231, 'Smart TV'),
    (6, 1, '2026-08-06 09:00', 214, 'Computador'),
    (7, 2, '2026-08-07 11:30', 245, 'Movil'),
    (8, 3, '2026-08-08 14:00', 198, 'Movil'),
    (9, 4, '2026-08-09 19:45', 276, 'Tablet'),
    (10, 5, '2026-08-10 21:15', 231, 'Smart TV');