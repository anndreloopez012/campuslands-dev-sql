PRAGMA foreign_keys = ON;

-- Ejercicio 31: Normalizacion Ventas Campus
-- Inserte aqui datos normalizados equivalentes al CSV original.
-- Agregue datos extra para probar consultas y restricciones.

-- Casos que deben fallar por restricciones, dejelos comentados:
-- INSERT INTO ...;
PRAGMA foreign_keys = ON;

-- CLIENTES

INSERT INTO clientes (
    id_cliente,
    nombre_completo,
    email,
    telefono
) VALUES
    (1, 'Ana Martínez', 'ana.martinez@email.com', '55510001'),
    (2, 'Carlos López', 'carlos.lopez@email.com', '55510002'),
    (3, 'María García', 'maria.garcia@email.com', '55510003'),
    (4, 'José Ramírez', 'jose.ramirez@email.com', '55510004'),
    (5, 'Laura Hernández', 'laura.hernandez@email.com', '55510005'),
    (6, 'Pedro Castillo', 'pedro.castillo@email.com', '55510006');

-- PRODUCTOS

INSERT INTO productos (
    id_producto,
    nombre_producto,
    categoria,
    precio,
    stock
) VALUES
    (1, 'Laptop Lenovo IdeaPad', 'Computadores', 4200.00, 15),
    (2, 'Mouse Logitech M185', 'Periféricos', 95.00, 80),
    (3, 'Teclado Logitech K120', 'Periféricos', 135.00, 60),
    (4, 'Monitor Samsung 24"', 'Monitores', 1250.00, 20),
    (5, 'Audífonos Sony WH-CH520', 'Audio', 650.00, 25),
    (6, 'Webcam Logitech C270', 'Accesorios', 420.00, 18);

-- VENDEDORES

INSERT INTO vendedores (
    id_vendedor,
    nombre_completo,
    email
) VALUES
    (1, 'Daniel Pérez', 'daniel.perez@campusventas.com'),
    (2, 'Sofía Morales', 'sofia.morales@campusventas.com'),
    (3, 'Andrés Gómez', 'andres.gomez@campusventas.com'),
    (4, 'Camila Torres', 'camila.torres@campusventas.com'),
    (5, 'Miguel Rojas', 'miguel.rojas@campusventas.com');

-- SUCURSALES

INSERT INTO sucursales (
    id_sucursal,
    nombre_sucursal,
    direccion,
    telefono
) VALUES
    (1, 'Sucursal Centro', 'Avenida Central 10-25', '55520001'),
    (2, 'Sucursal Zona 10', 'Boulevard Los Próceres 15-40', '55520002'),
    (3, 'Sucursal Zona 1', 'Calle Real 5-18', '55520003'),
    (4, 'Sucursal Mixco', 'Calzada San Juan 22-10', '55520004'),
    (5, 'Sucursal Roosevelt', 'Calzada Roosevelt 30-15', '55520005');

-- VENTAS

INSERT INTO ventas (
    id_venta,
    id_cliente,
    id_vendedor,
    id_sucursal,
    fecha_venta
) VALUES
    (1, 1, 1, 1, '2026-01-10'),
    (2, 2, 2, 2, '2026-01-12'),
    (3, 3, 3, 1, '2026-01-15'),
    (4, 1, 4, 3, '2026-01-20'),
    (5, 4, 1, 4, '2026-02-03'),
    (6, 5, 5, 5, '2026-02-08'),
    (7, 6, 2, 2, '2026-02-15'),
    (8, 2, 3, 1, '2026-02-21'),
    (9, 3, 4, 3, '2026-03-01'),
    (10, 5, 5, 5, '2026-03-05');

-- DETALLE_VENTA

INSERT INTO detalle_venta (
    id_venta,
    id_producto,
    cantidad,
    precio_unitario
) VALUES
    (1, 1, 1, 4200.00),
    (1, 2, 2, 95.00),
    (2, 3, 1, 135.00),
    (2, 4, 1, 1250.00),
    (3, 5, 2, 650.00),
    (4, 6, 1, 420.00),
    (5, 1, 1, 4200.00),
    (6, 2, 3, 95.00),
    (7, 4, 2, 1250.00),
    (8, 5, 1, 650.00),
    (9, 3, 2, 135.00),
    (10, 6, 2, 420.00),
    (10, 2, 1, 95.00);

-- CASOS INVALIDOS

-- Falla por correo duplicado.
-- INSERT INTO clientes (id_cliente, nombre_completo, email, telefono)
-- VALUES (7, 'Cliente Duplicado', 'ana.martinez@email.com', '55519999');

-- Falla por cantidad no positiva.
-- INSERT INTO detalle_venta (id_venta, id_producto, cantidad, precio_unitario)
-- VALUES (2, 5, 0, 650.00);