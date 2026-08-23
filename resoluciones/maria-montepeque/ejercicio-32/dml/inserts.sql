-- Ejercicio 32: Normalizacion Pedidos Restaurante
-- Datos normalizados equivalentes a datos/datos-sin-normalizar.csv
-- (mesas 1-2, meseros 1-2, platos 1-6 y pedidos 1-3 vienen del CSV original;
--  el resto se agrega para cumplir el minimo de datos del ejercicio)

INSERT INTO mesas (numero) VALUES
    ('Mesa 4'),
    ('Mesa 2'),
    ('Mesa 1'),
    ('Mesa 3'),
    ('Mesa 5');

INSERT INTO meseros (nombre) VALUES
    ('Sofia Mendez'),
    ('Diego Ruiz'),
    ('Hector Aguilar'),
    ('Paola Sandoval'),
    ('Ricardo Solis');

INSERT INTO platos (nombre, categoria, precio) VALUES
    ('Pizza', 'Comida', 85.00),
    ('Limonada', 'Bebida', 18.00),
    ('Hamburguesa', 'Comida', 55.00),
    ('Papas', 'Acompanamiento', 22.00),
    ('Cafe', 'Bebida', 15.00),
    ('Pastel', 'Postre', 30.00);

INSERT INTO pedidos (id_mesa, id_mesero, fecha_pedido) VALUES
    (1, 1, '2026-06-01'),   -- pedido 1 del CSV: Mesa 4, Sofia Mendez
    (2, 1, '2026-06-01'),   -- pedido 2 del CSV: Mesa 2, Sofia Mendez
    (1, 2, '2026-06-02'),   -- pedido 3 del CSV: Mesa 4, Diego Ruiz
    (3, 3, '2026-06-03'),   -- pedido adicional
    (4, 4, '2026-06-04');   -- pedido adicional

INSERT INTO detalle_pedido (id_pedido, id_plato, cantidad, precio_unitario) VALUES
    -- pedido 1 (CSV): Pizza|Limonada, 85|18, 2|2
    (1, 1, 2, 85.00),
    (1, 2, 2, 18.00),
    -- pedido 2 (CSV): Hamburguesa|Papas, 55|22, 1|1
    (2, 3, 1, 55.00),
    (2, 4, 1, 22.00),
    -- pedido 3 (CSV): Cafe|Pastel, 15|30, 2|1
    (3, 5, 2, 15.00),
    (3, 6, 1, 30.00),
    -- pedidos adicionales para completar el minimo de 10 lineas de detalle
    (4, 1, 1, 85.00),
    (4, 5, 3, 15.00),
    (5, 3, 2, 55.00),
    (5, 2, 1, 18.00);

-- 2 casos comentados que deben fallar por restricciones
-- Falla por UNIQUE (el nombre de la mesa ya existe)
-- INSERT INTO mesas (numero) VALUES ('Mesa 4');

-- Falla por CHECK (la cantidad debe ser mayor a 0)
-- INSERT INTO detalle_pedido (id_pedido, id_plato, cantidad, precio_unitario) VALUES (1, 3, 0, 55.00);
