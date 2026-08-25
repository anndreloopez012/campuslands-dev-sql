PRAGMA foreign_keys = ON;

-- Ejercicio 087: Club Futbol Sala
-- Datos base: 3 equipos, 6 jugadores, 3 partidos (2 finalizados, 1
-- marcado finalizado por error que se corrige despues) y sus goles y
-- tarjetas (incluye 1 gol y 1 tarjeta cargados por error en el
-- partido que se suspende).

INSERT INTO equipos (nombre_equipo, categoria) VALUES
    ('Halcones FS', 'Primera Division'),
    ('Titanes FS', 'Primera Division'),
    ('Rayos FS', 'Primera Division');

INSERT INTO jugadores (nombre_jugador, id_equipo, numero_camiseta) VALUES
    ('Kevin Us', 1, 7),
    ('Oscar Tzul', 1, 10),
    ('Melissa Ordonez', 2, 9),
    ('Sergio Batz', 2, 11),
    ('Diana Perez', 3, 5),
    ('Mario Ixtabalan', 3, 4);

-- Partido 1: Halcones (local) vs Titanes (visitante), finalizado.
INSERT INTO partidos (id_equipo_local, id_equipo_visitante, fecha_partido, estado) VALUES
    (1, 2, '2026-08-01', 'finalizado');

-- Partido 2: Titanes (local) vs Rayos (visitante), finalizado.
INSERT INTO partidos (id_equipo_local, id_equipo_visitante, fecha_partido, estado) VALUES
    (2, 3, '2026-08-03', 'finalizado');

-- Partido 3: Halcones vs Rayos. Se marco 'finalizado' y se cargaron
-- gol y tarjeta, pero se corto la luz de la cancha y el partido se
-- suspendio despues. Se corrige en dml/operaciones.sql.
INSERT INTO partidos (id_equipo_local, id_equipo_visitante, fecha_partido, estado) VALUES
    (1, 3, '2026-08-05', 'finalizado');

-- Goles del partido 1: Kevin Us anota 2, Melissa Ordonez anota 1.
INSERT INTO goles (id_partido, id_jugador, minuto) VALUES
    (1, 1, 10),
    (1, 1, 25),
    (1, 3, 30);

-- Tarjeta del partido 1.
INSERT INTO tarjetas (id_partido, id_jugador, tipo_tarjeta, minuto) VALUES
    (1, 2, 'amarilla', 15);

-- Goles del partido 2: Melissa Ordonez anota 1, Diana Perez anota 2.
INSERT INTO goles (id_partido, id_jugador, minuto) VALUES
    (2, 3, 5),
    (2, 5, 20),
    (2, 5, 35);

-- Tarjetas del partido 2.
INSERT INTO tarjetas (id_partido, id_jugador, tipo_tarjeta, minuto) VALUES
    (2, 4, 'amarilla', 20),
    (2, 6, 'roja', 40);

-- Gol cargado por error para el partido 3, antes de saber que se
-- habia cortado la luz. Quedara huerfano cuando el partido se marque
-- 'suspendido' en dml/operaciones.sql, y se elimina ahi mismo.
INSERT INTO goles (id_partido, id_jugador, minuto) VALUES
    (3, 1, 8);

-- Tarjeta cargada por error para el mismo partido 3.
INSERT INTO tarjetas (id_partido, id_jugador, tipo_tarjeta, minuto) VALUES
    (3, 5, 'amarilla', 12);

-- Caso comentado que debe fallar (queda comentado): repetir el numero
-- de camiseta 7 en otro jugador de Halcones FS, exactamente el
-- problema que este UNIQUE esta disenado para evitar.
-- INSERT INTO jugadores (nombre_jugador, id_equipo, numero_camiseta) VALUES ('Jugador Nuevo', 1, 7);
