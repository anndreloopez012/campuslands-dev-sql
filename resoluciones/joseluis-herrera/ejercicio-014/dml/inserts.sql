INSERT INTO vendedores (id_vendedor, nombre, email, telefono) VALUES
(1, 'Tech Solutions', 'ventas@techsolutions.com', '55510001'),
(2, 'Digital World', 'ventas@digitalworld.com', '55510002'),
(3, 'Gadget Store', 'ventas@gadgetstore.com', '55510003'),
(4, 'Smart Market', 'ventas@smartmarket.com', '55510004'),
(5, 'Campus Tech', 'ventas@campustech.com', '55510005');

INSERT INTO compradores (id_comprador, nombre, email, ciudad) VALUES
(1, 'Ana Lopez', 'ana.lopez@gmail.com', 'Guatemala'),
(2, 'Carlos Perez', 'carlos.perez@gmail.com', 'Mixco'),
(3, 'Maria Garcia', 'maria.garcia@gmail.com', 'Villa Nueva'),
(4, 'Luis Ramirez', 'luis.ramirez@gmail.com', 'Antigua Guatemala'),
(5, 'Sofia Martinez', 'sofia.martinez@gmail.com', 'Escuintla');

INSERT INTO productos (id_producto, id_vendedor, nombre, sku, precio, stock) VALUES
(1, 1, 'Laptop Lenovo IdeaPad', 'SKU-LAP-001', 4500.00, 12),
(2, 1, 'Mouse Logitech M185', 'SKU-MOU-001', 120.00, 50),
(3, 2, 'Teclado Redragon K552', 'SKU-TEC-001', 350.00, 25),
(4, 2, 'Monitor Samsung 24', 'SKU-MON-001', 1350.00, 15),
(5, 3, 'Audifonos HyperX Cloud', 'SKU-AUD-001', 650.00, 20),
(6, 3, 'Webcam Logitech C920', 'SKU-WEB-001', 850.00, 10),
(7, 4, 'SSD Kingston 1TB', 'SKU-SSD-001', 900.00, 18),
(8, 4, 'Memoria RAM 16GB', 'SKU-RAM-001', 550.00, 30),
(9, 5, 'Tablet Samsung A9', 'SKU-TAB-001', 1800.00, 8),
(10, 5, 'Cargador USB-C 65W', 'SKU-CAR-001', 280.00, 40);

INSERT INTO ordenes (
    id_orden,
    id_comprador,
    id_producto,
    fecha,
    cantidad,
    precio_unitario,
    estado
) VALUES
(1, 1, 1, '2026-08-01', 1, 4500.00, 'entregada'),
(2, 2, 2, '2026-08-02', 2, 120.00, 'entregada'),
(3, 3, 3, '2026-08-03', 1, 350.00, 'enviada'),
(4, 4, 4, '2026-08-04', 1, 1350.00, 'pagada'),
(5, 5, 5, '2026-08-05', 2, 650.00, 'entregada'),
(6, 1, 6, '2026-08-06', 1, 850.00, 'entregada'),
(7, 2, 7, '2026-08-07', 2, 900.00, 'enviada'),
(8, 3, 8, '2026-08-08', 1, 550.00, 'pagada'),
(9, 4, 9, '2026-08-09', 1, 1800.00, 'pendiente'),
(10, 5, 10, '2026-08-10', 3, 280.00, 'entregada');