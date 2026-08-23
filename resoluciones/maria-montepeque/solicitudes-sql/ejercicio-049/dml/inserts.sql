PRAGMA foreign_keys = ON;

-- Ejercicio 049: Liga Videojuego Futbol
-- Datos de prueba.

INSERT INTO usuarios (nombre_usuario, email) VALUES
    ('Player_Rayo', 'rayo@correo.com'),
    ('Player_Nova', 'nova@correo.com'),
    ('Player_Kael', 'kael@correo.com'),
    ('Player_Xiomara', 'xiomara@correo.com'),
    ('Player_Bruno', 'bruno@correo.com');

INSERT INTO clubes (nombre_club, liga) VALUES
    ('Real Boreal FC', 'laliga'),
    ('Manchester Azul', 'premier'),
    ('Juvenil Milan', 'seriea'),
    ('Bavaria United', 'bundesliga'),
    ('Atletico Sur', 'laliga'),
    ('London Rovers', 'premier');

INSERT INTO jornadas (numero_jornada, fecha_jornada, temporada) VALUES
    (1, '2026-08-01', 'Temporada 2026'),
    (2, '2026-08-08', 'Temporada 2026'),
    (3, '2026-08-15', 'Temporada 2026'),
    (4, '2026-08-22', 'Temporada 2026');

-- El partido 12 es un duplicado por error de digitacion (mismo
-- usuario, jornada, clubes, fecha y marcador que el partido 1): se
-- corrige en dml/operaciones.sql. El partido 9 se anulo por caida de
-- conexion antes de generar marcador (0-0, se borrara de forma
-- controlada). El partido 11 queda 'en_revision' sin resolver, para
-- mostrar un caso real de trabajo pendiente.
INSERT INTO partidos (id_usuario, id_jornada, club_usuario, club_rival, fecha_partido, goles_usuario, goles_rival, estado, fecha_ultimo_cambio) VALUES
    (1, 1, 1, 2, '2026-08-01', 3, 1, 'jugado', '2026-08-01'),
    (2, 1, 3, 4, '2026-08-01', 2, 2, 'jugado', '2026-08-01'),
    (3, 1, 5, 6, '2026-08-02', 0, 4, 'jugado', '2026-08-02'),
    (1, 2, 1, 3, '2026-08-08', 5, 0, 'jugado', '2026-08-08'),
    (4, 2, 2, 4, '2026-08-08', 1, 1, 'jugado', '2026-08-08'),
    (2, 2, 3, 5, '2026-08-09', 3, 2, 'jugado', '2026-08-09'),
    (5, 3, 6, 1, '2026-08-15', 2, 2, 'en_revision', '2026-08-15'),
    (1, 3, 1, 4, '2026-08-16', 4, 3, 'jugado', '2026-08-16'),
    (3, 3, 5, 2, '2026-08-16', 0, 0, 'anulado', '2026-08-16'),
    (1, 4, 1, 5, '2026-08-22', 6, 2, 'jugado', '2026-08-22'),
    (2, 4, 3, 6, '2026-08-23', 1, 1, 'en_revision', '2026-08-23'),
    (1, 1, 1, 2, '2026-08-01', 3, 1, 'jugado', '2026-08-01');

-- Casos comentados que deben fallar (no ser recomendables), dejar
-- comentados:

-- 1) Registro repetido: numero_jornada ya existe, viola el UNIQUE.
-- INSERT INTO jornadas (numero_jornada, fecha_jornada, temporada) VALUES (2, '2026-08-29', 'Temporada 2026');

-- 2) Valor fuera de rango: goles_usuario negativo, viola el CHECK.
-- INSERT INTO partidos (id_usuario, id_jornada, club_usuario, club_rival, fecha_partido, goles_usuario, fecha_ultimo_cambio) VALUES (4, 4, 2, 6, '2026-08-24', -1, '2026-08-24');
