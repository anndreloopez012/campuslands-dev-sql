PRAGMA foreign_keys = ON;

-- Ejercicio 001: Cafeteria Campus
-- Datos de prueba.

INSERT INTO productos (nombre_producto, precio, categoria, stock) VALUES
    ('Cafe americano', 8.50, 'bebida', 50),
    ('Sandwich de pollo', 25.00, 'comida', 20),
    ('Papas fritas', 12.00, 'snack', 30),
    ('Jugo natural', 10.00, 'bebida', 40),
    ('Empanada de queso', 15.00, 'comida', 25),
    ('Galletas artesanales', 9.00, 'snack', 35);

-- Ventas base. La venta 8 es una duplicada por error de digitacion (mismo
-- producto, cliente, cantidad, precio y fecha que la venta 2): asi se ve
-- exactamente el problema que describe el cliente ("varias personas
-- duplican datos sin darse cuenta"). Se corrige en dml/operaciones.sql.
INSERT INTO ventas (id_producto, nombre_cliente, cantidad, precio_pagado, fecha_venta, estado) VALUES
    (1, 'Ana Gomez', 2, 17.00, '2026-08-10 08:15', 'pagada'),
    (2, 'Luis Marroquin', 1, 25.00, '2026-08-10 12:30', 'pagada'),
    (1, 'Karen Solis', 1, 8.50, '2026-08-10 09:00', 'pendiente'),
    (4, 'Ana Gomez', 1, 10.00, '2026-08-11 08:00', 'pagada'),
    (3, 'Diego Paz', 2, 24.00, '2026-08-11 13:00', 'pagada'),
    (5, 'Rosa Chavez', 1, 15.00, '2026-08-12 09:30', 'cancelada'),
    (6, 'Ana Gomez', 3, 27.00, '2026-08-12 15:00', 'pagada'),
    (2, 'Luis Marroquin', 1, 25.00, '2026-08-10 12:30', 'pagada');

-- Caso comentado que debe fallar (no ser recomendable), dejar comentado:
-- categoria fuera de la lista permitida por el CHECK de productos.
-- INSERT INTO productos (nombre_producto, precio, categoria) VALUES ('Agua embotellada', 5.00, 'liquido');
