PRAGMA foreign_keys = ON;

-- Ejercicio 31: Normalizacion Ventas Campus
-- Inserte aqui datos normalizados equivalentes al CSV original.
-- Agregue datos extra para probar consultas y restricciones.

-- Casos que deben fallar por restricciones, dejelos comentados:
-- INSERT INTO ...;

INSERT INTO cliente (nombre_cliente, cliente_email) VALUES 
('ana perez', 'ana@gmail.com'),
('carlos diaz', 'carlos@gmail.com'),
('maria lopez', 'marias@gmail.com');
('estiben ixen', 'estiben@gmail.com');
('wilder catu', 'wilder@gmail.com');

INSERT INTO producto (nombre_producto, precio, cantidad) VALUES 
('mouse gamer', 125, 200),
('teclado RGB', 260, 240),
('monitor 24"', 1450, 150),
('USB 64GB', 75, 154),
('base laptop', 180, 100);

INSERT INTO vendedor (nombre_vendedor, sucursal) VALUES
('luis rojas', 'sede norte'),
('marta lopez', 'sede centro'),
('juan perez', 'sede sur'),

INSERT INTO venta (id_cliente, id_producto, id_vendedor, fecha_venta, cantidad) VALUES
(1, 1, 1, '2024-01-15', 1),
(2, 2, 2, '2024-01-16', 1),
(3, 3, 3, '2024-01-17', 1),
(4, 4, 1, '2024-01-18', 2),
(5, 5, 2, '2024-01-19', 1);