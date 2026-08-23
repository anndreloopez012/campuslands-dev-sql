-- Ejercicio 24: Recursos Humanos
-- Operaciones sobre los datos base

-- 2 INSERT adicionales
INSERT INTO departamentos (nombre) VALUES
    ('Marketing');

INSERT INTO contratos (id_empleado, tipo, salario, fecha_inicio, fecha_fin, estado) VALUES
    (3, 'por_servicios', 3800.00, '2026-08-01', NULL, 'activo');

-- 2 UPDATE validos
UPDATE contratos
SET estado = 'suspendido'
WHERE id_contrato = 9;

UPDATE cargos
SET salario_base = 6800.00
WHERE id_cargo = 2;

-- 2 DELETE controlados con WHERE
DELETE FROM contratos
WHERE id_contrato = 8;

DELETE FROM contratos
WHERE estado = 'finalizado' AND id_contrato = 10;
