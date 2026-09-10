PRAGMA foreign_keys = ON;

-- Ejercicio 106: Triggers Nivel Aplicado
-- Datos de prueba: 3 equipos, 6 jugadores, 5 partidas, mas un UPDATE
-- y un DELETE para ejercitar los 3 triggers (INSERT, UPDATE, DELETE).

INSERT INTO equipos (nombre_equipo) VALUES
    ('Dragones Digitales'),
    ('Halcones Nocturnos'),
    ('Fenix Cibernetico');

INSERT INTO jugadores (id_equipo, nombre_jugador, gamer_tag) VALUES
    (1, 'Manuel Estrada',      'M-Blaze'),
    (1, 'Alejandra Chinchilla','AleShadow'),
    (2, 'Byron Xicay',         'ByroWolf'),
    (2, 'Sofia Martinez',      'SofiStorm'),
    (3, 'Cristina Barrios',    'CrisFrost'),
    (3, 'Pedro Ramirez',       'PedroFlame');

-- Cada INSERT de aqui abajo dispara trg_sumar_puntaje_partida_insert,
-- que va sumando el puntaje_total de cada equipo automaticamente.
INSERT INTO partidas (id_equipo, puntaje, fecha_partida, resultado) VALUES
    (1, 80, '2026-08-10', 'victoria'),  -- Dragones: puntaje_total 0 -> 80
    (1, 90, '2026-08-12', 'victoria'),  -- Dragones: 80 -> 170
    (2, 60, '2026-08-10', 'victoria'),  -- Halcones: 0 -> 60
    (3, 70, '2026-08-11', 'victoria'),  -- Fenix: 0 -> 70
    (3, 50, '2026-08-13', 'derrota');   -- Fenix: 70 -> 120

-- Este UPDATE dispara trg_ajustar_puntaje_partida_update: se corrige
-- el puntaje de la primera partida de Dragones (80 -> 100), y el
-- trigger ajusta el total solo por la diferencia (+20).
UPDATE partidas SET puntaje = 100 WHERE id_partida = 1; -- Dragones: puntaje_total 170 -> 190

-- Este DELETE dispara trg_restar_puntaje_partida_delete: se elimina
-- la unica partida registrada de Halcones (se anulo el resultado), y
-- el trigger resta su puntaje del total.
DELETE FROM partidas WHERE id_partida = 3; -- Halcones: puntaje_total 60 -> 0

-- Caso comentado que no se debe hacer, dejar comentado: registrar una
-- partida con puntaje negativo. El CHECK (puntaje >= 0) lo rechaza.
-- INSERT INTO partidas (id_equipo, puntaje, fecha_partida, resultado) VALUES (1, -10, '2026-08-14', 'derrota');
