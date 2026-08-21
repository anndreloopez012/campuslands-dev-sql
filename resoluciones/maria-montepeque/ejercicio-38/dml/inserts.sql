-- Ejercicio 38: Normalizacion Ecommerce Envios
-- Datos normalizados equivalentes a datos/datos-sin-normalizar.csv
-- (compradores 1-2, productos 1-5, cupon CAMPUS10 y las ordenes 1-3 con su
--  detalle, pago y envio vienen del CSV original; el resto se agrega para
--  cumplir el minimo de datos del ejercicio)

INSERT INTO compradores (nombre) VALUES
    ('Nadia Cruz'),
    ('Omar Valle'),
    ('Rosa Ical'),
    ('Hugo Sam'),
    ('Vivian Poroj');

INSERT INTO productos (nombre, precio) VALUES
    ('Audifonos', 120.00),
    ('Cable USB', 25.00),
    ('Laptop', 4500.00),
    ('Mochila', 180.00),
    ('Mouse', 45.00);

INSERT INTO cupones (codigo) VALUES
    ('CAMPUS10'),
    ('BIENVENIDA5'),
    ('ENVIOGRATIS'),
    ('VERANO15'),
    ('BLACKFRIDAY20');

-- id_cupon = NULL representa "SIN_CUPON" del CSV original (orden 2)
INSERT INTO ordenes (id_comprador, id_cupon) VALUES
    (1, 1),      -- orden 1 del CSV: Nadia Cruz, cupon CAMPUS10
    (2, NULL),   -- orden 2 del CSV: Omar Valle, SIN_CUPON
    (1, 1),      -- orden 3 del CSV: Nadia Cruz, cupon CAMPUS10 (otra orden)
    (3, 2),      -- orden adicional: Rosa Ical, cupon BIENVENIDA5
    (4, NULL),   -- orden adicional: Hugo Sam, sin cupon
    (5, 3);      -- orden adicional: Vivian Poroj, cupon ENVIOGRATIS

INSERT INTO detalle_orden (id_orden, id_producto, cantidad, precio_unitario) VALUES
    -- orden 1 (CSV): Audifonos|Cable USB
    (1, 1, 1, 120.00),
    (1, 2, 1, 25.00),
    -- orden 2 (CSV): Laptop|Mochila
    (2, 3, 1, 4500.00),
    (2, 4, 1, 180.00),
    -- orden 3 (CSV): Mouse|Audifonos
    (3, 5, 1, 45.00),
    (3, 1, 1, 120.00),
    -- ordenes adicionales para completar el minimo de 10 lineas de detalle
    (4, 5, 2, 45.00),
    (4, 2, 1, 25.00),
    (5, 3, 1, 4500.00),
    (5, 5, 1, 45.00),
    (6, 4, 1, 180.00),
    (6, 1, 2, 120.00);

INSERT INTO pagos (id_orden, metodo_pago, monto) VALUES
    (1, 'Tarjeta', 145.00),
    (2, 'Transferencia', 4680.00),
    (3, 'Tarjeta', 165.00),
    (4, 'Tarjeta', 115.00),
    (5, 'Transferencia', 4545.00),
    (6, 'Tarjeta', 420.00);

INSERT INTO envios (id_orden, direccion_envio, transportadora) VALUES
    (1, 'Zona 1', 'FastShip'),
    (2, 'Zona 10', 'CargoGT'),
    (3, 'Zona 1', 'FastShip'),
    (4, 'Zona 5', 'CargoGT'),
    (5, 'Zona 3', 'FastShip'),
    (6, 'Zona 7', 'CargoGT');

-- 2 casos comentados que deben fallar por restricciones
-- Falla por UNIQUE (cupones.codigo): el cupon ya existe
-- INSERT INTO cupones (codigo) VALUES ('CAMPUS10');

-- Falla por CHECK (cantidad > 0)
-- INSERT INTO detalle_orden (id_orden, id_producto, cantidad, precio_unitario) VALUES (1, 3, 0, 4500.00);
