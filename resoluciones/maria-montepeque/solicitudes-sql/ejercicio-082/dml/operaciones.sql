PRAGMA foreign_keys = ON;

-- Ejercicio 082: Academia Kickboxing
-- Operaciones de mantenimiento sobre los datos base.

-- 1 DELETE controlado: se confirmo que Byron Xicay no asistio a la
-- clase del 2026-08-05; el entrenador la habia marcado por error.
DELETE FROM asistencias
WHERE id_alumno = 3 AND id_entrenador = 1 AND fecha_clase = '2026-08-05';

-- 1 UPDATE de estado: el pago pendiente de Manuel Estrada se confirma
-- como pagado.
UPDATE pagos
SET estado = 'pagado'
WHERE id_alumno = 1 AND estado = 'pendiente';

-- Caso que debe fallar / no ser recomendable (queda comentado):
-- borrar una asistencia real (no un error de captura confirmado),
-- por ejemplo la primera clase de Manuel Estrada. El historico de
-- asistencias reales no se borra; si un alumno deja la academia,
-- simplemente no se le registran clases nuevas.
-- DELETE FROM asistencias WHERE id_alumno = 1 AND fecha_clase = '2026-08-01';
