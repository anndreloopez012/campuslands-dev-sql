PRAGMA foreign_keys = ON;

-- Ejercicio 008: Viajes y Paracaidismo
-- Datos de prueba.

INSERT INTO experiencias (nombre_experiencia, tipo, precio) VALUES
    ('Salto en Paracaidas Nivel 1', 'paracaidismo', 1500.00),
    ('Salto en Paracaidas Tandem', 'paracaidismo', 1800.00),
    ('Tour Volcanes Guatemala', 'turismo', 2200.00),
    ('Aventura Selva Peten', 'viaje', 3200.00),
    ('Ruta Cafetera', 'turismo', 950.00);

-- La reserva 9 es una entrada de prueba (cliente "Cuenta de Prueba") que
-- se cargo por error: se elimina en dml/operaciones.sql.
INSERT INTO reservas (id_experiencia, nombre_cliente, fecha_reserva, monto_pagado, estado) VALUES
    (1, 'Ana Gomez', '2026-07-01', 1500.00, 'completada'),
    (3, 'Luis Marroquin', '2026-07-05', 2200.00, 'completada'),
    (2, 'Karen Solis', '2026-07-10', 1800.00, 'pendiente'),
    (1, 'Diego Paz', '2026-07-12', 1500.00, 'confirmada'),
    (4, 'Rosa Chavez', '2026-07-15', 3200.00, 'completada'),
    (5, 'Julio Perez', '2026-07-18', 950.00, 'cancelada'),
    (1, 'Ana Gomez', '2026-07-20', 1500.00, 'pendiente'),
    (2, 'Luis Marroquin', '2026-07-22', 1800.00, 'completada'),
    (1, 'Cuenta de Prueba', '2026-07-01', 1500.00, 'pendiente');

-- Caso comentado que debe fallar (no ser recomendable), dejar comentado:
-- tipo fuera de la lista permitida por el CHECK de experiencias.
-- INSERT INTO experiencias (nombre_experiencia, tipo, precio) VALUES ('Buceo en Arrecife', 'buceo', 1200.00);
