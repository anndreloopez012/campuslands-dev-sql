PRAGMA foreign_keys = ON;

-- Ejercicio 75: UPDATE Nivel Intermedio
-- Datos de prueba y UPDATE de validacion.

INSERT INTO categorias (nombre_categoria) VALUES
    ('Laptops'),
    ('Perifericos'),
    ('Almacenamiento');

-- Productos con su stock inicial ya conocido de bodega.
INSERT INTO productos (nombre_producto, id_categoria, precio_unitario, stock_actual) VALUES
    ('Laptop Pro 14', 1, 8500.00, 10),
    ('Laptop Air 13', 1, 6200.00, 8),
    ('Mouse Inalambrico', 2, 150.00, 50),
    ('Teclado Mecanico', 2, 320.00, 30),
    ('Disco SSD 1TB', 3, 480.00, 20);

-- 1. Llega un reabastecimiento de Laptop Pro 14: se registra el
-- movimiento y, con un UPDATE de una sola fila y una expresion (no un
-- numero fijo), se suma la cantidad al stock actual.
INSERT INTO movimientos (id_producto, tipo_movimiento, cantidad) VALUES
    (1, 'entrada', 5);

UPDATE productos
SET stock_actual = stock_actual + 5
WHERE id_producto = 1;

-- 2. Se vende Mouse Inalambrico: se registra el movimiento y se resta
-- del stock con la misma tecnica.
INSERT INTO movimientos (id_producto, tipo_movimiento, cantidad) VALUES
    (3, 'salida', 12);

UPDATE productos
SET stock_actual = stock_actual - 12
WHERE id_producto = 3;

-- 3. UPDATE multiple: el proveedor de laptops subio precios un 10%.
-- Un solo UPDATE, con WHERE por categoria, ajusta el precio de todos
-- los productos de esa categoria a la vez (2 filas).
UPDATE productos
SET precio_unitario = ROUND(precio_unitario * 1.10, 2)
WHERE id_categoria = 1;

-- Caso comentado que debe fallar (no ser recomendable), dejar
-- comentado: restar mas unidades de las que hay en stock dejaria un
-- numero negativo, lo que viola el CHECK de stock_actual.
-- UPDATE productos SET stock_actual = stock_actual - 999 WHERE id_producto = 2;
