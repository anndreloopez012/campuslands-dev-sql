PRAGMA foreign_keys = ON;

-- Ejercicio 037: Club Futbol Sala
-- Datos de prueba.

INSERT INTO equipos (nombre_equipo, ciudad) VALUES
    ('Deportivo Real', 'Ciudad de Guatemala'),
    ('Tigres FS', 'Quetzaltenango'),
    ('Aguilas Rapidas', 'Antigua Guatemala'),
    ('Halcones del Sur', 'Escuintla'),
    ('Panteras Negras', 'Coban'),
    ('Titanes FS', 'Chimaltenango');

-- Todos los jugadores pertenecen al club propio (id_equipo = 1,
-- Deportivo Real); los demas equipos son los rivales que aparecen en
-- partidos.
INSERT INTO jugadores (nombre_jugador, posicion, id_equipo) VALUES
    ('Andres Vela', 'pivot', 1),
    ('Rodrigo Chuc', 'cierre', 1),
    ('Emilio Solares', 'ala', 1),
    ('Bryan Tuyuc', 'portero', 1),
    ('Diego Marroquin', 'pivot', 1);

-- El partido 10 es un duplicado por error de digitacion (mismo
-- jugador, rival, fecha, goles, tarjeta y estado que el partido 1):
-- se corrige en dml/operaciones.sql.
INSERT INTO partidos (id_jugador, id_equipo_rival, fecha_partido, goles, tarjeta, estado) VALUES
    (1, 2, '2026-08-02', 2, 'ninguna', 'jugado'),
    (2, 2, '2026-08-02', 0, 'amarilla', 'jugado'),
    (3, 3, '2026-08-09', 1, 'ninguna', 'jugado'),
    (1, 3, '2026-08-09', 0, 'amarilla', 'jugado'),
    (4, 4, '2026-08-16', 0, 'roja', 'jugado'),
    (5, 4, '2026-08-16', 1, 'ninguna', 'jugado'),
    (1, 4, '2026-08-16', 1, 'amarilla', 'jugado'),
    (2, 5, '2026-08-23', 0, 'ninguna', 'programado'),
    (3, 6, '2026-08-30', 0, 'ninguna', 'programado'),
    (1, 2, '2026-08-02', 2, 'ninguna', 'jugado');

-- Caso comentado que debe fallar (no ser recomendable), dejar comentado:
-- goles negativo, viola el CHECK de partidos.
-- INSERT INTO partidos (id_jugador, id_equipo_rival, fecha_partido, goles) VALUES (2, 3, '2026-09-01', -1);
