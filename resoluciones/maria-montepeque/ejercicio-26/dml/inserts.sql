-- Ejercicio 26: Normalizacion Tienda
-- Datos base: 5 clientes, 5 categorias, 5 productos, 10 compras

INSERT INTO clientes (nombre, correo) VALUES
    ('Manuel Estrada', 'manuel.estrada@correo.com'),
    ('Alejandra Chinchilla', 'alejandra.chinchilla@correo.com'),
    ('Byron Xicay', 'byron.xicay@correo.com'),
    ('Cristina Barrios', 'cristina.barrios@correo.com'),
    ('Douglas Pineda', 'douglas.pineda@correo.com');

INSERT INTO categorias (nombre) VALUES
    ('Electronica'),
    ('Hogar'),
    ('Ropa'),
    ('Deportes'),
    ('Papeleria');

INSERT INTO productos (id_categoria, nombre, precio) VALUES
    (1, 'Audifonos Bluetooth', 250.00),
    (2, 'Juego de Sartenes', 400.00),
    (3, 'Camisa Casual', 120.00),
    (4, 'Balon de Futbol', 90.00),
    (5, 'Cuaderno Profesional', 25.00);

INSERT INTO compras (id_cliente, id_producto, cantidad, fecha) VALUES
    (1, 1, 1, '2026-07-01'),
    (1, 5, 3, '2026-07-15'),
    (2, 2, 1, '2026-07-02'),
    (2, 3, 2, '2026-07-20'),
    (3, 3, 1, '2026-07-03'),
    (3, 4, 1, '2026-07-18'),
    (4, 4, 2, '2026-07-04'),
    (4, 1, 1, '2026-07-22'),
    (5, 5, 5, '2026-07-05'),
    (5, 2, 1, '2026-07-25');
