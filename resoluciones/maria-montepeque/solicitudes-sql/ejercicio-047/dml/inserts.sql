PRAGMA foreign_keys = ON;

-- Ejercicio 047: Liga MOBA
-- Datos de prueba.

INSERT INTO equipos (nombre_equipo, region) VALUES
    ('Dragones Carmesi', 'LATAM'),
    ('Lobos del Norte', 'NA'),
    ('Fenix Electrico', 'EU'),
    ('Titanes Boreales', 'APAC'),
    ('Sombra Eterna', 'LATAM');

INSERT INTO heroes (nombre_heroe, rol) VALUES
    ('Grimtusk', 'tanque'),
    ('Vexara', 'asesino'),
    ('Lyrienne', 'soporte'),
    ('Kaidon', 'tirador'),
    ('Morvash', 'mago'),
    ('Threx', 'tanque');

-- Todos los jugadores pertenecen a Dragones Carmesi (id_equipo = 1);
-- los demas equipos son los rivales que aparecen en partidas.
INSERT INTO jugadores (nombre_jugador, id_equipo, posicion) VALUES
    ('NovaBlade', 1, 'carril_medio'),
    ('IronWisp', 1, 'jungla'),
    ('SolaraFX', 1, 'carril_superior'),
    ('ZephyrDash', 1, 'tirador'),
    ('MysticVale', 1, 'soporte');

-- La partida 11 es un duplicado por error de digitacion (mismo
-- jugador, heroe, rival, fecha y estadisticas que la partida 1): se
-- corrige en dml/operaciones.sql. La partida 9 se anulo por una
-- desconexion del servidor antes de que empezara el combate (por eso
-- kills = deaths = assists = 0); la partida 7 nace 'en_revision' por
-- estadisticas sospechosas.
INSERT INTO partidas (id_jugador, id_heroe, id_equipo_rival, fecha_partida, kills, deaths, assists, resultado, estado) VALUES
    (1, 2, 2, '2026-08-01', 8, 2, 5, 'victoria', 'valida'),
    (2, 1, 2, '2026-08-01', 2, 3, 10, 'victoria', 'valida'),
    (3, 6, 3, '2026-08-03', 5, 4, 3, 'derrota', 'valida'),
    (4, 4, 3, '2026-08-03', 10, 1, 4, 'derrota', 'valida'),
    (1, 5, 4, '2026-08-06', 12, 2, 6, 'victoria', 'valida'),
    (5, 3, 4, '2026-08-06', 0, 1, 15, 'victoria', 'valida'),
    (2, 1, 5, '2026-08-09', 3, 5, 2, 'derrota', 'en_revision'),
    (3, 6, 2, '2026-08-11', 6, 3, 4, 'victoria', 'valida'),
    (4, 4, 5, '2026-08-13', 0, 0, 0, 'derrota', 'anulada'),
    (1, 2, 3, '2026-08-15', 9, 1, 7, 'victoria', 'valida'),
    (1, 2, 2, '2026-08-01', 8, 2, 5, 'victoria', 'valida');

-- Casos comentados que deben fallar (no ser recomendables), dejar
-- comentados:

-- 1) Registro repetido: nombre_heroe ya existe, viola el UNIQUE.
-- INSERT INTO heroes (nombre_heroe, rol) VALUES ('Grimtusk', 'mago');

-- 2) Valor fuera de rango: resultado no valido, viola el CHECK.
-- INSERT INTO partidas (id_jugador, id_heroe, id_equipo_rival, fecha_partida, resultado) VALUES (5, 3, 2, '2026-08-17', 'empate');
