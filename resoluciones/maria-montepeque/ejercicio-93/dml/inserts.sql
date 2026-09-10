PRAGMA foreign_keys = ON;

-- Ejercicio 93: HAVING Nivel Intermedio
-- Datos de prueba: 3 categorias, 5 productos, 10 movimientos.

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
    -- entradas
    (1, 'entrada',  5, '2026-08-01'),
    (2, 'entrada', 10, '2026-08-02'),
    (3, 'entrada',  5, '2026-08-03'),
    (4, 'entrada',  2, '2026-08-04'),
    (5, 'entrada',  3, '2026-08-05'),
    -- salidas: Laptops (cat 1) = 12+10 = 22; Perifericos (cat 2) = 25+8 = 33; Almacenamiento (cat 3) = 15
    (1, 'salida',  12, '2026-08-10'),
    (2, 'salida',  25, '2026-08-11'),
    (3, 'salida',   8, '2026-08-12'),
    (4, 'salida',  15, '2026-08-13'),
    (5, 'salida',  10, '2026-08-14');

-- Caso comentado que no se debe hacer, dejar comentado: registrar un
-- movimiento con cantidad negativa. El CHECK (cantidad > 0) lo rechaza.
-- INSERT INTO movimientos (id_producto, tipo_movimiento, cantidad, fecha_movimiento) VALUES (1, 'salida', -5, '2026-08-15');
