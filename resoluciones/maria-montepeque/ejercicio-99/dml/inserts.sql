PRAGMA foreign_keys = ON;

-- Ejercicio 99: Vistas Nivel Intermedio
-- Datos de prueba: 4 clientes, 4 productos, 8 ventas.

INSERT INTO clientes (nombre_cliente, email) VALUES
    ('Sofia Martinez',    'sofia.martinez@cafeteria.test'),
    ('Pedro Ramirez',     'pedro.ramirez@cafeteria.test'),
    ('Lucia Fernandez',   'lucia.fernandez@cafeteria.test'),
    ('Mario Castillo',    'mario.castillo@cafeteria.test');

INSERT INTO productos (nombre_producto, precio_unitario) VALUES
    ('Cafe Americano', 15.00),
    ('Cafe Latte',      20.00),
    ('Croissant',       12.00),
    ('Te Verde',        10.00);

INSERT INTO ventas (id_cliente, id_producto, cantidad, fecha_venta) VALUES
    (1, 1, 2, '2026-08-01'),
    (1, 2, 1, '2026-08-02'),
    (2, 1, 3, '2026-08-02'),
    (2, 3, 2, '2026-08-03'),
    (3, 2, 2, '2026-08-04'),
    (3, 3, 1, '2026-08-05'),
    (4, 4, 4, '2026-08-06'),
    (4, 1, 1, '2026-08-07');

-- Caso comentado que no se debe hacer, dejar comentado: registrar una
-- venta con cantidad 0 o negativa. El CHECK (cantidad > 0) lo rechaza.
-- INSERT INTO ventas (id_cliente, id_producto, cantidad, fecha_venta) VALUES (1, 1, 0, '2026-08-08');
