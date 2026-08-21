PRAGMA foreign_keys = ON;

-- Ejercicio 046: Battle Royale Ranking
-- Datos de prueba.

INSERT INTO jugadores (nombre_jugador, plataforma) VALUES
    ('ShadowFox_502', 'pc'),
    ('NightBlade99', 'consola'),
    ('QuetzalSniper', 'pc'),
    ('VortexGG', 'movil'),
    ('PixelHunter', 'consola'),
    ('RunaWarrior', 'pc');

INSERT INTO temporadas (nombre_temporada, fecha_inicio, fecha_fin, estado) VALUES
    ('Temporada 1 - Verano', '2026-07-01', '2026-07-31', 'cerrada'),
    ('Temporada 2 - Otono', '2026-08-01', '2026-08-31', 'activa');

-- La partida 10 es un duplicado por error de digitacion (misma
-- temporada, fecha, mapa y estado que la partida 3): se corrige en
-- dml/operaciones.sql. La partida 7 se cayo del servidor antes de
-- generar cualquier resultado (se borrara de forma controlada); la
-- partida 8 tambien se anulo, pero alcanzo a guardar un resultado
-- parcial antes de la caida, asi que no se puede borrar.
INSERT INTO partidas (id_temporada, fecha_partida, mapa, estado) VALUES
    (1, '2026-07-05', 'Isla Tormenta', 'finalizada'),
    (1, '2026-07-12', 'Desierto Rojo', 'finalizada'),
    (2, '2026-08-02', 'Isla Tormenta', 'finalizada'),
    (2, '2026-08-05', 'Zona Artica', 'finalizada'),
    (2, '2026-08-09', 'Desierto Rojo', 'finalizada'),
    (2, '2026-08-12', 'Isla Tormenta', 'en_curso'),
    (2, '2026-08-15', 'Zona Artica', 'anulada'),
    (2, '2026-08-18', 'Desierto Rojo', 'anulada'),
    (2, '2026-08-20', 'Isla Tormenta', 'en_curso'),
    (2, '2026-08-02', 'Isla Tormenta', 'finalizada');

INSERT INTO estadisticas (id_partida, id_jugador, kills, posicion_final, puntos) VALUES
    (1, 1, 5, 1, 20),
    (1, 2, 2, 5, 8),
    (2, 1, 3, 2, 15),
    (2, 3, 6, 1, 22),
    (3, 1, 4, 1, 18),
    (3, 2, 1, 8, 5),
    (3, 4, 7, 3, 16),
    (4, 3, 5, 2, 17),
    (4, 5, 3, 1, 19),
    (5, 1, 2, 4, 10),
    (5, 6, 8, 1, 24),
    (8, 2, 3, 6, 9);

-- Casos comentados que deben fallar (no ser recomendables), dejar
-- comentados:

-- 1) Registro repetido: nombre_jugador ya existe, viola el UNIQUE.
-- INSERT INTO jugadores (nombre_jugador, plataforma) VALUES ('ShadowFox_502', 'movil');

-- 2) Fechas invalidas: fecha_fin antes que fecha_inicio, viola el CHECK.
-- INSERT INTO temporadas (nombre_temporada, fecha_inicio, fecha_fin) VALUES ('Temporada 3 - Invierno', '2026-09-30', '2026-09-01');
