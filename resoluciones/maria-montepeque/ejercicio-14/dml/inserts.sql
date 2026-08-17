-- Ejercicio 14: Marketplace Campus
-- Datos base: 5 vendedores, 5 productos, 5 compradores, 10 ordenes

INSERT INTO vendedores (nombre, correo, telefono) VALUES
    ('Papeleria Central', 'papeleria.central@correo.com', '5011-0001'),
    ('Tecno Campus', 'tecno.campus@correo.com', '5011-0002'),
    ('Cafeteria Norte', 'cafeteria.norte@correo.com', '5011-0003'),
    ('Libreria Sur', 'libreria.sur@correo.com', '5011-0004'),
    ('Deportes Zet', 'deportes.zet@correo.com', '5011-0005');

INSERT INTO productos (id_vendedor, nombre, precio, stock) VALUES
    (1, 'Cuaderno profesional', 25.00, 80),
    (2, 'Audifonos USB', 120.00, 30),
    (3, 'Cafe grande', 18.00, 200),
    (4, 'Libro de calculo', 150.00, 15),
    (5, 'Balon de futbol', 90.00, 25);

INSERT INTO compradores (nombre, correo) VALUES
    ('Manuel Estrada', 'manuel.estrada@correo.com'),
    ('Alejandra Chinchilla', 'alejandra.chinchilla@correo.com'),
    ('Byron Xicay', 'byron.xicay@correo.com'),
    ('Cristina Barrios', 'cristina.barrios@correo.com'),
    ('Douglas Pineda', 'douglas.pineda@correo.com');

INSERT INTO ordenes (id_comprador, id_producto, cantidad, fecha, estado) VALUES
    (1, 1, 2, '2026-07-01', 'pagada'),
    (1, 3, 1, '2026-07-01', 'enviada'),
    (2, 2, 1, '2026-07-02', 'pagada'),
    (2, 4, 1, '2026-07-03', 'pendiente'),
    (3, 3, 3, '2026-07-03', 'pagada'),
    (3, 5, 1, '2026-07-04', 'enviada'),
    (4, 1, 5, '2026-07-05', 'pagada'),
    (4, 2, 1, '2026-07-06', 'cancelada'),
    (5, 4, 1, '2026-07-07', 'enviada'),
    (5, 5, 2, '2026-07-08', 'pendiente');
