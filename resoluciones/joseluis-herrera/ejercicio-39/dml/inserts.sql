INSERT INTO departamentos (
    id_departamento,
    nombre_departamento,
    ubicacion,
    estado
) VALUES
    (1, 'Dirección', 'Edificio A - Piso 1', 'Activo'),
    (2, 'Operaciones', 'Edificio A - Piso 2', 'Activo'),
    (3, 'Recursos Humanos', 'Edificio B - Piso 1', 'Activo'),
    (4, 'Tecnología', 'Edificio B - Piso 2', 'Activo'),
    (5, 'Finanzas', 'Edificio C - Piso 1', 'Activo'),
    (6, 'Mercadeo', 'Edificio C - Piso 2', 'Activo');

INSERT INTO cargos (
    id_cargo,
    nombre_cargo,
    salario_base
) VALUES
    (1, 'Director General', 15000),
    (2, 'Gerente de Operaciones', 8500),
    (3, 'Analista de Recursos Humanos', 5200),
    (4, 'Desarrollador Backend', 6800),
    (5, 'Diseñadora UX/UI', 6200),
    (6, 'Analista Financiero', 5800),
    (7, 'Especialista de Marketing', 5600);

INSERT INTO empleados (
    id_empleado,
    documento,
    nombre_completo,
    id_cargo,
    id_departamento,
    id_jefe,
    estado
) VALUES
    (1, 'DPI-100001', 'Carlos Méndez', 1, 1, NULL, 'Activo'),
    (2, 'DPI-100002', 'Ana López', 2, 2, 1, 'Activo'),
    (3, 'DPI-100003', 'María García', 3, 3, 1, 'Activo'),
    (4, 'DPI-100004', 'José Ramírez', 4, 4, 2, 'Activo'),
    (5, 'DPI-100005', 'Laura Pérez', 5, 4, 2, 'Activo'),
    (6, 'DPI-100006', 'Pedro Castillo', 6, 5, 1, 'Activo'),
    (7, 'DPI-100007', 'Sofía Hernández', 7, 6, 1, 'Vacaciones'),
    (8, 'DPI-100008', 'Daniel Morales', 4, 4, 2, 'Activo'),
    (9, 'DPI-100009', 'Gabriela Torres', 3, 3, 3, 'Activo'),
    (10, 'DPI-100010', 'Miguel Fuentes', 6, 5, 6, 'Activo');

INSERT INTO contratos (
    id_contrato,
    id_empleado,
    fecha_contrato,
    salario,
    tipo_contrato,
    estado
) VALUES
    (1, 1, '2022-03-10', 15000, 'Indefinido', 'Activo'),
    (2, 2, '2024-01-15', 8500, 'Indefinido', 'Activo'),
    (3, 3, '2024-02-01', 5200, 'Indefinido', 'Activo'),
    (4, 4, '2023-08-21', 6800, 'Indefinido', 'Activo'),
    (5, 5, '2024-04-12', 6200, 'Indefinido', 'Activo'),
    (6, 6, '2023-05-18', 5800, 'Temporal', 'Activo'),
    (7, 7, '2024-06-03', 5600, 'Indefinido', 'Activo'),
    (8, 8, '2025-01-20', 7000, 'Indefinido', 'Activo'),
    (9, 9, '2025-02-14', 5400, 'Temporal', 'Activo'),
    (10, 10, '2025-03-01', 6000, 'Indefinido', 'Activo'),
    (11, 4, '2022-01-10', 6200, 'Temporal', 'Finalizado');

INSERT INTO beneficios (
    id_beneficio,
    nombre_beneficio,
    valor_mensual,
    estado
) VALUES
    (1, 'Seguro médico', 450),
    (2, 'Seguro de vida', 180),
    (3, 'Bono alimentación', 300),
    (4, 'Bono transporte', 250),
    (5, 'Bono productividad', 500),
    (6, 'Plan dental', 150),
    (7, 'Gimnasio corporativo', 100);

INSERT INTO asignaciones_beneficios (
    id_empleado,
    id_beneficio,
    fecha_asignacion,
    estado
) VALUES
    (1, 1, '2022-03-10', 'Activo'),
    (1, 2, '2022-03-10', 'Activo'),
    (2, 1, '2024-01-15', 'Activo'),
    (2, 3, '2024-01-15', 'Activo'),
    (3, 1, '2024-02-01', 'Activo'),
    (3, 3, '2024-02-01', 'Activo'),
    (4, 1, '2023-08-21', 'Activo'),
    (4, 4, '2023-08-21', 'Activo'),
    (5, 1, '2024-04-12', 'Activo'),
    (5, 4, '2024-04-12', 'Activo'),
    (6, 1, '2023-05-18', 'Activo'),
    (6, 5, '2023-05-18', 'Activo'),
    (7, 1, '2024-06-03', 'Activo'),
    (7, 4, '2024-06-03', 'Activo'),
    (8, 1, '2025-01-20', 'Activo'),
    (8, 5, '2025-01-20', 'Activo'),
    (9, 1, '2025-02-14', 'Activo'),
    (9, 6, '2025-02-14', 'Activo'),
    (10, 1, '2025-03-01', 'Activo'),
    (10, 5, '2025-03-01', 'Activo');

SELECT CASE
    WHEN EXISTS (
        SELECT 1
        FROM empleados
        WHERE documento = 'DPI-100001'
    )
    THEN 'Caso de restriccion UNIQUE: documento duplicado'
END AS caso_restriccion;

SELECT CASE
    WHEN EXISTS (
        SELECT 1
        FROM contratos
        WHERE salario <= 0
    )
    THEN 'Caso de restriccion CHECK: salario invalido'
    ELSE 'Caso de restriccion CHECK: salario invalido rechazado por el modelo'
END AS caso_restriccion;