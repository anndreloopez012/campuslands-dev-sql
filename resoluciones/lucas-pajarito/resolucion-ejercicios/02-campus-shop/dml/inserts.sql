PRAGMA foreign_keys = ON;

-- Ejercicio 02: Campus Shop
-- Inserte aqui los datos base.
-- Debe incluir datos suficientes para probar todas las consultas.

-- ============================================
-- INSERCIÓN DE DATOS
-- Mínimo 10 registros por tabla
-- ============================================

-- ============================================
-- 1. CATEGORÍAS
-- ============================================

INSERT INTO categoria (nombre_categoria) VALUES
('Tecnologia'),
('Electronica'),
('Oficina'),
('Hogar'),
('Accesorios'),
('Computacion'),
('Audio'),
('Video'),
('Almacenamiento'),
('Redes');


-- ============================================
-- 2. PRODUCTOS
-- nombre_producto es INT según la estructura original
-- ============================================

INSERT INTO productos 
(nombre_producto, categoria, stock_actual, stock_minimo, precio) VALUES
(1001, 1, 25, 5, 1500.00),
(1002, 2, 18, 4, 850.00),
(1003, 3, 30, 8, 120.00),
(1004, 4, 15, 3, 450.00),
(1005, 5, 40, 10, 75.00),
(1006, 6, 20, 5, 2300.00),
(1007, 7, 12, 3, 650.00),
(1008, 8, 10, 2, 1800.00),
(1009, 9, 35, 7, 320.00),
(1010, 10, 22, 5, 550.00);


-- ============================================
-- 3. CLIENTES
-- ============================================

INSERT INTO clientes
(nombre, apellido, email, telefono) VALUES
('Carlos', 'Gomez', 'carlos.gomez@email.com', '55510001'),
('Ana', 'Torres', 'ana.torres@email.com', '55510002'),
('Luis', 'Martinez', 'luis.martinez@email.com', '55510003'),
('Maria', 'Lopez', 'maria.lopez@email.com', '55510004'),
('Pedro', 'Ramirez', 'pedro.ramirez@email.com', '55510005'),
('Sofia', 'Castillo', 'sofia.castillo@email.com', '55510006'),
('David', 'Morales', 'david.morales@email.com', '55510007'),
('Laura', 'Hernandez', 'laura.hernandez@email.com', '55510008'),
('Fernando', 'Perez', 'fernando.perez@email.com', '55510009'),
('Elena', 'Vargas', 'elena.vargas@email.com', '55510010');


-- ============================================
-- 4. VENTAS
-- ============================================

INSERT INTO ventas
(id_cliente, id_producto, cantidad, total) VALUES
(1, 1, 2, 3000.00),
(2, 2, 1, 850.00),
(3, 3, 3, 360.00),
(4, 4, 2, 900.00),
(5, 5, 5, 375.00),
(6, 6, 1, 2300.00),
(7, 7, 2, 1300.00),
(8, 8, 1, 1800.00),
(9, 9, 4, 1280.00),
(10, 10, 2, 1100.00);