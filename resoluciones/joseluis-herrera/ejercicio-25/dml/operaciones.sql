INSERT INTO usuarios VALUES
(6,'Maria Hernandez','70010006','maria@email.com','55530006');

INSERT INTO prestamos VALUES
(11,5,6,'2026-08-11',NULL,'ACTIVO');

UPDATE usuarios
SET telefono='55539999'
WHERE id_usuario=6;

UPDATE prestamos
SET estado='DEVUELTO',
    fecha_devolucion='2026-08-18'
WHERE id_prestamo=11;

DELETE FROM prestamos
WHERE id_prestamo=11;

DELETE FROM usuarios
WHERE id_usuario=6;

-- INSERT INTO usuarios VALUES
-- (7,'Usuario Duplicado','70010001','dup@email.com','55530007');

-- INSERT INTO prestamos VALUES
-- (12,999,1,'2026-08-12',NULL,'ACTIVO');