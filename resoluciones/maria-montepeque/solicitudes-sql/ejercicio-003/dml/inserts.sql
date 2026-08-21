PRAGMA foreign_keys = ON;

-- Ejercicio 003: Torneo Esports
-- Datos de prueba.

INSERT INTO equipos (nombre_equipo, region) VALUES
    ('Dragones Rojos', 'Norteamerica'),
    ('Lobos del Norte', 'Sudamerica'),
    ('Fenix Gaming', 'Europa'),
    ('Aguilas Negras', 'Asia');

-- El jugador 9 (TestPlayer99) es una cuenta de prueba que se cargo por
-- error y nunca compitio: se elimina en dml/operaciones.sql.
INSERT INTO jugadores (id_equipo, nickname, nombre_real, rol, puntos_totales, estado) VALUES
    (1, 'ShadowFox', 'Andres Lopez', 'duelist', 320, 'activo'),
    (1, 'IceQueen', 'Marta Vega', 'support', 210, 'activo'),
    (1, 'CaptainRed', 'Carlos Ruiz', 'igl', 180, 'activo'),
    (2, 'WolfBite', 'Diana Cruz', 'entry', 275, 'activo'),
    (2, 'NightHunter', 'Pedro Gomez', 'duelist', 300, 'suspendido'),
    (3, 'PhoenixX', 'Laura Ortiz', 'support', 150, 'activo'),
    (3, 'BlazeStorm', 'Sofia Reyes', 'entry', 190, 'inactivo'),
    (4, 'BlackEagle', 'Mario Paz', 'igl', 260, 'activo'),
    (1, 'TestPlayer99', 'Cuenta de Prueba', 'duelist', 0, 'activo');

-- Caso comentado que debe fallar (no ser recomendable), dejar comentado:
-- puntos_totales negativo, viola el CHECK de jugadores.
-- INSERT INTO jugadores (id_equipo, nickname, nombre_real, rol, puntos_totales) VALUES (1, 'GhostRider', 'Julio Perez', 'entry', -10);
