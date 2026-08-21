PRAGMA foreign_keys = ON;

-- DEPARTAMENTOS

INSERT INTO departamentos (
    id_departamento,
    nombre,
    presupuesto_anual
) VALUES
    (1, 'Tecnologia', 180000),
    (2, 'Recursos Humanos', 120000),
    (3, 'Finanzas', 150000),
    (4, 'Operaciones', 200000),
    (5, 'Comercial', 160000);

-- CARGOS

INSERT INTO cargos (
    id_cargo,
    nombre,
    salario_base
) VALUES
    (1, 'Desarrollador Backend', 4200),
    (2, 'Analista de Datos', 3900),
    (3, 'Analista de Recursos Humanos', 3500),
    (4, 'Contador', 4100),
    (5, 'Coordinador Comercial', 4500);

-- EMPLEADOS

INSERT INTO empleados (
    id_empleado,
    id_departamento,
    id_cargo,
    nombre_completo,
    correo,
    fecha_ingreso,
    estado
) VALUES
    (1, 1, 1, 'Ana Morales', 'ana.morales@campus.local', '2023-02-15', 'ACTIVO'),
    (2, 1, 2, 'Bruno Castillo', 'bruno.castillo@campus.local', '2022-08-01', 'ACTIVO'),
    (3, 2, 3, 'Carla Mendoza', 'carla.mendoza@campus.local', '2021-05-10', 'ACTIVO'),
    (4, 3, 4, 'Diego Ramirez', 'diego.ramirez@campus.local', '2020-11-20', 'ACTIVO'),
    (5, 4, 5, 'Elena Torres', 'elena.torres@campus.local', '2024-01-08', 'ACTIVO'),
    (6, 5, 5, 'Fabian Lopez', 'fabian.lopez@campus.local', '2023-07-17', 'ACTIVO'),
    (7, 1, 1, 'Gabriela Perez', 'gabriela.perez@campus.local', '2022-03-21', 'ACTIVO'),
    (8, 3, 4, 'Hector Silva', 'hector.silva@campus.local', '2021-09-13', 'ACTIVO'),
    (9, 2, 3, 'Irene Gomez', 'irene.gomez@campus.local', '2024-04-02', 'ACTIVO'),
    (10, 4, 2, 'Jorge Vasquez', 'jorge.vasquez@campus.local', '2023-10-30', 'ACTIVO');

-- CONTRATOS

INSERT INTO contratos (
    id_contrato,
    id_empleado,
    fecha_inicio,
    fecha_fin,
    tipo_contrato,
    salario
) VALUES
    (1, 1, '2023-02-15', NULL, 'INDEFINIDO', 4400),
    (2, 2, '2022-08-01', '2026-08-31', 'FIJO', 4050),
    (3, 3, '2021-05-10', NULL, 'INDEFINIDO', 3600),
    (4, 4, '2020-11-20', NULL, 'INDEFINIDO', 4300),
    (5, 5, '2024-01-08', '2026-12-31', 'FIJO', 4600),
    (6, 6, '2023-07-17', NULL, 'INDEFINIDO', 4700),
    (7, 7, '2022-03-21', NULL, 'INDEFINIDO', 4550),
    (8, 8, '2021-09-13', '2027-01-31', 'FIJO', 4400),
    (9, 9, '2024-04-02', '2026-11-30', 'FIJO', 3700),
    (10, 10, '2023-10-30', NULL, 'INDEFINIDO', 4000);