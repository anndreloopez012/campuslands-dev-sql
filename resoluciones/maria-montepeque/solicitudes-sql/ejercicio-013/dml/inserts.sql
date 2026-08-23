PRAGMA foreign_keys = ON;

-- Ejercicio 013: Clinica de Tatuajes
-- Datos de prueba.

INSERT INTO artistas (nombre_artista, estilo_principal) VALUES
    ('Karla Diaz', 'realismo'),
    ('Julio Perez', 'tradicional'),
    ('Ingrid Say', 'blackwork'),
    ('Mario Ixtabalan', 'acuarela'),
    ('Rosa Chavez', 'minimalista');

-- La sesion 9 es una entrada de prueba (cliente "Cuenta de Prueba") que
-- se cargo por error: se elimina en dml/operaciones.sql.
INSERT INTO sesiones (id_artista, nombre_cliente, fecha_sesion, monto_pagado, estado) VALUES
    (1, 'Ana Gomez', '2026-07-01', 1200.00, 'completada'),
    (2, 'Luis Marroquin', '2026-07-03', 800.00, 'completada'),
    (3, 'Karen Solis', '2026-07-05', 950.00, 'agendada'),
    (1, 'Diego Paz', '2026-07-08', 1500.00, 'completada'),
    (4, 'Rosa Mendez', '2026-07-10', 650.00, 'cancelada'),
    (5, 'Julio Perez', '2026-07-12', 400.00, 'completada'),
    (1, 'Ana Gomez', '2026-07-15', 1200.00, 'agendada'),
    (2, 'Karen Solis', '2026-07-18', 800.00, 'completada'),
    (1, 'Cuenta de Prueba', '2026-07-01', 1200.00, 'agendada');

-- Caso comentado que debe fallar (no ser recomendable), dejar comentado:
-- monto_pagado en cero, viola el CHECK de sesiones.
-- INSERT INTO sesiones (id_artista, nombre_cliente, fecha_sesion, monto_pagado) VALUES (2, 'Tomas Blanco', '2026-07-20', 0);
