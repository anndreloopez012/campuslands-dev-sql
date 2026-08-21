PRAGMA foreign_keys = ON;

-- Ejercicio 065: Laboratorio Quimico
-- Operaciones de mantenimiento sobre los datos base.

-- 1 UPDATE de estado: la muestra 4 (en analisis) termina y pasa a
-- 'finalizada'.
UPDATE muestras
SET estado = 'finalizada'
WHERE id_muestra = 4;

-- 1 UPDATE de correccion: el resultado de la muestra 3 se revisa de
-- nuevo y se aprueba (el primer analisis fue impreciso).
UPDATE resultados
SET aprobado = 1
WHERE id_muestra = 3;

-- 1 DELETE controlado: se elimina la muestra 8, que el cliente cancelo
-- mientras estaba 'pendiente' (no rompe integridad referencial porque
-- no existe fila en resultados para id_muestra = 8).
DELETE FROM muestras
WHERE id_muestra = 8 AND estado = 'pendiente';

-- Caso que debe fallar (queda comentado): eliminar un reactivo que
-- tiene muestras asociadas viola la FOREIGN KEY de muestras.id_reactivo.
-- DELETE FROM reactivos WHERE id_reactivo = 1;
