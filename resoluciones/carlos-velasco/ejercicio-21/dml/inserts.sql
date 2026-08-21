PRAGMA foreign_keys = ON;

-- CLIENTES

INSERT INTO clientes (id_cliente, nombre_completo, correo, telefono, ciudad)
VALUES
    (1, 'Ana Martinez', 'ana.martinez@email.com', '555-1001', 'Ciudad de Guatemala'),
    (2, 'Carlos Lopez', 'carlos.lopez@email.com', '555-1002', 'Quetzaltenango'),
    (3, 'Maria Gonzalez', 'maria.gonzalez@email.com', '555-1003', 'Escuintla'),
    (4, 'Diego Ramirez', 'diego.ramirez@email.com', '555-1004', 'Antigua Guatemala'),
    (5, 'Sofia Hernandez', 'sofia.hernandez@email.com', '555-1005', 'Cobán');

-- RUTAS

INSERT INTO rutas (id_ruta, origen, destino, distancia_km)
VALUES
    (1, 'Ciudad de Guatemala', 'Quetzaltenango', 201.0),
    (2, 'Ciudad de Guatemala', 'Escuintla', 59.0),
    (3, 'Ciudad de Guatemala', 'Antigua Guatemala', 45.0),
    (4, 'Ciudad de Guatemala', 'Cobán', 216.0),
    (5, 'Quetzaltenango', 'Huehuetenango', 87.0);

-- PAQUETES

INSERT INTO paquetes (id_paquete, id_cliente, peso_kg, tipo, descripcion)
VALUES
    (1, 1, 1.20, 'CAJA', 'Accesorios de computadora'),
    (2, 2, 0.80, 'SOBRE', 'Documentos empresariales'),
    (3, 3, 4.50, 'CAJA', 'Repuestos automotrices'),
    (4, 4, 2.30, 'CAJA', 'Productos artesanales'),
    (5, 5, 0.50, 'DOCUMENTO', 'Contrato firmado'),
    (6, 1, 3.80, 'CAJA', 'Equipo de oficina'),
    (7, 2, 1.10, 'CAJA', 'Libros tecnicos'),
    (8, 3, 0.70, 'SOBRE', 'Facturas comerciales'),
    (9, 4, 6.20, 'CAJA', 'Herramientas'),
    (10, 5, 2.00, 'CAJA', 'Ropa y accesorios');

-- ENVIOS

INSERT INTO envios (
    id_envio,
    id_paquete,
    id_ruta,
    fecha_envio,
    fecha_entrega,
    estado,
    costo
)
VALUES
    (1, 1, 1, '2026-08-01', '2026-08-03', 'ENTREGADO', 85.00),
    (2, 2, 2, '2026-08-02', '2026-08-02', 'ENTREGADO', 45.00),
    (3, 3, 3, '2026-08-03', '2026-08-04', 'ENTREGADO', 60.00),
    (4, 4, 4, '2026-08-04', NULL, 'EN_TRANSITO', 95.00),
    (5, 5, 5, '2026-08-05', '2026-08-06', 'ENTREGADO', 55.00),
    (6, 6, 1, '2026-08-06', NULL, 'EN_TRANSITO', 90.00),
    (7, 7, 2, '2026-08-07', NULL, 'PENDIENTE', 48.00),
    (8, 8, 3, '2026-08-08', '2026-08-09', 'ENTREGADO', 42.00),
    (9, 9, 4, '2026-08-09', NULL, 'EN_TRANSITO', 110.00),
    (10, 10, 5, '2026-08-10', NULL, 'PENDIENTE', 65.00);