-- Ejercicio 39: Normalizacion Recursos Humanos
-- Datos normalizados equivalentes a datos/datos-sin-normalizar.csv
-- (empleados 1-3, cargos 1-2, departamentos 1-2, beneficios 1-4 y los
--  contratos 1-3 con sus asignaciones vienen del CSV original; el resto se
--  agrega para cumplir el minimo de datos del ejercicio)
--
-- Nota sobre el CSV original: Marco Luna aparece en las filas 1 y 3 con el
-- mismo cargo, departamento, jefe y salario, pero en fechas distintas
-- (2026-01-15 y 2026-03-01) y con beneficios distintos: son dos contratos
-- reales (una renovacion), no una fila duplicada, asi que se mantienen como
-- dos registros separados en `contratos`.

INSERT INTO empleados (nombre) VALUES
    ('Marco Luna'),
    ('Claudia Soto'),
    ('Ingrid Paz'),
    ('Luis Bran'),
    ('Karen Xitumul');

INSERT INTO cargos (nombre) VALUES
    ('Developer Jr'),
    ('Analista'),
    ('Supervisor'),
    ('Gerente'),
    ('Practicante');

INSERT INTO departamentos (nombre) VALUES
    ('Tecnologia'),
    ('Datos'),
    ('Recursos Humanos'),
    ('Finanzas'),
    ('Operaciones');

INSERT INTO beneficios (nombre) VALUES
    ('Seguro'),
    ('Bono'),
    ('Parqueo'),
    ('Capacitacion'),
    ('Gimnasio');

INSERT INTO contratos (id_empleado, id_cargo, id_departamento, id_jefe, salario, fecha_contrato) VALUES
    (1, 1, 1, 3, 6500.00, '2026-01-15'),   -- contrato 1 del CSV: Marco Luna, Developer Jr, Tecnologia, jefe Ingrid Paz
    (2, 2, 2, 3, 7200.00, '2026-02-01'),   -- contrato 2 del CSV: Claudia Soto, Analista, Datos, jefe Ingrid Paz
    (1, 1, 1, 3, 6500.00, '2026-03-01'),   -- contrato 3 del CSV: Marco Luna (renovacion, otra fecha)
    (3, 4, 1, NULL, 12000.00, '2025-11-01'),   -- Ingrid Paz es Gerente y no reporta a nadie
    (4, 3, 3, 3, 8500.00, '2026-01-20'),   -- Luis Bran, Supervisor de RRHH, jefe Ingrid Paz
    (5, 5, 4, 4, 3500.00, '2026-02-10');   -- Karen Xitumul, Practicante de Finanzas, jefe Luis Bran

INSERT INTO asignaciones (id_contrato, id_beneficio) VALUES
    -- contrato 1 (CSV): Seguro|Bono
    (1, 1),
    (1, 2),
    -- contrato 2 (CSV): Seguro|Parqueo
    (2, 1),
    (2, 3),
    -- contrato 3 (CSV): Capacitacion|Bono
    (3, 4),
    (3, 2),
    -- contratos adicionales para completar el minimo de 10 asignaciones
    (4, 1),
    (4, 2),
    (4, 5),
    (5, 1),
    (5, 4),
    (6, 1);

-- 2 casos comentados que deben fallar por restricciones
-- Falla por UNIQUE (empleados.nombre): el empleado ya existe
-- INSERT INTO empleados (nombre) VALUES ('Marco Luna');

-- Falla por CHECK (salario > 0)
-- INSERT INTO contratos (id_empleado, id_cargo, id_departamento, id_jefe, salario, fecha_contrato) VALUES (2, 2, 2, 3, -100.00, '2026-04-01');
