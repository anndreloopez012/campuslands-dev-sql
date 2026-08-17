-- Ejercicio 05: Inventario de Bicicletas
-- Datos base: 5 marcas, 5 proveedores, 6 bicicletas, 10 movimientos_inventario

INSERT INTO marcas (nombre) VALUES
    ('Trek'),
    ('Giant'),
    ('Specialized'),
    ('Scott'),
    ('Cannondale');

INSERT INTO proveedores (nombre, telefono) VALUES
    ('Distribuidora Andina', '5552001'),
    ('Ciclo Import', '5552002'),
    ('Bikes Express', '5552003'),
    ('Rueda Libre SA', '5552004'),
    ('Pedal Group', '5552005');

INSERT INTO bicicletas (id_marca, modelo, tipo, precio, stock) VALUES
    (1, 'Marlin 7', 'montana', 950.00, 10),
    (2, 'Talon 3', 'montana', 720.00, 8),
    (3, 'Allez', 'ruta', 1100.00, 5),
    (4, 'Sub Cross', 'urbana', 650.00, 6),
    (5, 'Trail 5', 'montana', 1500.00, 4),
    (1, 'FX 2', 'urbana', 580.00, 12);

INSERT INTO movimientos_inventario (id_bicicleta, id_proveedor, tipo_movimiento, cantidad, fecha_movimiento) VALUES
    (1, 1, 'entrada', 10, '2026-07-01'),
    (2, 2, 'entrada', 8, '2026-07-02'),
    (3, 3, 'entrada', 5, '2026-07-03'),
    (4, 4, 'entrada', 6, '2026-07-04'),
    (5, 5, 'entrada', 4, '2026-07-05'),
    (6, 1, 'entrada', 12, '2026-07-06'),
    (1, 1, 'salida', 2, '2026-07-10'),
    (2, 2, 'salida', 1, '2026-07-11'),
    (3, 3, 'salida', 1, '2026-07-12'),
    (6, 1, 'salida', 3, '2026-07-13');
