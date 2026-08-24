INSERT INTO empleados VALUES
(6,1,1,'Maria Hernandez','60010006','maria@empresa.com');

INSERT INTO contratos VALUES
(11,6,'2026-09-01',NULL,'FIJO',6700);

UPDATE empleados
SET correo='maria.h@empresa.com'
WHERE id_empleado=6;

UPDATE contratos
SET salario=6900
WHERE id_contrato=11;

DELETE FROM contratos
WHERE id_contrato=11;

DELETE FROM empleados
WHERE id_empleado=6;

-- INSERT INTO departamentos VALUES
-- (6,'Tecnologia','Edificio Z');

-- INSERT INTO contratos VALUES
-- (12,999,'2026-09-10',NULL,'FIJO',5000);