-- Ejercicio 31: Normalizacion Ventas Campus
-- Datos normalizados equivalentes a datos/datos-sin-normalizar.csv
-- (clientes 1-2, vendedores 1-2, productos 1-5 y ventas 1-3 vienen del CSV original;
--  el resto se agrega para cumplir el minimo de datos del ejercicio)

INSERT INTO clientes (nombre, email) VALUES
    ('Ana Perez', 'ana@mail.com'),
    ('Carlos Diaz', 'carlos@mail.com'),
    ('Byron Xicay', 'byron.xicay@correo.com'),
    ('Cristina Barrios', 'cristina.barrios@correo.com'),
    ('Douglas Pineda', 'douglas.pineda@correo.com');

INSERT INTO productos (nombre, precio_unitario) VALUES
    ('Mouse Gamer', 125.00),
    ('Teclado RGB', 260.00),
    ('Monitor 24', 1450.00),
    ('USB 64GB', 75.00),
    ('Base Laptop', 180.00);

INSERT INTO vendedores (nombre, sucursal) VALUES
    ('Luis Rojas', 'Sede Norte'),
    ('Marta Lopez', 'Sede Centro'),
    ('Hector Aguilar', 'Sede Sur'),
    ('Paola Sandoval', 'Sede Occidente'),
    ('Ricardo Solis', 'Sede Norte');

INSERT INTO ventas (id_cliente, id_vendedor, fecha) VALUES
    (1, 1, '2026-07-01'),   -- venta 1 del CSV: Ana Perez, Luis Rojas, Sede Norte
    (2, 2, '2026-07-02'),   -- venta 2 del CSV: Carlos Diaz, Marta Lopez, Sede Centro
    (1, 1, '2026-07-03'),   -- venta 3 del CSV: Ana Perez, Luis Rojas, Sede Norte
    (3, 3, '2026-07-04'),   -- venta adicional
    (4, 4, '2026-07-05');   -- venta adicional

INSERT INTO detalle_venta (id_venta, id_producto, cantidad, precio_unitario) VALUES
    -- venta 1 (CSV): Mouse Gamer|Teclado RGB, 125|260, 1|2
    (1, 1, 1, 125.00),
    (1, 2, 2, 260.00),
    -- venta 2 (CSV): Monitor 24|Mouse Gamer, 1450|125, 1|1
    (2, 3, 1, 1450.00),
    (2, 1, 1, 125.00),
    -- venta 3 (CSV): USB 64GB|Base Laptop, 75|180, 3|1
    (3, 4, 3, 75.00),
    (3, 5, 1, 180.00),
    -- ventas adicionales para completar el minimo de 10 lineas de detalle
    (4, 2, 1, 260.00),
    (4, 5, 2, 180.00),
    (5, 1, 2, 125.00),
    (5, 3, 1, 1450.00);
