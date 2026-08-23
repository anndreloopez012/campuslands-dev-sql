-- Ejercicio 18: Farmacia Inventario
-- Datos base: 5 laboratorios, 5 medicamentos, 5 compras, 10 ventas

INSERT INTO laboratorios (nombre, pais) VALUES
    ('Bayer', 'Alemania'),
    ('Pfizer', 'Estados Unidos'),
    ('Roche', 'Suiza'),
    ('Genfar', 'Colombia'),
    ('Laboratorios Lopez', 'Guatemala');

INSERT INTO medicamentos (id_laboratorio, nombre, precio_venta, stock) VALUES
    (1, 'Aspirina 500mg', 15.00, 200),
    (2, 'Amoxicilina 500mg', 25.00, 150),
    (3, 'Ibuprofeno 400mg', 12.00, 180),
    (4, 'Paracetamol 500mg', 8.00, 300),
    (5, 'Loratadina 10mg', 10.00, 120);

INSERT INTO compras (id_medicamento, cantidad, precio_unitario, fecha) VALUES
    (1, 100, 8.00, '2026-06-01'),
    (2, 80, 15.00, '2026-06-02'),
    (3, 90, 6.00, '2026-06-03'),
    (4, 150, 4.00, '2026-06-04'),
    (5, 60, 5.00, '2026-06-05');

INSERT INTO ventas (id_medicamento, cantidad, precio_unitario, fecha) VALUES
    (1, 10, 15.00, '2026-07-01'),
    (1, 5, 15.00, '2026-07-05'),
    (2, 8, 25.00, '2026-07-02'),
    (2, 3, 25.00, '2026-07-08'),
    (3, 12, 12.00, '2026-07-03'),
    (3, 6, 12.00, '2026-07-09'),
    (4, 20, 8.00, '2026-07-04'),
    (4, 15, 8.00, '2026-07-10'),
    (5, 7, 10.00, '2026-07-06'),
    (5, 4, 10.00, '2026-07-11');
