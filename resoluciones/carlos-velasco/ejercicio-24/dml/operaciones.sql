PRAGMA foreign_keys = ON;

-- INSERT

INSERT INTO departamentos (
    id_departamento,
    nombre,
    presupuesto_anual
) VALUES (
    6,
    'Innovacion',
    130000
);

INSERT INTO empleados (
    id_empleado,
    id_departamento,
    id_cargo,
    nombre_completo,
    correo,
    fecha_ingreso,
    estado
) VALUES (
    11,
    6,
    2,
    'Laura Cifuentes',
    'laura.cifuentes@campus.local',
    '2026-08-01',
    'ACTIVO'
);

-- UPDATE

UPDATE empleados
SET estado = 'INACTIVO'
WHERE id_empleado = 10;

UPDATE contratos
SET salario = 4850
WHERE id_contrato = 6;

-- DELETE

DELETE FROM empleados
WHERE id_empleado = 11;

DELETE FROM departamentos
WHERE id_departamento = 6;

-- OPERACIONES INVALIDAS

-- CHECK: salario no puede ser menor o igual a cero.
-- INSERT INTO contratos (
--     id_contrato,
--     id_empleado,
--     fecha_inicio,
--     fecha_fin,
--     tipo_contrato,
--     salario
-- ) VALUES (
--     11,
--     1,
--     '2026-08-20',
--     NULL,
--     'INDEFINIDO',
--     -500
-- );

-- FOREIGN KEY: el empleado referenciado debe existir.
-- INSERT INTO contratos (
--     id_contrato,
--     id_empleado,
--     fecha_inicio,
--     fecha_fin,
--     tipo_contrato,
--     salario
-- ) VALUES (
--     12,
--     999,
--     '2026-08-20',
--     NULL,
--     'INDEFINIDO',
--     4000
-- );