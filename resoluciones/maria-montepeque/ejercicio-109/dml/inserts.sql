PRAGMA foreign_keys = ON;

-- Ejercicio 109: Indices Nivel Aplicado
-- Datos de prueba: 3 categorias, 5 productos, 10 movimientos (5 entradas, 5 salidas).

INSERT INTO categorias (nombre_categoria) VALUES
    ('Laptops'),
    ('Perifericos'),
    ('Almacenamiento');

INSERT INTO productos (id_categoria, nombre_producto, precio_unitario) VALUES
    (1, 'Laptop Pro 15',      8500.00),
    (2, 'Mouse Inalambrico',   120.00),
    (2, 'Teclado Mecanico',    250.00),
    (3, 'Disco SSD 1TB',       450.00),
    (1, 'Laptop Basica 14',   4200.00);

INSERT INTO movimientos (id_producto, tipo_movimiento, cantidad, fecha_movimiento) VALUES
    (1, 'entrada',  5, '2026-08-01'),
    (1, 'salida',   3, '2026-08-05'),
    (2, 'entrada', 10, '2026-08-02'),
    (2, 'salida',   4, '2026-08-06'),
    (3, 'entrada',  8, '2026-08-03'),
    (3, 'salida',   2, '2026-08-07'),
    (4, 'entrada',  6, '2026-08-04'),
    (4, 'salida',   1, '2026-08-08'),
    (1, 'salida',   2, '2026-08-10'),
    (5, 'entrada',  3, '2026-08-09');

-- Caso comentado que no se debe hacer, dejar comentado: registrar un
-- movimiento con cantidad 0 o negativa. El CHECK (cantidad > 0) lo rechaza.
-- INSERT INTO movimientos (id_producto, tipo_movimiento, cantidad, fecha_movimiento) VALUES (1, 'salida', 0, '2026-08-11');
