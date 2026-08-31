PRAGMA foreign_keys = ON;

-- Ejercicio 81: SELECT Nivel Intermedio
-- Datos de prueba.

INSERT INTO clientes (nombre_cliente, telefono) VALUES
    ('Manuel Estrada', '5555-3001'),
    ('Alejandra Chinchilla', '5555-3002'),
    ('Byron Xicay', '5555-3003');

INSERT INTO productos (nombre_producto, precio) VALUES
    ('Cafe Americano', 15.00),
    ('Cappuccino', 20.00),
    ('Te Chai', 12.00),
    ('Croissant', 18.00);

INSERT INTO ventas (id_cliente, id_producto, cantidad, fecha_venta) VALUES
    (1, 1, 2, '2026-08-01'),
    (2, 2, 1, '2026-08-01'),
    (3, 3, 3, '2026-08-02'),
    (1, 4, 1, '2026-08-02'),
    (2, 1, 2, '2026-08-03');
