INSERT INTO equipos (nombre) VALUES
    ('Aguilas Doradas');

INSERT INTO resultados (id_partida, id_jugador, kills, muertes, puntos) VALUES
    (6, 1, 16, 15, 68);

UPDATE resultados
SET kills = 26, puntos = 98
WHERE id_resultado = 3;

UPDATE jugadores
SET rol = 'entry'
WHERE id_jugador = 4;

DELETE FROM resultados
WHERE id_resultado = 11;

DELETE FROM resultados
WHERE puntos < 60;

-- 2 operaciones que fallarám por restricciones
-- Falla por UNIQUE (equipos.nombre): el equipo ya existe
-- INSERT INTO equipos (nombre) VALUES ('Dragones Rojos');

-- Falla por CHECK (equipo_local <> equipo_visitante)
-- INSERT INTO partidas (equipo_local, equipo_visitante, fecha_partida, mapa) VALUES (1, 1, '2026-07-10 18:00', 'Dust');
