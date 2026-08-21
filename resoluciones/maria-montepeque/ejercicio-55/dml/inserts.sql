PRAGMA foreign_keys = ON;

-- Ejercicio 55: NOT NULL Nivel Aplicado
-- Datos de prueba para validar el tema NOT NULL.

-- descripcion se deja NULL en dos categorias: es un campo opcional, y
-- NOT NULL no lo exige.
INSERT INTO categorias (nombre_categoria, descripcion) VALUES
    ('Laptops', 'Equipos portatiles para uso general y desarrollo'),
    ('Monitores', NULL),
    ('Perifericos', 'Teclados, mouse y accesorios de entrada'),
    ('Accesorios', NULL);

-- descripcion tambien se deja NULL en algunos productos: es opcional, la
-- ficha tecnica ampliada no siempre esta lista al momento de dar de alta.
INSERT INTO productos (id_categoria, sku, nombre_producto, descripcion) VALUES
    (1, 'LAP-001', 'Laptop Pro 14', '16GB RAM, 512GB SSD'),
    (1, 'LAP-002', 'Laptop Basica 15', NULL),
    (2, 'MON-001', 'Monitor 24 pulgadas', '1920x1080, IPS'),
    (2, 'MON-002', 'Monitor 27 pulgadas', NULL),
    (3, 'PER-001', 'Teclado mecanico', 'Switches rojos, retroiluminado'),
    (4, 'ACC-001', 'Mochila para laptop', NULL);

-- observaciones se deja NULL en los movimientos normales de bodega: es
-- opcional, solo se anota cuando hay algo particular que registrar.
INSERT INTO movimientos (id_producto, tipo_movimiento, cantidad, fecha_movimiento, observaciones) VALUES
    (1, 'entrada', 20, '2026-07-01 09:00', 'Compra inicial a proveedor'),
    (1, 'salida', 5, '2026-07-10 14:00', NULL),
    (2, 'entrada', 15, '2026-07-01 09:00', NULL),
    (2, 'salida', 3, '2026-07-12 11:00', NULL),
    (3, 'entrada', 30, '2026-07-02 10:00', NULL),
    (3, 'salida', 10, '2026-07-15 16:00', NULL),
    (4, 'entrada', 10, '2026-07-02 10:00', NULL),
    (5, 'entrada', 50, '2026-07-03 08:00', 'Compra por volumen'),
    (5, 'salida', 12, '2026-07-18 09:00', NULL),
    (5, 'salida', 3, '2026-07-20 09:00', 'Devolucion a proveedor por defecto de fabrica'),
    (6, 'entrada', 25, '2026-07-03 08:00', NULL),
    (6, 'salida', 25, '2026-07-25 15:00', NULL);

-- Caso valido: descripcion y observaciones pueden faltar (NULL) sin
-- problema, porque no llevan NOT NULL.
INSERT INTO productos (id_categoria, sku, nombre_producto, descripcion) VALUES
    (3, 'PER-002', 'Mouse inalambrico', NULL);

-- Caso comentado que debe fallar (no ser recomendable), dejar comentado:
-- nombre_producto es NOT NULL en productos; omitirlo (o pasar NULL
-- explicito) falla.
-- INSERT INTO productos (id_categoria, sku, nombre_producto) VALUES (1, 'LAP-003', NULL);

-- Otro caso comentado que debe fallar: cantidad es NOT NULL en
-- movimientos; un movimiento sin cantidad no se puede auditar y la base lo
-- rechaza.
-- INSERT INTO movimientos (id_producto, tipo_movimiento, cantidad, fecha_movimiento) VALUES (1, 'entrada', NULL, '2026-08-01 10:00');
