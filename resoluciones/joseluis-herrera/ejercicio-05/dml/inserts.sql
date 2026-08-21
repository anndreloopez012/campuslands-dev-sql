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

INSERT INTO proveedores (
    id_proveedor,
    nombre_empresa,
    telefono,
    email
) VALUES
    (1, 'Bike Supply Guatemala', '55510001', 'ventas@bikesupply.com'),
    (2, 'Distribuciones Ciclo', '55510002', 'contacto@ciclo.com'),
    (3, 'Importadora Pedal', '55510003', 'ventas@pedal.com'),
    (4, 'Global Bikes', '55510004', 'info@globalbikes.com'),
    (5, 'Mundo Ciclista', '55510005', 'ventas@mundociclista.com');

INSERT INTO bicicletas (
    id_bicicleta,
    id_marca,
    id_proveedor,
    modelo,
    tipo,
    precio,
    stock_actual
) VALUES
    (1, 1, 1, 'Marlin 7', 'MTB', 850.00, 12),
    (2, 2, 2, 'Rockhopper', 'MTB', 920.00, 8),
    (3, 3, 3, 'Talon 2', 'MTB', 780.00, 15),
    (4, 4, 4, 'Speedster 30', 'RUTA', 1250.00, 6),
    (5, 5, 5, 'Trail 5', 'MTB', 980.00, 10);

INSERT INTO movimientos_inventario (
    id_movimiento,
    id_bicicleta,
    tipo_movimiento,
    cantidad,
    fecha_movimiento,
    observacion
) VALUES
    (1, 1, 'ENTRADA', 10, '2026-07-01', 'Compra inicial'),
    (2, 1, 'SALIDA', 3, '2026-07-05', 'Venta'),
    (3, 2, 'ENTRADA', 8, '2026-07-02', 'Compra inicial'),
    (4, 2, 'SALIDA', 2, '2026-07-08', 'Venta'),
    (5, 3, 'ENTRADA', 15, '2026-07-03', 'Compra inicial'),
    (6, 3, 'SALIDA', 5, '2026-07-10', 'Venta'),
    (7, 4, 'ENTRADA', 6, '2026-07-04', 'Compra inicial'),
    (8, 4, 'SALIDA', 2, '2026-07-12', 'Venta'),
    (9, 5, 'ENTRADA', 10, '2026-07-05', 'Compra inicial'),
    (10, 5, 'SALIDA', 4, '2026-07-15', 'Venta');