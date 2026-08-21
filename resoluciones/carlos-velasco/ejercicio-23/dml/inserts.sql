PRAGMA foreign_keys = ON;

-- CLIENTES

INSERT INTO clientes (
    id_cliente,
    nombre_completo,
    documento,
    correo,
    telefono
) VALUES
(1, 'Carlos Velasco', 'CV100001', 'carlos.velasco@email.com', '55510001'),
(2, 'Ana Martinez', 'AM100002', 'ana.martinez@email.com', '55510002'),
(3, 'Luis Hernandez', 'LH100003', 'luis.hernandez@email.com', '55510003'),
(4, 'Sofia Ramirez', 'SR100004', 'sofia.ramirez@email.com', '55510004'),
(5, 'Diego Castillo', 'DC100005', 'diego.castillo@email.com', '55510005');

-- PRODUCTOS

INSERT INTO productos (
    id_producto,
    nombre,
    descripcion,
    precio,
    stock
) VALUES
(1, 'Laptop Pro 14', 'Laptop para trabajo y desarrollo', 1250.00, 18),
(2, 'Monitor 27', 'Monitor IPS de 27 pulgadas', 320.00, 25),
(3, 'Teclado Mecanico', 'Teclado mecanico compacto', 95.00, 40),
(4, 'Mouse Inalambrico', 'Mouse ergonomico inalambrico', 45.00, 50),
(5, 'Auriculares Pro', 'Auriculares con cancelacion de ruido', 180.00, 30);

-- FACTURAS

INSERT INTO facturas (
    id_factura,
    id_cliente,
    numero_factura,
    fecha,
    impuesto,
    estado
) VALUES
(1, 1, 'FAC-2026-001', '2026-08-01', 0.19, 'PAGADA'),
(2, 2, 'FAC-2026-002', '2026-08-02', 0.19, 'PAGADA'),
(3, 3, 'FAC-2026-003', '2026-08-03', 0.19, 'EMITIDA'),
(4, 4, 'FAC-2026-004', '2026-08-04', 0.19, 'PAGADA'),
(5, 5, 'FAC-2026-005', '2026-08-05', 0.19, 'EMITIDA');

-- DETALLE DE FACTURAS

INSERT INTO detalle_factura (
    id_detalle,
    id_factura,
    id_producto,
    cantidad,
    precio_unitario
) VALUES
(1, 1, 1, 1, 1250.00),
(2, 1, 3, 2, 95.00),
(3, 2, 2, 1, 320.00),
(4, 2, 4, 2, 45.00),
(5, 3, 5, 1, 180.00),
(6, 3, 3, 1, 95.00),
(7, 4, 1, 1, 1250.00),
(8, 4, 4, 1, 45.00),
(9, 5, 2, 2, 320.00),
(10, 5, 5, 1, 180.00);