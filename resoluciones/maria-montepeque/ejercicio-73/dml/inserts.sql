PRAGMA foreign_keys = ON;

-- Ejercicio 73: INSERT Nivel Aplicado
-- Datos de prueba para validar el tema INSERT.

-- 1. INSERT de una sola fila: se registra la primera categoria.
INSERT INTO categorias (nombre_categoria) VALUES
    ('Laptops');

-- 2. INSERT multiple: el resto de categorias.
INSERT INTO categorias (nombre_categoria) VALUES
    ('Perifericos'),
    ('Almacenamiento');

-- 3. INSERT multiple de productos, con todas las columnas explicitas.
INSERT INTO productos (nombre_producto, id_categoria, precio_unitario) VALUES
    ('Laptop Pro 14', 1, 8500.00),
    ('Laptop Air 13', 1, 6200.00),
    ('Mouse Inalambrico', 2, 150.00),
    ('Teclado Mecanico', 2, 320.00),
    ('Disco SSD 1TB', 3, 480.00);

-- 4. INSERT multiple: entradas iniciales de bodega (una por
-- producto), con tipo_movimiento explicito.
INSERT INTO movimientos (id_producto, tipo_movimiento, cantidad) VALUES
    (1, 'entrada', 10),
    (2, 'entrada', 8),
    (3, 'entrada', 50),
    (4, 'entrada', 30),
    (5, 'entrada', 20);

-- 5. INSERT multiple: salidas por ventas o uso interno.
INSERT INTO movimientos (id_producto, tipo_movimiento, cantidad) VALUES
    (1, 'salida', 3),
    (3, 'salida', 12),
    (4, 'salida', 7),
    (5, 'salida', 4),
    (2, 'salida', 2);

-- 6. INSERT SIN indicar tipo_movimiento: se omite a proposito para
-- que quede en su DEFAULT ('entrada'). Reabastecimiento de laptops
-- Pro 14 despues de la salida anterior.
INSERT INTO movimientos (id_producto, cantidad) VALUES
    (1, 5);

-- Casos comentados que deben fallar (no ser recomendables), dejar
-- comentados:

-- 1) Registro repetido: nombre_producto ya existe, viola el UNIQUE.
-- INSERT INTO productos (nombre_producto, id_categoria, precio_unitario) VALUES ('Laptop Pro 14', 1, 9000.00);

-- 2) Relacion invalida: id_producto = 99 no existe, viola el FOREIGN KEY.
-- INSERT INTO movimientos (id_producto, tipo_movimiento, cantidad) VALUES (99, 'entrada', 5);

-- 3) Valor fuera de rango: cantidad negativa, viola el CHECK.
-- INSERT INTO movimientos (id_producto, tipo_movimiento, cantidad) VALUES (2, 'entrada', -10);
