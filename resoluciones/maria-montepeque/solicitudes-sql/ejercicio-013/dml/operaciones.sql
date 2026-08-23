PRAGMA foreign_keys = ON;

-- Ejercicio 013: Clinica de Tatuajes
-- Operaciones de mantenimiento (UPDATE / DELETE controlados).

-- 1. La sesion de Karen Solis con Ingrid Say ya se realizo (id_sesion =
--    3): se corrige el estado de 'agendada' a 'completada'. WHERE
--    especifico por PK + estado actual.
UPDATE sesiones
SET estado = 'completada'
WHERE id_sesion = 3 AND estado = 'agendada';

-- 2. Mario Ixtabalan (id_artista = 4) cambia su estilo principal de
--    'acuarela' a 'realismo'.
UPDATE artistas
SET estilo_principal = 'realismo'
WHERE id_artista = 4;

-- 3. Se elimina la entrada de prueba (id_sesion = 9): nunca fue una
--    sesion real. DELETE seguro porque usa el id exacto de la fila.
DELETE FROM sesiones
WHERE id_sesion = 9;
