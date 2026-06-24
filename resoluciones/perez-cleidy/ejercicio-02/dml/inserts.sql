PRAGMA foreign_keys = ON;

-- Ejercicio 02: Campus Shop
-- Inserte aqui los datos base.
-- Debe incluir datos suficientes para probar todas las consultas.

INSERT INTO productos (nombre_producto, precio) VALUES
('teléfono', 200.00),
('cámara', 500.00),
('laptop', 12000.00),
('mouse', 100.00),
('audífonos', 300.00),
('teclado', 350.00),
('vidrido templado', 20.00),
('reloj inteligente', 1000.00),
('estuche de telefono', 60.00),
('television', 1500.00),
('estuche de laptop', 150.00);

INSERT INTO categoria (nombre_categoria) VALUES
('telefonos'),
('relojes'),
('notebooks'),
('hogar'),
('audifonos');

INSERT INTO clientes(nombre, telefono, email, dpi) VALUES
('Juan', '23455669', 'juan097@gmail.com', '345670101'),
('María', '45632109', 'maria89@gmail.com', '568940101'),
('José', '90876543', 'jose96@gmail.com', '345690101'),
('Andres', '45760923', 'andres89@gmail.com', '549030101'),
('Stefani', '98745602', 'stefani78@gmail.com', '587540101');

INSERT INTO ventas (id_categoria, id_producto, cantidad, fecha, precio_total ) VALUES
(1, 1,1, '2026-06-11', 200),
(5, 5, 1,'2026-06-12', 300),
(4, 10, 1, '2026-06-02', 1500),
(2,8, 1, '2026-06-20', 1000),
(3, 3, 1, '2026-05-20', 12000);