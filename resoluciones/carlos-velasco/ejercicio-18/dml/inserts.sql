PRAGMA foreign_keys = ON;

-- LABORATORIOS

INSERT INTO laboratorios
(id_laboratorio, nombre, telefono, ciudad)
VALUES
(1, 'Laboratorios Andinos', '5551001', 'Ciudad de Guatemala'),
(2, 'Farmaceutica Central', '5551002', 'Quetzaltenango'),
(3, 'Salud Integral', '5551003', 'Escuintla'),
(4, 'BioMedic Guatemala', '5551004', 'Antigua Guatemala'),
(5, 'Medicorp Centroamerica', '5551005', 'Guatemala');

-- MEDICAMENTOS

INSERT INTO medicamentos
(id_medicamento, id_laboratorio, nombre, principio_activo, precio_venta, stock, fecha_vencimiento)
VALUES
(1, 1, 'Paracetamol 500mg', 'Paracetamol', 8.50, 120, '2027-05-15'),
(2, 1, 'Ibuprofeno 400mg', 'Ibuprofeno', 12.75, 85, '2027-08-20'),
(3, 2, 'Amoxicilina 500mg', 'Amoxicilina', 25.00, 60, '2027-03-10'),
(4, 2, 'Loratadina 10mg', 'Loratadina', 10.50, 95, '2028-01-25'),
(5, 3, 'Omeprazol 20mg', 'Omeprazol', 15.25, 70, '2027-11-18'),
(6, 3, 'Metformina 850mg', 'Metformina', 18.00, 55, '2028-02-12'),
(7, 4, 'Losartan 50mg', 'Losartan', 22.50, 48, '2027-09-30'),
(8, 4, 'Cetirizina 10mg', 'Cetirizina', 11.75, 90, '2028-04-05'),
(9, 5, 'Atorvastatina 20mg', 'Atorvastatina', 30.00, 42, '2027-12-22'),
(10, 5, 'Diclofenaco 50mg', 'Diclofenaco', 14.50, 65, '2027-06-28');

-- COMPRAS

INSERT INTO compras
(id_compra, id_medicamento, fecha_compra, cantidad, precio_compra, proveedor)
VALUES
(1, 1, '2026-07-01', 100, 5.00, 'Distribuidora Medica GT'),
(2, 2, '2026-07-02', 80, 8.00, 'Distribuidora Medica GT'),
(3, 3, '2026-07-03', 60, 16.50, 'Proveedora Farmaceutica Nacional'),
(4, 4, '2026-07-04', 90, 6.75, 'Proveedora Farmaceutica Nacional'),
(5, 5, '2026-07-05', 70, 9.50, 'Importadora Salud Plus'),
(6, 6, '2026-07-06', 50, 12.00, 'Importadora Salud Plus'),
(7, 7, '2026-07-07', 45, 15.00, 'Medicamentos del Pacifico'),
(8, 8, '2026-07-08', 85, 7.50, 'Medicamentos del Pacifico'),
(9, 9, '2026-07-09', 40, 20.00, 'Farmadistribuciones GT'),
(10, 10, '2026-07-10', 60, 9.75, 'Farmadistribuciones GT');

-- VENTAS

INSERT INTO ventas
(id_venta, id_medicamento, fecha_venta, cantidad, precio_unitario, cliente)
VALUES
(1, 1, '2026-08-01', 3, 8.50, 'Ana Lopez'),
(2, 2, '2026-08-02', 2, 12.75, 'Carlos Perez'),
(3, 3, '2026-08-03', 1, 25.00, 'Maria Gomez'),
(4, 4, '2026-08-04', 4, 10.50, 'Luis Ramirez'),
(5, 5, '2026-08-05', 2, 15.25, 'Sofia Castillo'),
(6, 6, '2026-08-06', 3, 18.00, 'Diego Morales'),
(7, 7, '2026-08-07', 2, 22.50, 'Laura Hernandez'),
(8, 8, '2026-08-08', 5, 11.75, 'Jorge Martinez'),
(9, 9, '2026-08-09', 1, 30.00, 'Valeria Torres'),
(10, 10, '2026-08-10', 3, 14.50, 'Andres Mendoza');