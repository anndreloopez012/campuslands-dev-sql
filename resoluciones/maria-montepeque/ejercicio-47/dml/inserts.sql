PRAGMA foreign_keys = ON;

-- Ejercicio 47: FOREIGN KEY Nivel Basico
-- Datos de prueba para validar el tema FOREIGN KEY.

INSERT INTO clientes (nombre, correo) VALUES
    ('Ana Ramirez', 'ana.ramirez@correo.com'),
    ('Luis Gomez', 'luis.gomez@correo.com'),
    ('Karla Diaz', 'karla.diaz@correo.com'),
    ('Pedro Suarez', 'pedro.suarez@correo.com'),
    ('Sofia Leon', 'sofia.leon@correo.com');

INSERT INTO productos (nombre, precio) VALUES
    ('Cafe americano', 15.00),
    ('Capuchino', 22.00),
    ('Sandwich de pollo', 38.00),
    ('Bagel con queso', 28.00),
    ('Pastel de chocolate', 25.00);

-- Caso valido: id_cliente e id_producto existen en sus catalogos.
INSERT INTO ventas (id_cliente, id_producto, cantidad, fecha_venta) VALUES
    (1, 1, 2, '2026-07-01'),
    (2, 2, 1, '2026-07-01'),
    (3, 3, 1, '2026-07-01'),
    (4, 1, 1, '2026-07-01'),
    (3, 4, 2, '2026-07-02'),
    (1, 2, 1, '2026-07-02'),
    (5, 3, 1, '2026-07-02'),
    (2, 4, 1, '2026-07-03'),
    (4, 2, 2, '2026-07-03'),
    (5, 1, 1, '2026-07-03');

-- Caso comentado que debe fallar (no ser recomendable), dejar comentado:
-- id_producto = 999 no existe en productos; la FOREIGN KEY lo rechaza.
-- INSERT INTO ventas (id_cliente, id_producto, cantidad, fecha_venta) VALUES (1, 999, 1, '2026-07-04');

-- Otro caso comentado que debe fallar: eliminar un producto que todavia
-- esta referenciado por ventas (id_producto = 1 aparece en varias ventas).
-- La FOREIGN KEY protege la integridad tambien al borrar, no solo al
-- insertar.
-- DELETE FROM productos WHERE id_producto = 1;
