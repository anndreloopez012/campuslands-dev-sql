PRAGMA foreign_keys = ON;

-- Ejercicio 77: DELETE Nivel Basico
-- Datos de prueba y DELETE de validacion.

INSERT INTO categorias (nombre_categoria) VALUES
    ('Laptops'),
    ('Perifericos'),
    ('Almacenamiento');

INSERT INTO productos (nombre_producto, id_categoria, precio_unitario) VALUES
    ('Laptop Pro 14', 1, 8500.00),
    ('Laptop Air 13', 1, 6200.00),
    ('Mouse Inalambrico', 2, 150.00),
    ('Teclado Mecanico', 2, 320.00),
    ('Disco SSD 1TB', 3, 480.00);

INSERT INTO movimientos (id_producto, tipo_movimiento, cantidad) VALUES
    (1, 'entrada', 10),
    (2, 'entrada', 8),
    (3, 'entrada', 50),
    (4, 'entrada', 30),
    (5, 'entrada', 20);

-- Movimiento cargado dos veces por error de digitacion (misma entrada
-- de Mouse Inalambrico registrada dos veces).
INSERT INTO movimientos (id_producto, tipo_movimiento, cantidad) VALUES
    (3, 'entrada', 50);

-- 1. DELETE real (baja fisica): el movimiento duplicado no tiene
-- ningun dependiente y es un error de captura, asi que se elimina de
-- verdad, con WHERE por id especifico.
DELETE FROM movimientos
WHERE id_movimiento = 6;

-- 2. Baja logica (no DELETE): Teclado Mecanico se descontinua, pero
-- no se puede borrar de verdad porque movimientos todavia lo
-- referencia por FOREIGN KEY. En vez de eso, se marca como inactivo.
UPDATE productos
SET activo = 0
WHERE id_producto = 4;

-- Caso comentado que debe fallar (no ser recomendable), dejar
-- comentado: intentar el DELETE fisico de un producto que todavia
-- tiene movimientos asociados. SQLite, con
-- PRAGMA foreign_keys = ON, no lo permite. Esto es justo lo que
-- justifica usar baja logica (UPDATE activo = 0) en vez de DELETE
-- para productos.
-- DELETE FROM productos WHERE id_producto = 4;
