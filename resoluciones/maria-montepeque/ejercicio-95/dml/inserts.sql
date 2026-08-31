PRAGMA foreign_keys = ON;

-- Ejercicio 95: JOIN Nivel Basico
-- Datos de prueba: 4 categorias (una sin productos todavia), 5 productos.

INSERT INTO categorias (nombre_categoria) VALUES
    ('Laptops'),
    ('Perifericos'),
    ('Almacenamiento'),
    ('Redes');
    -- 'Redes' se deja sin productos a proposito, para demostrar el LEFT JOIN.

INSERT INTO productos (id_categoria, nombre_producto, precio_unitario) VALUES
    (1, 'Laptop Pro 15',      8500.00),
    (2, 'Mouse Inalambrico',   120.00),
    (2, 'Teclado Mecanico',    250.00),
    (3, 'Disco SSD 1TB',       450.00),
    (1, 'Laptop Basica 14',   4200.00);

-- Caso comentado que no se debe hacer, dejar comentado: registrar un
-- producto con precio negativo. El CHECK (precio_unitario >= 0) lo rechaza.
-- INSERT INTO productos (id_categoria, nombre_producto, precio_unitario) VALUES (1, 'Laptop Danada', -100.00);
