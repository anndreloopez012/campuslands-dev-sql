-- Ejercicio 06: Torneo Esports
-- Operaciones sobre los datos base

-- 2 INSERT adicionales
INSERT INTO equipos (nombre) VALUES
    ('Aguilas Doradas');

INSERT INTO resultados (id_partida, id_jugador, kills, muertes, puntos) VALUES
    (6, 1, 16, 15, 68);

-- 2 UPDATE validos
UPDATE resultados
SET kills = 26, puntos = 98
WHERE id_resultado = 3;

UPDATE jugadores
SET rol = 'entry'
WHERE id_jugador = 4;

-- 2 DELETE controlados con WHERE
DELETE FROM resultados
WHERE id_resultado = 11;

DELETE FROM resultados
WHERE puntos < 60;
