PRAGMA foreign_keys = ON;

-- Ejercicio 02: Campus Shop SQLite
-- Operaciones adicionales

-- INSERT validos:
INSERT INTO productos (nombre_producto, id_categoria, cantidad_stock, precio)
    VALUES ('Router TP-Link AX', 5, 15, 650.00);

INSERT INTO ventas (id_cliente, id_producto, cantidad, fecha_venta)
    VALUES (1, 3, 1, '2026-08-22');

-- UPDATE validos con WHERE:
UPDATE productos
    SET precio = 5800.00
    WHERE nombre_producto = 'Laptop Lenovo IdeaPad';

UPDATE clientes
    SET direccion = 'Zona 12, Guatemala'
    WHERE id_cliente = 3;

-- DELETE controlados con WHERE:
DELETE FROM ventas
    WHERE id_venta = 10;

DELETE FROM productos
    WHERE cantidad_stock = 0 AND id_producto NOT IN (SELECT id_producto FROM ventas);

-- Casos que deben fallar por restricciones, dejelos comentados:
-- Viola UNIQUE en clientes.telefono:
-- INSERT INTO clientes (nombre_cliente, telefono) VALUES ('Otro Cliente', '5551234');

-- Viola CHECK en productos.precio (precio <= 0):
-- INSERT INTO productos (nombre_producto, id_categoria, cantidad_stock, precio) VALUES ('Producto Gratis', 1, 10, 0);
