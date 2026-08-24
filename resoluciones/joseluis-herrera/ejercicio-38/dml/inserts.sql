INSERT INTO compradores (
    id_comprador,
    nombre_completo,
    documento,
    email,
    telefono
) VALUES
(1, 'Carlos Mendoza', 'CMP10001', 'carlos.mendoza@example.com', '55510001'),
(2, 'Ana Lopez', 'CMP10002', 'ana.lopez@example.com', '55510002'),
(3, 'Miguel Ramirez', 'CMP10003', 'miguel.ramirez@example.com', '55510003'),
(4, 'Sofia Castillo', 'CMP10004', 'sofia.castillo@example.com', '55510004'),
(5, 'Daniel Morales', 'CMP10005', 'daniel.morales@example.com', '55510005'),
(6, 'Laura Perez', 'CMP10006', 'laura.perez@example.com', '55510006');

INSERT INTO productos (
    id_producto,
    nombre,
    categoria,
    precio,
    stock
) VALUES
(1, 'Laptop Lenovo IdeaPad', 'Computadores', 4200.00, 15),
(2, 'Mouse Logitech M185', 'Accesorios', 85.00, 50),
(3, 'Teclado Logitech K380', 'Accesorios', 240.00, 30),
(4, 'Monitor Samsung 24', 'Monitores', 1150.00, 20),
(5, 'Audifonos Sony WH-CH520', 'Audio', 450.00, 25),
(6, 'Disco SSD Kingston 1TB', 'Almacenamiento', 650.00, 18),
(7, 'Webcam Logitech C920', 'Accesorios', 620.00, 12),
(8, 'Tablet Samsung Galaxy Tab', 'Tablets', 1850.00, 10);

INSERT INTO cupones (
    id_cupon,
    codigo,
    descuento,
    fecha_inicio,
    fecha_fin,
    estado
) VALUES
(1, 'BIENVENIDA10', 10.00, '2026-01-01', '2026-12-31', 'activo'),
(2, 'CAMPUS15', 15.00, '2026-01-01', '2026-12-31', 'activo'),
(3, 'TECH20', 20.00, '2026-06-01', '2026-09-30', 'activo'),
(4, 'VERANO5', 5.00, '2026-07-01', '2026-08-31', 'activo'),
(5, 'VIP25', 25.00, '2026-01-01', '2026-12-31', 'activo');

INSERT INTO transportadoras (
    id_transportadora,
    nombre,
    telefono,
    estado
) VALUES
(1, 'Cargo Express', '55520001', 'activa'),
(2, 'Guatex', '55520002', 'activa'),
(3, 'Forza', '55520003', 'activa'),
(4, 'DHL', '55520004', 'activa'),
(5, 'FedEx', '55520005', 'activa');

INSERT INTO ordenes (
    id_orden,
    id_comprador,
    id_cupon,
    fecha_orden,
    direccion_envio,
    estado
) VALUES
(1, 1, 1, '2026-08-01', 'Zona 1, Ciudad de Guatemala', 'entregada'),
(2, 2, 2, '2026-08-02', 'Zona 10, Ciudad de Guatemala', 'entregada'),
(3, 3, NULL, '2026-08-04', 'Zona 11, Ciudad de Guatemala', 'enviada'),
(4, 4, 3, '2026-08-05', 'Zona 15, Ciudad de Guatemala', 'procesando'),
(5, 5, 4, '2026-08-07', 'Zona 7, Ciudad de Guatemala', 'enviada'),
(6, 6, NULL, '2026-08-09', 'Zona 12, Ciudad de Guatemala', 'entregada'),
(7, 1, 5, '2026-08-11', 'Zona 1, Ciudad de Guatemala', 'pendiente'),
(8, 2, NULL, '2026-08-13', 'Zona 10, Ciudad de Guatemala', 'procesando');

INSERT INTO detalle_orden (
    id_detalle,
    id_orden,
    id_producto,
    cantidad,
    precio_unitario
) VALUES
(1, 1, 1, 1, 4200.00),
(2, 1, 2, 2, 85.00),
(3, 2, 3, 1, 240.00),
(4, 2, 4, 1, 1150.00),
(5, 3, 5, 2, 450.00),
(6, 3, 6, 1, 650.00),
(7, 4, 7, 1, 620.00),
(8, 4, 2, 1, 85.00),
(9, 5, 8, 1, 1850.00),
(10, 5, 5, 1, 450.00),
(11, 6, 6, 2, 650.00),
(12, 6, 3, 1, 240.00),
(13, 7, 1, 1, 4200.00),
(14, 7, 7, 1, 620.00),
(15, 8, 4, 2, 1150.00),
(16, 8, 2, 3, 85.00);

INSERT INTO pagos (
    id_pago,
    id_orden,
    metodo_pago,
    monto,
    fecha_pago,
    estado
) VALUES
(1, 1, 'tarjeta', 4370.00, '2026-08-01', 'aprobado'),
(2, 2, 'transferencia', 1390.00, '2026-08-02', 'aprobado'),
(3, 3, 'paypal', 1550.00, '2026-08-04', 'aprobado'),
(4, 4, 'tarjeta', 705.00, '2026-08-05', 'aprobado'),
(5, 5, 'tarjeta', 2300.00, '2026-08-07', 'aprobado'),
(6, 6, 'transferencia', 1540.00, '2026-08-09', 'aprobado'),
(7, 7, 'paypal', 4820.00, '2026-08-11', 'pendiente'),
(8, 8, 'tarjeta', 2555.00, '2026-08-13', 'aprobado');

INSERT INTO envios (
    id_envio,
    id_orden,
    id_transportadora,
    numero_guia,
    fecha_envio,
    fecha_entrega,
    estado
) VALUES
(1, 1, 1, 'CE100001', '2026-08-02', '2026-08-04', 'entregado'),
(2, 2, 2, 'GX100002', '2026-08-03', '2026-08-05', 'entregado'),
(3, 3, 3, 'FZ100003', '2026-08-05', NULL, 'en_transito'),
(4, 5, 4, 'DH100005', '2026-08-08', NULL, 'en_transito'),
(5, 6, 5, 'FX100006', '2026-08-10', '2026-08-13', 'entregado'),
(6, 4, 1, 'CE100004', NULL, NULL, 'preparando');

-- CASO INVALIDO 1
-- INSERT INTO productos (id_producto, nombre, categoria, precio, stock)
-- VALUES (9, 'Laptop Lenovo IdeaPad', 'Computadores', 4500.00, 5);

-- CASO INVALIDO 2
-- INSERT INTO detalle_orden (id_detalle, id_orden, id_producto, cantidad, precio_unitario)
-- VALUES (17, 1, 1, 2, 4200.00);