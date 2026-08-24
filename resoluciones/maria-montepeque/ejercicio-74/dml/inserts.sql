PRAGMA foreign_keys = ON;

-- Ejercicio 74: UPDATE Nivel Basico
-- Datos de prueba y UPDATE de validacion.

INSERT INTO equipos (nombre_equipo, region) VALUES
    ('Dragones del Norte', 'Norte'),
    ('Lobos del Sur', 'Sur'),
    ('Halcones del Centro', 'Centro'),
    ('Tigres del Oeste', 'Oeste');

INSERT INTO jugadores (nombre, id_equipo) VALUES
    ('Kevin Us', 1),
    ('Oscar Tzul', 2),
    ('Melissa Ordonez', 3),
    ('Sergio Batz', 4);

-- Las 4 partidas nacen todas 'programada' con puntaje 0-0 (el DEFAULT
-- de la tabla). Los UPDATE de abajo son los que las mueven a su
-- estado y resultado real, uno por uno.
INSERT INTO partidas (id_equipo_local, id_equipo_visitante, fecha_partida) VALUES
    (1, 2, '2026-08-01'),
    (3, 4, '2026-08-01'),
    (2, 1, '2026-08-08'),
    (4, 3, '2026-08-08');

-- 1. UPDATE de una sola fila: llega el resultado de la partida 1 con
-- WHERE por id_partida.
UPDATE partidas
SET puntaje_local = 3, puntaje_visitante = 1, estado = 'jugada'
WHERE id_partida = 1;

-- 2. UPDATE de una sola fila: llega el resultado de la partida 2.
UPDATE partidas
SET puntaje_local = 2, puntaje_visitante = 2, estado = 'jugada'
WHERE id_partida = 2;

-- 3. UPDATE multiple: las partidas 3 y 4 se cancelan juntas por un
-- problema con el estadio, con un solo UPDATE y un WHERE con IN.
UPDATE partidas
SET estado = 'cancelada'
WHERE id_partida IN (3, 4);

-- 4. UPDATE con expresion (no un valor fijo): la revision en video
-- anula un gol que ya se habia contado de mas para el equipo local de
-- la partida 1. En vez de escribir el numero final a mano, se resta 1
-- al valor que ya tenia la columna.
UPDATE partidas
SET puntaje_local = puntaje_local - 1
WHERE id_partida = 1 AND puntaje_local > 0;

-- Caso comentado que debe fallar (no ser recomendable), dejar
-- comentado: un estado que no esta en la lista permitida viola el
-- CHECK.
-- UPDATE partidas SET estado = 'suspendida' WHERE id_partida = 1;

-- Nota sobre buenas practicas (no se ejecuta): un UPDATE sin WHERE
-- modificaria las 4 partidas a la vez, incluidas las que no debian
-- cambiar. Por eso cada UPDATE de este archivo usa una condicion
-- especifica (WHERE id_partida = ... o WHERE id_partida IN (...)).
