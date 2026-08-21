-- Ejercicio 28: Vistas y Reportes
-- Datos base: 5 clientes, 5 vendedores, 5 ventas, 10 pagos

INSERT INTO clientes (nombre, correo) VALUES
    ('Manuel Estrada', 'manuel.estrada@correo.com'),
    ('Alejandra Chinchilla', 'alejandra.chinchilla@correo.com'),
    ('Byron Xicay', 'byron.xicay@correo.com'),
    ('Cristina Barrios', 'cristina.barrios@correo.com'),
    ('Douglas Pineda', 'douglas.pineda@correo.com');

INSERT INTO vendedores (nombre, correo) VALUES
    ('Jorge Lemus', 'jorge.lemus@campus.edu'),
    ('Fernanda Ruiz', 'fernanda.ruiz@campus.edu'),
    ('Hector Aguilar', 'hector.aguilar@campus.edu'),
    ('Paola Sandoval', 'paola.sandoval@campus.edu'),
    ('Ricardo Solis', 'ricardo.solis@campus.edu');

INSERT INTO ventas (id_cliente, id_vendedor, total, fecha) VALUES
    (1, 1, 1000.00, '2026-07-01'),
    (2, 2, 500.00, '2026-07-02'),
    (3, 1, 750.00, '2026-07-03'),
    (4, 3, 1200.00, '2026-07-04'),
    (5, 2, 300.00, '2026-07-05');

INSERT INTO pagos (id_venta, monto, metodo, fecha) VALUES
    (1, 600.00, 'tarjeta', '2026-07-01'),
    (1, 400.00, 'efectivo', '2026-07-08'),
    (2, 300.00, 'transferencia', '2026-07-02'),
    (2, 200.00, 'efectivo', '2026-07-09'),
    (3, 400.00, 'tarjeta', '2026-07-03'),
    (3, 200.00, 'efectivo', '2026-07-10'),
    (4, 700.00, 'transferencia', '2026-07-04'),
    (4, 300.00, 'tarjeta', '2026-07-11'),
    (5, 150.00, 'efectivo', '2026-07-05'),
    (5, 150.00, 'efectivo', '2026-07-12');
