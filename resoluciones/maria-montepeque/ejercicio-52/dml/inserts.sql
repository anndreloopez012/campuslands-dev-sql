PRAGMA foreign_keys = ON;

-- Ejercicio 52: UNIQUE Nivel Aplicado
-- Datos de prueba para validar el tema UNIQUE.

INSERT INTO equipos (nombre) VALUES
    ('Dragones Rojos'),
    ('Lobos Nocturnos'),
    ('Fenix Gaming'),
    ('Tigres Blancos'),
    ('Halcones Negros');

INSERT INTO jugadores (id_equipo, nickname) VALUES
    (1, 'RedDragon'),
    (2, 'NightWolf'),
    (3, 'PhoenixX'),
    (4, 'WhiteTiger'),
    (5, 'BlackHawk');

INSERT INTO partidas (equipo_local, equipo_visitante, fecha_partida, marcador_local, marcador_visitante, mvp_jugador) VALUES
    (1, 2, '2026-07-01', 3, 1, 1),
    (3, 4, '2026-07-01', 2, 2, 3),
    (5, 1, '2026-07-02', 1, 4, 1),
    (2, 3, '2026-07-02', 2, 0, 2),
    (4, 5, '2026-07-03', 1, 1, 5),
    (1, 3, '2026-07-03', 3, 2, 1);

-- Caso valido: "Progamer99" (equipo 2) y "ReddragonX" son nicknames
-- distintos de los ya existentes, aunque se parezcan visualmente; no hay
-- coincidencia en LOWER(nickname) con ninguno de los 5 anteriores.
INSERT INTO jugadores (id_equipo, nickname) VALUES
    (2, 'Progamer99');

-- Caso comentado que debe fallar (no ser recomendable), dejar comentado:
-- 'reddragon' (todo minusculas) choca con 'RedDragon' ya existente al
-- comparar LOWER(nickname): el indice unico por expresion lo rechaza,
-- aunque el texto exacto nunca se haya usado antes.
-- INSERT INTO jugadores (id_equipo, nickname) VALUES (3, 'reddragon');

-- Otro caso comentado que debe fallar: repetir el mismo enfrentamiento
-- (mismo equipo local, mismo equipo visitante, misma fecha) que ya existe.
-- INSERT INTO partidas (equipo_local, equipo_visitante, fecha_partida, marcador_local, marcador_visitante) VALUES (1, 2, '2026-07-01', 0, 0);
