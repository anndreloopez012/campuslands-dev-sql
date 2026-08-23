PRAGMA foreign_keys = ON;

-- Ejercicio 57: CHECK Nivel Intermedio
-- Datos de prueba para validar el tema CHECK.

-- Casos validos: tipo_categoria dentro de la lista permitida.
INSERT INTO categorias (nombre_categoria, tipo_categoria) VALUES
    ('Laptops', 'hardware'),
    ('Antivirus', 'software'),
    ('Mochilas y fundas', 'accesorio');

-- Casos validos: precio_unitario > 0 y stock_minimo >= 0.
INSERT INTO productos (id_categoria, sku, nombre_producto, precio_unitario, stock_minimo) VALUES
    (1, 'LAP-001', 'Laptop Pro 14', 899.99, 3),
    (1, 'LAP-002', 'Laptop Basica 15', 549.50, 5),
    (2, 'SOF-001', 'Licencia Antivirus Anual', 39.90, 0),
    (2, 'SOF-002', 'Suite Ofimatica Anual', 59.00, 0),
    (3, 'ACC-001', 'Mochila para laptop', 24.75, 2);

-- Casos validos: tipo_movimiento dentro de la lista permitida y cantidad > 0.
INSERT INTO movimientos (id_producto, tipo_movimiento, cantidad, fecha_movimiento) VALUES
    (1, 'entrada', 20, '2026-07-01 09:00'),
    (1, 'salida', 5, '2026-07-10 14:00'),
    (2, 'entrada', 15, '2026-07-01 09:00'),
    (3, 'entrada', 100, '2026-07-02 10:00'),
    (3, 'salida', 30, '2026-07-15 16:00'),
    (5, 'entrada', 25, '2026-07-03 08:00'),
    (5, 'salida', 25, '2026-07-25 15:00');

-- Caso comentado que debe fallar (no ser recomendable), dejar comentado:
-- tipo_categoria fuera de la lista permitida por el CHECK de categorias.
-- INSERT INTO categorias (nombre_categoria, tipo_categoria) VALUES ('Cables', 'consumible');

-- Otro caso comentado que debe fallar: precio_unitario en cero o negativo
-- viola el CHECK de rango numerico en productos.
-- INSERT INTO productos (id_categoria, sku, nombre_producto, precio_unitario) VALUES (1, 'LAP-003', 'Laptop Gratis', 0);

-- Otro caso comentado que debe fallar: cantidad en cero o negativa viola el
-- CHECK de rango numerico en movimientos (un movimiento sin cantidad real
-- no deberia registrarse).
-- INSERT INTO movimientos (id_producto, tipo_movimiento, cantidad, fecha_movimiento) VALUES (1, 'entrada', -5, '2026-08-01 10:00');
