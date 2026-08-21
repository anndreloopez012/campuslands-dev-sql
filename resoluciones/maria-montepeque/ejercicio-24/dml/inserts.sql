-- Ejercicio 24: Recursos Humanos
-- Datos base: 5 departamentos, 5 cargos, 5 empleados, 10 contratos

INSERT INTO departamentos (nombre) VALUES
    ('Recursos Humanos'),
    ('Tecnologia'),
    ('Ventas'),
    ('Contabilidad'),
    ('Operaciones');

INSERT INTO cargos (nombre, salario_base) VALUES
    ('Analista', 4500.00),
    ('Desarrollador', 6500.00),
    ('Vendedor', 4000.00),
    ('Contador', 5500.00),
    ('Supervisor', 7000.00);

INSERT INTO empleados (id_departamento, id_cargo, nombre, dpi, fecha_ingreso) VALUES
    (1, 1, 'Manuel Estrada', 'DPI-5001', '2023-01-10'),
    (2, 2, 'Alejandra Chinchilla', 'DPI-5002', '2022-06-01'),
    (3, 3, 'Byron Xicay', 'DPI-5003', '2024-02-15'),
    (4, 4, 'Cristina Barrios', 'DPI-5004', '2021-11-20'),
    (5, 5, 'Douglas Pineda', 'DPI-5005', '2020-09-05');

INSERT INTO contratos (id_empleado, tipo, salario, fecha_inicio, fecha_fin, estado) VALUES
    (1, 'temporal', 4500.00, '2023-01-10', '2023-12-31', 'finalizado'),
    (1, 'indefinido', 4700.00, '2024-01-01', NULL, 'activo'),
    (2, 'indefinido', 6500.00, '2022-06-01', NULL, 'activo'),
    (2, 'temporal', 6300.00, '2021-06-01', '2022-05-31', 'finalizado'),
    (3, 'temporal', 4000.00, '2024-02-15', '2025-02-14', 'finalizado'),
    (3, 'indefinido', 4200.00, '2025-02-15', NULL, 'activo'),
    (4, 'indefinido', 5500.00, '2021-11-20', NULL, 'activo'),
    (4, 'por_servicios', 5200.00, '2021-01-01', '2021-11-19', 'finalizado'),
    (5, 'indefinido', 7000.00, '2020-09-05', NULL, 'activo'),
    (5, 'temporal', 6800.00, '2019-09-05', '2020-09-04', 'finalizado');
