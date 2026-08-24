PRAGMA foreign_keys = ON;

-- Ejercicio 72: INSERT Nivel Intermedio
-- Datos de prueba para validar el tema INSERT.

-- 1. INSERT de una sola fila: se registra el primer equipo.
INSERT INTO equipos (nombre_equipo, region) VALUES
    ('Dragones del Norte', 'Norte');

-- 2. INSERT multiple: el resto de los equipos.
INSERT INTO equipos (nombre_equipo, region) VALUES
    ('Lobos del Sur', 'Sur'),
    ('Halcones del Centro', 'Centro'),
    ('Tigres del Oeste', 'Oeste');

-- 3. INSERT multiple de jugadores, con todas las columnas explicitas.
INSERT INTO jugadores (nombre, id_equipo) VALUES
    ('Kevin Us', 1),
    ('Diana Perez', 1),
    ('Oscar Tzul', 2),
    ('Melissa Ordonez', 3),
    ('Sergio Batz', 4);

-- 4. INSERT multiple de la jornada 1 (partidas de ida), con puntaje y
-- estado explicitos.
INSERT INTO partidas (id_equipo_local, id_equipo_visitante, fecha_partida, puntaje_local, puntaje_visitante, estado) VALUES
    (1, 2, '2026-08-01', 3, 1, 'jugada'),
    (3, 4, '2026-08-02', 2, 2, 'jugada');

-- 5. INSERT ... SELECT: se arma automaticamente la jornada 2 (partidas
-- de vuelta) a partir de la jornada 1 ya jugada, invirtiendo local y
-- visitante y moviendo la fecha una semana despues. No se escriben
-- puntaje_local, puntaje_visitante ni estado: quedan en su DEFAULT
-- (0, 0, 'programada') porque esos partidos todavia no se han jugado.
INSERT INTO partidas (id_equipo_local, id_equipo_visitante, fecha_partida)
SELECT id_equipo_visitante, id_equipo_local, date(fecha_partida, '+7 days')
FROM partidas
WHERE estado = 'jugada';

-- Casos comentados que deben fallar (no ser recomendables), dejar
-- comentados:

-- 1) Registro repetido: nombre_equipo ya existe, viola el UNIQUE.
-- INSERT INTO equipos (nombre_equipo, region) VALUES ('Dragones del Norte', 'Centro');

-- 2) Relacion invalida: id_equipo = 99 no existe, viola el FOREIGN KEY.
-- INSERT INTO jugadores (nombre, id_equipo) VALUES ('Jugador Fantasma', 99);

-- 3) Valor fuera de rango: estado con un valor que no esta en la
-- lista permitida, viola el CHECK.
-- INSERT INTO partidas (id_equipo_local, id_equipo_visitante, fecha_partida, estado) VALUES (1, 3, '2026-08-15', 'suspendida');
