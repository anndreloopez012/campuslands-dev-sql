PRAGMA foreign_keys = ON;

-- Ejercicio 033: Viajes y Paracaidismo
-- Datos de prueba.

INSERT INTO experiencias (nombre_experiencia, tipo, precio) VALUES
    ('Salto en Paracaidas Nivel 1', 'paracaidismo', 1500.00),
    ('Salto en Paracaidas Tandem', 'paracaidismo', 1800.00),
    ('Tour Volcanes Guatemala', 'turismo', 2200.00),
    ('Aventura Selva Peten', 'viaje', 3200.00),
    ('Ruta Cafetera', 'turismo', 950.00);

INSERT INTO clientes (nombre_cliente, telefono) VALUES
    ('Ana Gomez', '5551001'),
    ('Luis Marroquin', '5551002'),
    ('Karen Solis', '5551003'),
    ('Diego Paz', '5551004'),
    ('Rosa Chavez', '5551005');

-- La reserva 9 es una duplicada por error de digitacion (misma
-- experiencia, cliente, fecha y monto que la reserva 1): se corrige en
-- dml/operaciones.sql.
INSERT INTO reservas (id_experiencia, id_cliente, fecha_reserva, monto_pagado, estado) VALUES
    (1, 1, '2026-07-01', 1500.00, 'completada'),
    (3, 2, '2026-07-05', 2200.00, 'completada'),
    (2, 3, '2026-07-10', 1800.00, 'pendiente'),
    (1, 4, '2026-07-12', 1500.00, 'confirmada'),
    (4, 5, '2026-07-15', 3200.00, 'completada'),
    (5, 1, '2026-07-18', 950.00, 'cancelada'),
    (1, 1, '2026-07-20', 1500.00, 'pendiente'),
    (2, 2, '2026-07-22', 1800.00, 'completada'),
    (1, 1, '2026-07-01', 1500.00, 'completada');

-- Caso comentado que debe fallar (no ser recomendable), dejar comentado:
-- monto_pagado en cero, viola el CHECK de reservas.
-- INSERT INTO reservas (id_experiencia, id_cliente, fecha_reserva, monto_pagado) VALUES (3, 4, '2026-07-25', 0);
