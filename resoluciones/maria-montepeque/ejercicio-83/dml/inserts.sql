PRAGMA foreign_keys = ON;

-- Ejercicio 83: WHERE Nivel Basico
-- Datos de prueba.

INSERT INTO clientes (nombre_cliente, telefono) VALUES
    ('Manuel Estrada', '5555-9001'),
    ('Alejandra Chinchilla', '5555-9002'),
    ('Byron Xicay', '5555-9003');

INSERT INTO productos (nombre_producto, precio, categoria) VALUES
    ('Cafe Americano', 15.00, 'bebida'),
    ('Cappuccino', 20.00, 'bebida'),
    ('Te Chai', 12.00, 'bebida'),
    ('Croissant', 18.00, 'comida'),
    ('Sandwich Jamon', 35.00, 'comida');

INSERT INTO ventas (id_cliente, id_producto, cantidad, fecha_venta) VALUES
    (1, 1, 2, '2026-08-01'),
    (2, 2, 1, '2026-08-01'),
    (3, 3, 3, '2026-08-02'),
    (1, 4, 1, '2026-08-02'),
    (2, 5, 1, '2026-08-03'),
    (3, 1, 2, '2026-08-03');
