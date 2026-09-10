PRAGMA foreign_keys = ON;

-- Ejercicio 91: GROUP BY Nivel Aplicado
-- Datos de prueba: 3 categorias, 5 productos, 12 movimientos de bodega.

INSERT INTO categorias (nombre_categoria) VALUES
    ('Laptops'),
    ('Perifericos'),
    ('Almacenamiento');

INSERT INTO productos (id_categoria, nombre_producto, precio_unitario, stock_inicial) VALUES
    (1, 'Laptop Pro 15',      8500.00, 10),
    (2, 'Mouse Inalambrico',   120.00, 30),
    (2, 'Teclado Mecanico',    250.00, 20),
    (3, 'Disco SSD 1TB',       450.00, 15),
    (1, 'Laptop Basica 14',   4200.00,  8);

INSERT INTO movimientos (id_producto, tipo_movimiento, cantidad, fecha_movimiento) VALUES
    -- Laptop Pro 15 (stock_inicial 10): 5 entran, 7 salen -> stock calculado 8
    (1, 'entrada',  5, '2026-08-01'),
    (1, 'salida',   3, '2026-08-05'),
    (1, 'salida',   4, '2026-08-10'),
    -- Mouse Inalambrico (stock_inicial 30): 10 entran, 45 salen -> stock calculado -5 (sobreventa)
    (2, 'entrada', 10, '2026-08-02'),
    (2, 'salida',  25, '2026-08-06'),
    (2, 'salida',  20, '2026-08-12'),
    -- Teclado Mecanico (stock_inicial 20): 5 entran, 5 salen -> stock calculado 20
    (3, 'entrada',  5, '2026-08-03'),
    (3, 'salida',   5, '2026-08-07'),
    -- Disco SSD 1TB (stock_inicial 15): 2 entran, 20 salen -> stock calculado -3 (sobreventa)
    (4, 'entrada',  2, '2026-08-04'),
    (4, 'salida',  20, '2026-08-08'),
    -- Laptop Basica 14 (stock_inicial 8): 3 entran, 2 salen -> stock calculado 9
    (5, 'entrada',  3, '2026-08-09'),
    (5, 'salida',   2, '2026-08-11');

-- Caso comentado que no se debe hacer, dejar comentado: registrar un
-- movimiento con cantidad 0 o negativa. El CHECK (cantidad > 0) lo rechaza.
-- INSERT INTO movimientos (id_producto, tipo_movimiento, cantidad, fecha_movimiento) VALUES (1, 'entrada', 0, '2026-08-13');
