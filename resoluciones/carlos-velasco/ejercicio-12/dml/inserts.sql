PRAGMA foreign_keys = ON;

-- ARTISTAS

INSERT INTO artistas (
    id_artista,
    nombre,
    genero_principal,
    pais_origen,
    anio_inicio
) VALUES
(1, 'Luna Nova', 'Pop', 'Guatemala', 2015),
(2, 'Neon Waves', 'Electropop', 'Mexico', 2018),
(3, 'Aurora Beats', 'Electronica', 'Colombia', 2016),
(4, 'Solar Echo', 'Rock', 'Argentina', 2012),
(5, 'Midnight Sky', 'Indie', 'Espana', 2019);

-- ALBUMES

INSERT INTO albumes (
    id_album,
    id_artista,
    titulo,
    fecha_lanzamiento,
    cantidad_canciones
) VALUES
(1, 1, 'Horizonte', '2024-03-15', 5),
(2, 2, 'Ciudad Neon', '2024-06-20', 5),
(3, 3, 'Frecuencia', '2025-01-10', 5),
(4, 4, 'Ecos del Sol', '2023-09-05', 5),
(5, 5, 'Noches Abiertas', '2025-04-18', 5);

-- CANCIONES

INSERT INTO canciones (
    id_cancion,
    id_album,
    titulo,
    duracion_segundos,
    numero_pista
) VALUES
(1, 1, 'Primer Horizonte', 214, 1),
(2, 1, 'Luz de Ciudad', 198, 2),
(3, 1, 'Sin Gravedad', 245, 3),
(4, 1, 'Horizonte Final', 221, 4),
(5, 1, 'Nuevo Dia', 230, 5),
(6, 2, 'Ciudad Neon', 205, 1),
(7, 2, 'Luces de Medianoche', 232, 2),
(8, 2, 'Electricidad', 218, 3),
(9, 2, 'Ritmo Digital', 249, 4),
(10, 2, 'Ultima Conexion', 226, 5),
(11, 3, 'Frecuencia Uno', 310, 1),
(12, 3, 'Pulso', 275, 2),
(13, 3, 'Conexion', 292, 3),
(14, 3, 'Onda Corta', 260, 4),
(15, 3, 'Senal Abierta', 305, 5),
(16, 4, 'Ecos', 240, 1),
(17, 4, 'Sol de Invierno', 255, 2),
(18, 4, 'Kilometros', 280, 3),
(19, 4, 'Viento Sur', 265, 4),
(20, 4, 'Ultimo Refugio', 290, 5),
(21, 5, 'Noche Abierta', 210, 1),
(22, 5, 'Estrellas', 225, 2),
(23, 5, 'Despues de las Doce', 238, 3),
(24, 5, 'Ciudad Dormida', 250, 4),
(25, 5, 'Amanecer', 270, 5);

-- REPRODUCCIONES

INSERT INTO reproducciones (
    id_reproduccion,
    id_cancion,
    fecha_hora,
    dispositivo,
    segundos_escuchados
) VALUES
(1, 1, '2026-08-20 08:10', 'Movil', 214),
(2, 2, '2026-08-20 09:15', 'Web', 198),
(3, 6, '2026-08-20 10:20', 'Desktop', 205),
(4, 7, '2026-08-20 11:05', 'Movil', 232),
(5, 11, '2026-08-20 12:30', 'Web', 310),
(6, 12, '2026-08-20 13:10', 'Movil', 275),
(7, 16, '2026-08-20 14:00', 'Desktop', 240),
(8, 21, '2026-08-20 15:25', 'Smart TV', 225),
(9, 1, '2026-08-20 16:40', 'Movil', 214),
(10, 6, '2026-08-20 17:15', 'Web', 205),
(11, 11, '2026-08-20 18:20', 'Desktop', 310),
(12, 21, '2026-08-20 19:30', 'Movil', 225),
(13, 3, '2026-08-20 20:10', 'Web', 245),
(14, 8, '2026-08-20 20:45', 'Movil', 218),
(15, 13, '2026-08-20 21:15', 'Desktop', 292);