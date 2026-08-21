-- Ejercicio 23: Facturacion Simple
-- Datos base: 5 clientes, 5 productos, 5 facturas, 10 detalles de factura

INSERT INTO clientes (nombre, nit, correo) VALUES
    ('Manuel Estrada', 'NIT-4001', 'manuel.estrada@correo.com'),
    ('Alejandra Chinchilla', 'NIT-4002', 'alejandra.chinchilla@correo.com'),
    ('Byron Xicay', 'NIT-4003', 'byron.xicay@correo.com'),
    ('Cristina Barrios', 'NIT-4004', 'cristina.barrios@correo.com'),
    ('Douglas Pineda', 'NIT-4005', 'douglas.pineda@correo.com');

INSERT INTO productos (nombre, precio_unitario) VALUES
    ('Laptop', 4500.00),
    ('Mouse', 75.00),
    ('Teclado', 120.00),
    ('Monitor', 950.00),
    ('Impresora', 650.00);

INSERT INTO facturas (id_cliente, fecha, subtotal, impuesto, total) VALUES
    (1, '2026-07-01', 4650.00, 558.00, 5208.00),
    (2, '2026-07-02', 1070.00, 128.40, 1198.40),
    (3, '2026-07-03', 875.00, 105.00, 980.00),
    (4, '2026-07-04', 5150.00, 618.00, 5768.00),
    (5, '2026-07-05', 1190.00, 142.80, 1332.80);

INSERT INTO detalle_factura (id_factura, id_producto, cantidad, precio_unitario) VALUES
    (1, 1, 1, 4500.00),
    (1, 2, 2, 75.00),
    (2, 3, 1, 120.00),
    (2, 4, 1, 950.00),
    (3, 5, 1, 650.00),
    (3, 2, 3, 75.00),
    (4, 1, 1, 4500.00),
    (4, 5, 1, 650.00),
    (5, 3, 2, 120.00),
    (5, 4, 1, 950.00);
