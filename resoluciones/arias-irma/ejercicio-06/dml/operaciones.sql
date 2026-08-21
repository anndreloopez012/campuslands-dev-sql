
PRAGMA foreign_keys = ON;

-- 2 operaciones INSERT adicionales
INSERT INTO equipos (nombre, region, anio_fundacion) VALUES ('KRÜ Esports', 'Latinoamérica', 2020);
INSERT INTO jugadores (equipo_id, gamertag, rol, edad) VALUES (6, 'Klaus', 'Centinela', 25);

-- 2 operaciones UPDATE
UPDATE equipos SET region = 'América del Norte' WHERE id = 1;
UPDATE jugadores SET rol = 'Flex' WHERE id = 1;

-- 2 operaciones DELETE controladas
DELETE FROM jugadores WHERE id = 6;
DELETE FROM equipos WHERE id = 6;

-- 2 operaciones que FALLAN (comentadas)
-- Falla por restricción CHECK (puntuación negativa):
-- INSERT INTO resultados (partida_id, equipo_id, puntuacion, resultado) VALUES (1, 1, -5, 'victoria');

-- Falla por restricción UNIQUE (gamertag repetido):
-- INSERT INTO jugadores (equipo_id, gamertag, rol, edad) VALUES (2, 'Tenz', 'Duelista', 20);