PRAGMA foreign_keys = ON;

-- Ejercicio 063: Clinica de Tatuajes
-- Operaciones de mantenimiento sobre los datos base.

-- 1 UPDATE de estado: la sesion 5 (agendada) se realiza y pasa a
-- 'completada'.
UPDATE sesiones
SET estado = 'completada'
WHERE id_sesion = 5;

-- 1 UPDATE de estado: se confirma el pago pendiente de la sesion 8, una
-- vez que el cliente cancela en efectivo.
UPDATE pagos
SET estado_pago = 'pagado'
WHERE id_sesion = 8;

-- 1 DELETE controlado: se elimina la sesion 7, que quedo 'cancelada' y
-- nunca genero pago (no rompe integridad referencial porque no existe
-- fila en pagos para id_sesion = 7).
DELETE FROM sesiones
WHERE id_sesion = 7 AND estado = 'cancelada';

-- Caso que debe fallar (queda comentado): eliminar un artista que tiene
-- sesiones asociadas viola la FOREIGN KEY de sesiones.id_artista.
-- DELETE FROM artistas WHERE id_artista = 1;
