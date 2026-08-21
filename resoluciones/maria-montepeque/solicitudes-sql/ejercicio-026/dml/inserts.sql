PRAGMA foreign_keys = ON;

-- Ejercicio 026: Cafeteria Campus
-- Datos de prueba.

INSERT INTO clientes (nombre_cliente, carne_estudiantil) VALUES
    ('Ana Gomez', 'CARN-001'),
    ('Luis Marroquin', 'CARN-002'),
    ('Karen Solis', 'CARN-003'),
    ('Diego Paz', 'CARN-004'),
    ('Rosa Chavez', 'CARN-005');

INSERT INTO productos (nombre_producto, categoria, precio) VALUES
    ('Cafe Americano', 'bebida', 8.50),
    ('Sandwich de Pollo', 'comida', 25.00),
    ('Papas Fritas', 'snack', 12.00),
    ('Jugo Natural', 'bebida', 10.00),
    ('Empanada de Queso', 'comida', 15.00),
    ('Galletas Artesanales', 'snack', 9.00);

-- La venta 9 es una duplicada por error de digitacion (mismo producto,
-- cliente, cantidad, monto y fecha que la venta 1): se corrige en
-- dml/operaciones.sql.
INSERT INTO ventas (id_producto, id_cliente, cantidad, monto_total, fecha_venta, estado) VALUES
    (1, 1, 2, 17.00, '2026-08-10 08:15', 'pagada'),
    (2, 2, 1, 25.00, '2026-08-10 12:30', 'pagada'),
    (1, 3, 1, 8.50, '2026-08-10 09:00', 'pendiente'),
    (4, 1, 1, 10.00, '2026-08-11 08:00', 'pagada'),
    (3, 4, 2, 24.00, '2026-08-11 13:00', 'pagada'),
    (5, 5, 1, 15.00, '2026-08-12 09:30', 'cancelada'),
    (2, 1, 1, 25.00, '2026-08-12 12:00', 'pagada'),
    (6, 2, 3, 27.00, '2026-08-12 15:00', 'pagada'),
    (1, 1, 2, 17.00, '2026-08-10 08:15', 'pagada');

-- Caso comentado que debe fallar (no ser recomendable), dejar comentado:
-- categoria fuera de la lista permitida por el CHECK de productos.
-- INSERT INTO productos (nombre_producto, categoria, precio) VALUES ('Agua Embotellada', 'liquido', 5.00);
