PRAGMA foreign_keys = ON;

-- Ejercicio 074: Liga Videojuego Futbol
-- Datos base: 4 usuarios, 4 clubes, 2 jornadas, 4 partidos (2 jugados
-- de la jornada 1, 1 jugado-por-error de la jornada 1 que se corrige
-- despues, y 1 programado de la jornada 2), y los goles de los
-- partidos jugados.

INSERT INTO usuarios (nombre_usuario, email) VALUES
    ('jugador_karla', 'karla@correo.com'),
    ('jugador_bryan', 'bryan@correo.com'),
    ('jugador_fernanda', 'fernanda@correo.com'),
    ('jugador_jorge', 'jorge@correo.com');

INSERT INTO clubes (nombre_club, liga) VALUES
    ('Real Pixel', 'Liga Digital'),
    ('Atletico Bit', 'Liga Digital'),
    ('Union Byte', 'Liga Digital'),
    ('Deportivo Codigo', 'Liga Digital');

INSERT INTO jornadas (numero_jornada, fecha_inicio, fecha_fin) VALUES
    (1, '2026-08-01', '2026-08-07'),
    (2, '2026-08-08', '2026-08-14');

-- Partido 1: Karla (Real Pixel, local) vs Bryan (Atletico Bit,
-- visitante), jornada 1, jugado.
INSERT INTO partidos (id_jornada, id_usuario_local, id_club_local, id_usuario_visitante, id_club_visitante, fecha_partido, estado) VALUES
    (1, 1, 1, 2, 2, '2026-08-02', 'jugado');

-- Partido 2: Fernanda (Union Byte, local) vs Jorge (Deportivo
-- Codigo, visitante), jornada 1, jugado.
INSERT INTO partidos (id_jornada, id_usuario_local, id_club_local, id_usuario_visitante, id_club_visitante, fecha_partido, estado) VALUES
    (1, 3, 3, 4, 4, '2026-08-03', 'jugado');

-- Partido 3: Karla (Real Pixel, local) vs Fernanda (Union Byte,
-- visitante), jornada 1. Se cargo como 'jugado' con un gol, pero el
-- servidor del videojuego se desconecto a la mitad y el resultado se
-- anulo despues. Se corrige el estado con UPDATE en
-- dml/operaciones.sql.
INSERT INTO partidos (id_jornada, id_usuario_local, id_club_local, id_usuario_visitante, id_club_visitante, fecha_partido, estado) VALUES
    (1, 1, 1, 3, 3, '2026-08-04', 'jugado');

-- Partido 4: jornada 2, todavia no se juega.
INSERT INTO partidos (id_jornada, id_usuario_local, id_club_local, id_usuario_visitante, id_club_visitante, fecha_partido, estado) VALUES
    (2, 2, 2, 4, 4, '2026-08-09', 'programado');

-- Goles del partido 1: Real Pixel 3, Atletico Bit 1.
INSERT INTO goles (id_partido, id_club, minuto) VALUES
    (1, 1, 12),
    (1, 1, 45),
    (1, 1, 78),
    (1, 2, 60);

-- Goles del partido 2: Union Byte 2, Deportivo Codigo 2.
INSERT INTO goles (id_partido, id_club, minuto) VALUES
    (2, 3, 10),
    (2, 3, 30),
    (2, 4, 20),
    (2, 4, 55);

-- Gol cargado por error para el partido 3, antes de saber que el
-- servidor se habia caido. Quedara huerfano cuando el partido se
-- marque 'cancelado' en dml/operaciones.sql, y se elimina ahi mismo.
INSERT INTO goles (id_partido, id_club, minuto) VALUES
    (3, 1, 5);

-- Casos comentados que deben fallar (no ser recomendables), dejar
-- comentados:

-- 1) Registro repetido: numero_jornada ya existe, viola el UNIQUE.
-- INSERT INTO jornadas (numero_jornada, fecha_inicio, fecha_fin) VALUES (1, '2026-08-15', '2026-08-21');

-- 2) Relacion invalida: id_club = 99 no existe, viola el FOREIGN KEY.
-- INSERT INTO goles (id_partido, id_club, minuto) VALUES (1, 99, 30);

-- 3) Valor fuera de rango: minuto mayor a 120, viola el CHECK.
-- INSERT INTO goles (id_partido, id_club, minuto) VALUES (2, 3, 130);
