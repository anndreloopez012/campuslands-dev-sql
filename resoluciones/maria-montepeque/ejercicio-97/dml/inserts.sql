PRAGMA foreign_keys = ON;

-- Ejercicio 97: JOIN Nivel Aplicado
-- Datos de prueba: 3 clientes, 4 productos (uno sin ventas), 6 ventas.

INSERT INTO clientes (nombre_cliente, email) VALUES
    ('Sofia Martinez',    'sofia.martinez@cafeteria.test'),
    ('Pedro Ramirez',     'pedro.ramirez@cafeteria.test'),
    ('Lucia Fernandez',   'lucia.fernandez@cafeteria.test');

INSERT INTO productos (nombre_producto, precio_unitario) VALUES
    ('Cafe Americano',        15.00),
    ('Cafe Latte',             20.00),
    ('Croissant',              12.00),
    ('Muffin de Arandanos',    18.00);
    -- 'Muffin de Arandanos' se deja sin ventas a proposito, para demostrar el LEFT JOIN.

INSERT INTO ventas (id_cliente, id_producto, cantidad, fecha_venta) VALUES
    (1, 1, 2, '2026-08-01'),
    (1, 2, 1, '2026-08-02'),
    (2, 1, 3, '2026-08-02'),
    (2, 3, 2, '2026-08-03'),
    (3, 2, 2, '2026-08-04'),
    (3, 3, 1, '2026-08-05');

-- Caso comentado que no se debe hacer, dejar comentado: registrar una
-- venta con cantidad 0 o negativa. El CHECK (cantidad > 0) lo rechaza.
-- INSERT INTO ventas (id_cliente, id_producto, cantidad, fecha_venta) VALUES (1, 1, 0, '2026-08-06');
