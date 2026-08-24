INSERT INTO categorias (
    id_categoria,
    nombre,
    descripcion
) VALUES
(1, 'Electrónica', 'Productos electrónicos'),
(2, 'Oficina', 'Artículos y suministros de oficina'),
(3, 'Mobiliario', 'Muebles para espacios de trabajo'),
(4, 'Accesorios', 'Accesorios tecnológicos y de oficina'),
(5, 'Limpieza', 'Productos para limpieza'),
(6, 'Seguridad', 'Productos y equipos de seguridad');

INSERT INTO proveedores (
    id_proveedor,
    nombre,
    telefono,
    email,
    estado
) VALUES
(1, 'Tech Supplies Guatemala', '55510001', 'ventas@techsupplies.com', 'activo'),
(2, 'Oficina Total', '55510002', 'contacto@oficinatotal.com', 'activo'),
(3, 'Muebles Corporativos', '55510003', 'ventas@mueblescorp.com', 'activo'),
(4, 'Accesorios GT', '55510004', 'info@accesoriosgt.com', 'activo'),
(5, 'Limpieza Profesional', '55510005', 'ventas@limpiezaprof.com', 'activo'),
(6, 'Seguridad Integral', '55510006', 'contacto@seguridadint.com', 'activo');

INSERT INTO bodegas (
    id_bodega,
    nombre,
    ubicacion,
    capacidad,
    estado
) VALUES
(1, 'Bodega Central', 'Zona 1', 1000, 'activa'),
(2, 'Bodega Norte', 'Zona 18', 750, 'activa'),
(3, 'Bodega Sur', 'Zona 12', 600, 'activa'),
(4, 'Bodega Administrativa', 'Zona 10', 400, 'activa'),
(5, 'Bodega Temporal', 'Zona 7', 300, 'activa');

INSERT INTO productos (
    id_producto,
    nombre,
    id_categoria,
    id_proveedor,
    precio_unitario,
    stock_minimo,
    estado
) VALUES
(1, 'Laptop empresarial', 1, 1, 6500.00, 5, 'activo'),
(2, 'Monitor 24 pulgadas', 1, 1, 1450.00, 8, 'activo'),
(3, 'Teclado mecánico', 4, 4, 450.00, 10, 'activo'),
(4, 'Mouse inalámbrico', 4, 4, 175.00, 15, 'activo'),
(5, 'Resma de papel', 2, 2, 55.00, 20, 'activo'),
(6, 'Escritorio ejecutivo', 3, 3, 1850.00, 5, 'activo'),
(7, 'Silla ergonómica', 3, 3, 1250.00, 8, 'activo'),
(8, 'Kit de limpieza', 5, 5, 120.00, 10, 'activo'),
(9, 'Cámara de seguridad', 6, 6, 850.00, 5, 'activo'),
(10, 'Audífonos profesionales', 4, 4, 325.00, 10, 'activo');

INSERT INTO movimientos (
    id_movimiento,
    id_producto,
    id_bodega,
    tipo_movimiento,
    cantidad,
    fecha_movimiento,
    observacion
) VALUES
(1, 1, 1, 'entrada', 20, '2026-08-01', 'Compra inicial'),
(2, 2, 1, 'entrada', 30, '2026-08-01', 'Compra inicial'),
(3, 3, 2, 'entrada', 40, '2026-08-02', 'Reposición de inventario'),
(4, 4, 2, 'entrada', 50, '2026-08-02', 'Reposición de inventario'),
(5, 5, 1, 'entrada', 100, '2026-08-03', 'Compra mensual'),
(6, 6, 3, 'entrada', 15, '2026-08-03', 'Compra de mobiliario'),
(7, 7, 3, 'entrada', 25, '2026-08-04', 'Compra de mobiliario'),
(8, 8, 4, 'entrada', 50, '2026-08-04', 'Compra de suministros'),
(9, 9, 1, 'entrada', 20, '2026-08-05', 'Compra de seguridad'),
(10, 10, 2, 'entrada', 30, '2026-08-05', 'Reposición de accesorios'),
(11, 1, 1, 'salida', 3, '2026-08-06', 'Entrega a departamento administrativo'),
(12, 2, 1, 'salida', 5, '2026-08-06', 'Entrega a departamento administrativo'),
(13, 3, 2, 'salida', 8, '2026-08-07', 'Entrega a personal'),
(14, 5, 1, 'salida', 15, '2026-08-07', 'Consumo interno'),
(15, 6, 3, 'salida', 2, '2026-08-08', 'Entrega a oficinas'),
(16, 7, 3, 'salida', 4, '2026-08-08', 'Entrega a oficinas'),
(17, 8, 4, 'salida', 10, '2026-08-09', 'Consumo interno'),
(18, 9, 1, 'salida', 3, '2026-08-09', 'Instalación de cámaras'),
(19, 10, 2, 'salida', 6, '2026-08-10', 'Entrega a personal'),
(20, 4, 2, 'salida', 12, '2026-08-10', 'Entrega a personal');

-- CASOS INVALIDOS

-- INSERT INTO proveedores (id_proveedor, nombre, telefono, email, estado)
-- VALUES (7, 'Proveedor duplicado', '55510001', 'duplicado@example.com', 'activo');

-- INSERT INTO movimientos (id_movimiento, id_producto, id_bodega, tipo_movimiento, cantidad, fecha_movimiento, observacion)
-- VALUES (21, 1, 1, 'entrada', 0, '2026-08-11', 'Cantidad inválida');