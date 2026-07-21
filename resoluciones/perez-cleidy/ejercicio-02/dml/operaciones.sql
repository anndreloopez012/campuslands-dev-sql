PRAGMA foreign_keys = ON;

-- Ejercicio 02: Campus Shop
-- Agregue aqui INSERT, UPDATE y DELETE adicionales.

-- INSERT validos:
INSERT INTO clientes (nombre, telefono, email, dpi) VALUES
('Carlos', '55443322', 'carlos.dev@gmail.com', '123450101');

INSERT INTO ventas (id_categoria, id_producto, cantidad, fecha, precio_total) VALUES
(3, 3, 2, '2026-06-23', 24000.00);
-- UPDATE validos con WHERE:

UPDATE productos 
SET precio = 1600.00 
WHERE nombre_producto = 'television';

UPDATE productos 
SET nombre_producto = 'vidrio templado' 
WHERE nombre_producto = 'vidrido templado';

-- DELETE controlados con WHERE:
DELETE FROM productos 
WHERE nombre_producto = 'estuche de laptop';

DELETE FROM clientes 
WHERE dpi = '549030101';
-- Casos que deben fallar por restricciones, dejelos comentados:
-- ERROR 1: Violación de Restricción UNIQUE (o PRIMARY KEY) en la tabla Clientes
-- Intento de insertar un cliente con un DPI que ya existe en la base de datos (el de Juan).
-- INSERT INTO clientes (nombre, telefono, email, dpi) VALUES ('Pedro', '11223344', 'pedro@gmail.com', '345670101');


-- ERROR 2: Violación de Restricción FOREIGN KEY (Clave Foránea) en la tabla Ventas
-- Intento de registrar una venta con un 'id_producto' (99) que NO existe en la tabla productos.
-- INSERT INTO ventas (id_categoria, id_producto, cantidad, fecha, precio_total) VALUES (1, 99, 1, '2026-06-23', 500.00);
-- INSERT INTO ...;
