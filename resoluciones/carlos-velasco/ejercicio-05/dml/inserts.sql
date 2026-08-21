PRAGMA foreign_keys = ON;

-- =========================================================
-- MARCAS
-- =========================================================

INSERT INTO marcas (
    id_marca,
    nombre,
    pais_origen
) VALUES
    (1, 'Trek', 'Estados Unidos'),
    (2, 'Specialized', 'Estados Unidos'),
    (3, 'Giant', 'Taiwan'),
    (4, 'Scott', 'Suiza'),
    (5, 'Cannondale', 'Estados Unidos');

-- =========================================================
-- PROVEEDORES
-- =========================================================

INSERT INTO proveedores (
    id_proveedor,
    nombre,
    telefono,
    email
) VALUES
    (1, 'Distribuciones Andinas', '5551001', 'ventas@andinas.com'),
    (2, 'Bike Supply Guatemala', '5551002', 'contacto@bikesupply.com'),
    (3, 'Importadora Ciclo', '5551003', 'ventas@ciclo.com'),
    (4, 'Movilidad Urbana', '5551004', 'pedidos@movilidad.com'),
    (5, 'Global Bike Parts', '5551005', 'ventas@globalbike.com');

-- =========================================================
-- BICICLETAS
-- =========================================================

INSERT INTO bicicletas (
    id_bicicleta,
    codigo,
    modelo,
    categoria,
    precio,
    id_marca
) VALUES
    (1, 'BIKE-001', 'Marlin 7', 'MONTAÑA', 850.00, 1),
    (2, 'BIKE-002', 'Rockhopper Comp', 'MONTAÑA', 920.00, 2),
    (3, 'BIKE-003', 'Escape 3', 'URBANA', 680.00, 3),
    (4, 'BIKE-004', 'Speedster 40', 'CARRETERA', 1250.00, 4),
    (5, 'BIKE-005', 'Trail 5', 'MONTAÑA', 1050.00, 5);

-- =========================================================
-- MOVIMIENTOS DE INVENTARIO
-- =========================================================

INSERT INTO movimientos_inventario (
    id_movimiento,
    id_bicicleta,
    id_proveedor,
    tipo_movimiento,
    cantidad,
    fecha_movimiento,
    observacion
) VALUES
    (1, 1, 1, 'ENTRADA', 10, '2026-07-01 09:00:00', 'Compra inicial'),
    (2, 1, 1, 'SALIDA', 4, '2026-07-08 15:30:00', 'Venta a cliente'),

    (3, 2, 2, 'ENTRADA', 8, '2026-07-03 10:00:00', 'Reposicion de inventario'),
    (4, 2, 2, 'SALIDA', 5, '2026-07-15 16:00:00', 'Venta a cliente'),

    (5, 3, 3, 'ENTRADA', 12, '2026-07-05 08:30:00', 'Compra mayorista'),
    (6, 3, 3, 'SALIDA', 8, '2026-07-20 14:00:00', 'Ventas del periodo'),

    (7, 4, 4, 'ENTRADA', 5, '2026-07-10 11:00:00', 'Compra de temporada'),
    (8, 4, 4, 'SALIDA', 2, '2026-07-25 17:00:00', 'Venta a cliente'),

    (9, 5, 5, 'ENTRADA', 6, '2026-07-12 09:30:00', 'Reposicion de inventario'),
    (10, 5, 5, 'SALIDA', 4, '2026-08-05 13:00:00', 'Ventas del periodo');