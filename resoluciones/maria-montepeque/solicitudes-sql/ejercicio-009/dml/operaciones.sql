PRAGMA foreign_keys = ON;

-- Ejercicio 009: Estudio Animacion 3D
-- Operaciones de mantenimiento (UPDATE / DELETE controlados).

-- 1. El cliente aprobo la correccion de iluminacion (id_entrega = 7): se
--    corrige el estado de 'rechazado' a 'aprobado'. El evento en si
--    (que paso y cuando paso) NO se toca, solo su resultado. WHERE
--    especifico por PK + estado actual.
UPDATE entregas
SET estado = 'aprobado'
WHERE id_entrega = 7 AND estado = 'rechazado';

-- 2. El proyecto del documental cambia de artista asignado (id_proyecto
--    = 5): Karen Solis fue reasignada a otro proyecto, entra Mario Paz.
UPDATE proyectos
SET artista_asignado = 'Mario Paz'
WHERE id_proyecto = 5;

-- 3. Se elimina la entrada de prueba (id_entrega = 9): nunca fue un
--    evento real del historico. DELETE seguro porque usa el id exacto de
--    la fila. Es la unica eliminacion del historico; todo lo demas se
--    corrige con UPDATE de estado.
DELETE FROM entregas
WHERE id_entrega = 9;
