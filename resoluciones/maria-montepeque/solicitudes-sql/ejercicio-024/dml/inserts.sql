PRAGMA foreign_keys = ON;

-- Ejercicio 024: Liga Videojuego Futbol
-- Datos de prueba (una semana: 2026-08-10 a 2026-08-14).

INSERT INTO usuarios (nombre_usuario, email) VALUES
    ('jgamer23', 'jorge.gamer@correo.com'),
    ('rosafc', 'rosa.fc@correo.com'),
    ('tomasgol', 'tomas.gol@correo.com'),
    ('karladt', 'karla.dt@correo.com'),
    ('juliopro', 'julio.pro@correo.com');

INSERT INTO clubes (id_usuario, nombre_club, division) VALUES
    (1, 'Real Estelar', 'primera'),
    (2, 'Atletico Fenix', 'primera'),
    (3, 'Deportivo Trueno', 'segunda'),
    (4, 'Union Cometa', 'segunda'),
    (5, 'Sporting Nova', 'primera');

-- El partido 4 esta 'pendiente' con marcador 0-0 como valor temporal
-- (todavia no se juega); se corrige en dml/operaciones.sql. El partido 9
-- es una duplicada por error de digitacion (mismos clubes, jornada,
-- marcador y fecha que el partido 1): tambien se corrige en operaciones.
INSERT INTO partidos (id_club_local, id_club_visitante, jornada, goles_local, goles_visitante, fecha_partido, estado) VALUES
    (1, 2, 1, 3, 1, '2026-08-10 18:00', 'jugado'),
    (3, 4, 1, 2, 2, '2026-08-11 19:00', 'jugado'),
    (5, 1, 1, 0, 1, '2026-08-11 20:00', 'jugado'),
    (2, 3, 2, 0, 0, '2026-08-12 18:00', 'pendiente'),
    (4, 5, 2, 1, 1, '2026-08-13 19:00', 'jugado'),
    (1, 3, 2, 4, 0, '2026-08-13 20:00', 'jugado'),
    (2, 5, 1, 2, 2, '2026-08-10 19:00', 'jugado'),
    (4, 1, 2, 1, 3, '2026-08-14 18:30', 'jugado'),
    (1, 2, 1, 3, 1, '2026-08-10 18:00', 'jugado');

-- Caso comentado que debe fallar (no ser recomendable), dejar comentado:
-- un club no puede jugar contra si mismo, viola el CHECK de partidos.
-- INSERT INTO partidos (id_club_local, id_club_visitante, jornada, goles_local, goles_visitante) VALUES (1, 1, 3, 2, 1);
