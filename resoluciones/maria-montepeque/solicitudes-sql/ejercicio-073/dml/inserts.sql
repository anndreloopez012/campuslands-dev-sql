PRAGMA foreign_keys = ON;

-- Ejercicio 073: Clanes Shooter
-- Datos base: 4 clanes, 8 jugadores, 4 mapas, 5 scrims (3 jugados,
-- 1 programado, 1 jugado-por-error que se corrige despues) y 4
-- resultados (incluye el que se carga por error antes de saber que
-- el scrim se debia cancelar).

INSERT INTO clanes (nombre_clan, region) VALUES
    ('Furia Roja', 'Norte'),
    ('Sombra Digital', 'Sur'),
    ('Vertigo', 'Centro'),
    ('Nova Tactica', 'Oeste');

INSERT INTO jugadores (nickname, id_clan) VALUES
    ('RedHawk', 1),
    ('CrimsonAce', 1),
    ('NightByte', 2),
    ('CipherX', 2),
    ('SpinOut', 3),
    ('EchoDrift', 3),
    ('NovaBlast', 4),
    ('QuantumRay', 4);

INSERT INTO mapas (nombre_mapa, modo_juego) VALUES
    ('Bunker Norte', 'busqueda'),
    ('Zona Industrial', 'dominio'),
    ('Puerto Fantasma', 'eliminacion'),
    ('Complejo Alfa', 'busqueda');

-- Scrim 1: Furia Roja (local) vs Sombra Digital (visitante), jugado.
INSERT INTO scrims (id_clan_local, id_clan_visitante, id_mapa, fecha_scrim, estado) VALUES
    (1, 2, 1, '2026-08-01', 'jugado');

-- Scrim 2: Sombra Digital (local) vs Vertigo (visitante), jugado.
INSERT INTO scrims (id_clan_local, id_clan_visitante, id_mapa, fecha_scrim, estado) VALUES
    (2, 3, 2, '2026-08-03', 'jugado');

-- Scrim 3: Vertigo (local) vs Nova Tactica (visitante), jugado.
INSERT INTO scrims (id_clan_local, id_clan_visitante, id_mapa, fecha_scrim, estado) VALUES
    (3, 4, 3, '2026-08-05', 'jugado');

-- Scrim 4: Furia Roja vs Vertigo, todavia no se juega.
INSERT INTO scrims (id_clan_local, id_clan_visitante, id_mapa, fecha_scrim, estado) VALUES
    (1, 3, 4, '2026-08-08', 'programado');

-- Scrim 5: se marco 'jugado' y se cargo su resultado, pero el
-- servidor se cayo a la mitad y el resultado se anulo despues. Se
-- corrige en dml/operaciones.sql.
INSERT INTO scrims (id_clan_local, id_clan_visitante, id_mapa, fecha_scrim, estado) VALUES
    (4, 2, 1, '2026-08-02', 'jugado');

-- Resultado del scrim 1: gana Furia Roja.
INSERT INTO resultados (id_scrim, id_clan_ganador, marcador_local, marcador_visitante) VALUES
    (1, 1, 5, 2);

-- Resultado del scrim 2: empate, sin ganador.
INSERT INTO resultados (id_scrim, id_clan_ganador, marcador_local, marcador_visitante) VALUES
    (2, NULL, 3, 3);

-- Resultado del scrim 3: gana Nova Tactica (visitante).
INSERT INTO resultados (id_scrim, id_clan_ganador, marcador_local, marcador_visitante) VALUES
    (3, 4, 1, 4);

-- Resultado del scrim 5, cargado antes de saber que el servidor se
-- habia caido. Quedara huerfano cuando el scrim se marque
-- 'cancelado' en dml/operaciones.sql, y se elimina ahi mismo.
INSERT INTO resultados (id_scrim, id_clan_ganador, marcador_local, marcador_visitante) VALUES
    (5, NULL, 2, 2);

-- Caso comentado que debe fallar (queda comentado): registrar un
-- segundo resultado para el scrim 1, exactamente el problema que
-- describio el cliente (registros duplicados que arruinan los
-- reportes). El UNIQUE (id_scrim) lo bloquea.
-- INSERT INTO resultados (id_scrim, id_clan_ganador, marcador_local, marcador_visitante) VALUES (1, 1, 5, 2);
