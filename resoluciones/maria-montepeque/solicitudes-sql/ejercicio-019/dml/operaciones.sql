PRAGMA foreign_keys = ON;

-- Ejercicio 019: Diseno 3D Arquitectura
-- Operaciones de mantenimiento (UPDATE / DELETE controlados).

-- 1. El comite aprobo el ajuste de accesos vehiculares (id_evento = 7):
--    se corrige el estado de 'rechazado' a 'aprobado'. El evento en si
--    (que paso y cuando paso) NO se toca, solo su resultado. WHERE
--    especifico por PK + estado actual.
UPDATE eventos
SET estado = 'aprobado'
WHERE id_evento = 7 AND estado = 'rechazado';

-- 2. El proyecto de la casa de playa cambia de arquitecto asignado
--    (id_proyecto = 5): Karla Diaz fue reasignada, entra Julio Perez.
UPDATE proyectos
SET arquitecto_asignado = 'Julio Perez'
WHERE id_proyecto = 5;

-- 3. Se elimina la entrada de prueba (id_evento = 9): nunca fue un
--    evento real del historico. DELETE seguro porque usa el id exacto de
--    la fila. Es la unica eliminacion del historico; todo lo demas se
--    corrige con UPDATE de estado.
DELETE FROM eventos
WHERE id_evento = 9;
