PRAGMA foreign_keys = ON;

-- Ejercicio 012: Club Futbol Sala
-- Datos de prueba.

INSERT INTO equipos (nombre_equipo, categoria) VALUES
    ('Halcones FC', 'primera'),
    ('Tigres Salado', 'primera'),
    ('Rayos del Sur', 'segunda'),
    ('Juveniles Aurora', 'juvenil');

-- El evento 9 es una entrada de prueba (jugador "Cuenta de Prueba") que
-- se cargo por error: se elimina en dml/operaciones.sql.
INSERT INTO eventos (id_equipo, nombre_jugador, tipo_evento, fecha_partido, monto, estado) VALUES
    (1, 'Andres Lopez', 'gol', '2026-07-01', 50.00, 'pagado'),
    (2, 'Carlos Ruiz', 'tarjeta_amarilla', '2026-07-01', 25.00, 'registrado'),
    (1, 'Marta Vega', 'gol', '2026-07-05', 50.00, 'pagado'),
    (3, 'Diana Cruz', 'tarjeta_roja', '2026-07-05', 80.00, 'registrado'),
    (2, 'Pedro Gomez', 'gol', '2026-07-08', 50.00, 'registrado'),
    (4, 'Sofia Reyes', 'tarjeta_amarilla', '2026-07-08', 15.00, 'pagado'),
    (1, 'Andres Lopez', 'gol', '2026-07-12', 50.00, 'registrado'),
    (3, 'Laura Ortiz', 'tarjeta_amarilla', '2026-07-12', 25.00, 'anulado'),
    (1, 'Cuenta de Prueba', 'gol', '2026-07-01', 50.00, 'registrado');

-- Caso comentado que debe fallar (no ser recomendable), dejar comentado:
-- monto negativo, viola el CHECK de eventos.
-- INSERT INTO eventos (id_equipo, nombre_jugador, tipo_evento, monto) VALUES (2, 'Diego Paz', 'gol', -50.00);
