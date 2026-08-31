PRAGMA foreign_keys = ON;

-- Ejercicio 062: Club Futbol Sala
-- Datos base: 3 equipos, 9 jugadores, 4 partidos, 6 goles, 3 tarjetas.

INSERT INTO equipos (nombre) VALUES
    ('Halcones FS'),
    ('Tigres FS'),
    ('Panteras FS');

INSERT INTO jugadores (id_equipo, nombre, posicion, dorsal) VALUES
    (1, 'Mario Diaz', 'portero', 1),
    (1, 'Luis Gomez', 'defensa', 4),
    (1, 'Kevin Ramos', 'delantero', 9),
    (2, 'Pedro Lopez', 'portero', 1),
    (2, 'Andres Ruiz', 'medio', 8),
    (2, 'Diego Marroquin', 'delantero', 11),
    (3, 'Jorge Ical', 'portero', 1),
    (3, 'Hector Sazo', 'defensa', 5),
    (3, 'Oscar Choc', 'delantero', 10);

INSERT INTO partidos (id_equipo_local, id_equipo_visitante, fecha_partido, estado) VALUES
    (1, 2, '2026-08-10', 'finalizado'),
    (2, 3, '2026-08-12', 'finalizado'),
    (1, 3, '2026-08-15', 'en_curso'),
    (3, 1, '2026-08-20', 'programado');

-- goles: solo en partidos finalizados o en curso.
INSERT INTO goles (id_partido, id_jugador, minuto) VALUES
    (1, 3, 10),   -- Kevin Ramos (Halcones) vs Tigres
    (1, 3, 25),   -- Kevin Ramos (Halcones) vs Tigres
    (1, 6, 30),   -- Diego Marroquin (Tigres)
    (2, 6, 5),    -- Diego Marroquin (Tigres) vs Panteras
    (2, 9, 40),   -- Oscar Choc (Panteras)
    (2, 9, 45);   -- Oscar Choc (Panteras)

INSERT INTO tarjetas (id_partido, id_jugador, tipo, minuto) VALUES
    (1, 2, 'amarilla', 20),   -- Luis Gomez (Halcones)
    (3, 2, 'amarilla', 15),   -- Luis Gomez (Halcones), segundo partido
    (2, 8, 'amarilla', 35),   -- Hector Sazo (Panteras)
    (2, 5, 'roja', 50),       -- Andres Ruiz (Tigres)
    (2, 5, 'roja', 52);       -- registro duplicado por error (se corrige en operaciones.sql)

-- Caso que debe fallar (queda comentado): dos jugadores del mismo equipo
-- con el mismo dorsal viola UNIQUE (id_equipo, dorsal).
-- INSERT INTO jugadores (id_equipo, nombre, posicion, dorsal) VALUES (1, 'Duplicado', 'medio', 9);
