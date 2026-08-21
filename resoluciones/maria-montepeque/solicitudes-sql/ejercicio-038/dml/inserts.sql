PRAGMA foreign_keys = ON;

-- Ejercicio 038: Clinica de Tatuajes
-- Datos de prueba.

INSERT INTO artistas (nombre_artista, estilo) VALUES
    ('Karla Fong', 'realismo'),
    ('Mateo Solis', 'tradicional'),
    ('Ximena Ac', 'blackwork'),
    ('Douglas Perez', 'acuarela'),
    ('Valeria Tum', 'minimalista');

INSERT INTO clientes (nombre_cliente, telefono) VALUES
    ('Cesar Molina', '5581234'),
    ('Andrea Recinos', '5587890'),
    ('Josue Batz', '5582345'),
    ('Melany Choc', '5583456'),
    ('Ronald Pineda', '5584567');

-- La sesion 10 es un duplicado por error de digitacion (mismo
-- cliente, artista, fecha, costo y monto pagado que la sesion 1): se
-- corrige en dml/operaciones.sql.
INSERT INTO sesiones (id_cliente, id_artista, fecha_sesion, costo_total, monto_pagado, estado) VALUES
    (1, 1, '2026-08-01', 1500.00, 1500.00, 'completada'),
    (2, 2, '2026-08-03', 800.00, 800.00, 'completada'),
    (3, 1, '2026-08-05', 2000.00, 1000.00, 'completada'),
    (1, 1, '2026-08-08', 600.00, 0.00, 'agendada'),
    (4, 3, '2026-08-10', 1800.00, 900.00, 'completada'),
    (5, 4, '2026-08-12', 400.00, 400.00, 'completada'),
    (2, 5, '2026-08-14', 2200.00, 0.00, 'cancelada'),
    (3, 2, '2026-08-16', 900.00, 300.00, 'agendada'),
    (1, 1, '2026-08-18', 500.00, 500.00, 'completada'),
    (1, 1, '2026-08-01', 1500.00, 1500.00, 'completada');

-- Caso comentado que debe fallar (no ser recomendable), dejar comentado:
-- monto_pagado mayor al costo_total, viola el CHECK de sesiones.
-- INSERT INTO sesiones (id_cliente, id_artista, fecha_sesion, costo_total, monto_pagado) VALUES (5, 2, '2026-08-20', 500.00, 600.00);
