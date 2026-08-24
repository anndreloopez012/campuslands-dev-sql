INSERT INTO laboratorios (
    id_laboratorio,
    nombre,
    ciudad,
    telefono
) VALUES
(1, 'Laboratorios Bayer', 'Ciudad de Guatemala', '22550001'),
(2, 'Laboratorios Genfar', 'Ciudad de Guatemala', '22550002'),
(3, 'Laboratorios MK', 'Mixco', '22550003'),
(4, 'Laboratorios Laproff', 'Villa Nueva', '22550004'),
(5, 'Laboratorios Tecnoquimicas', 'Ciudad de Guatemala', '22550005');

INSERT INTO medicamentos (
    id_medicamento,
    id_laboratorio,
    nombre,
    principio_activo,
    precio_venta,
    stock,
    fecha_vencimiento
) VALUES
(1, 1, 'Aspirina 100mg', 'Acido acetilsalicilico', 2.50, 120, '2027-06-30'),
(2, 2, 'Acetaminofen 500mg', 'Paracetamol', 1.75, 200, '2027-09-15'),
(3, 3, 'Ibuprofeno 400mg', 'Ibuprofeno', 3.25, 85, '2027-04-20'),
(4, 4, 'Loratadina 10mg', 'Loratadina', 4.50, 60, '2027-11-10'),
(5, 5, 'Omeprazol 20mg', 'Omeprazol', 5.75, 45, '2028-01-25');

INSERT INTO compras (
    id_compra,
    id_medicamento,
    fecha_compra,
    cantidad,
    precio_unitario,
    proveedor
) VALUES
(1, 1, '2026-08-01', 100, 1.40, 'Distribuidora Salud'),
(2, 2, '2026-08-01', 150, 0.90, 'Farmadis'),
(3, 3, '2026-08-02', 80, 1.80, 'Distribuidora Salud'),
(4, 4, '2026-08-03', 70, 2.50, 'Medisuministros'),
(5, 5, '2026-08-04', 60, 3.20, 'Farmadis'),
(6, 1, '2026-08-05', 90, 1.45, 'Medisuministros'),
(7, 2, '2026-08-06', 120, 0.95, 'Distribuidora Salud'),
(8, 3, '2026-08-07', 75, 1.85, 'Farmadis'),
(9, 4, '2026-08-08', 50, 2.55, 'Medisuministros'),
(10, 5, '2026-08-09', 40, 3.25, 'Distribuidora Salud');

INSERT INTO ventas (
    id_venta,
    id_medicamento,
    fecha_venta,
    cantidad,
    precio_unitario,
    cliente
) VALUES
(1, 1, '2026-08-10', 10, 2.50, 'Carlos Ramirez'),
(2, 2, '2026-08-10', 15, 1.75, 'Ana Lopez'),
(3, 3, '2026-08-11', 8, 3.25, 'Luis Martinez'),
(4, 4, '2026-08-11', 12, 4.50, 'Sofia Garcia'),
(5, 5, '2026-08-12', 7, 5.75, 'Diego Castillo'),
(6, 1, '2026-08-12', 14, 2.50, 'Maria Hernandez'),
(7, 2, '2026-08-13', 20, 1.75, 'Pedro Gonzalez'),
(8, 3, '2026-08-13', 11, 3.25, 'Laura Morales'),
(9, 4, '2026-08-14', 9, 4.50, 'Jorge Perez'),
(10, 5, '2026-08-14', 13, 5.75, 'Daniel Castillo');