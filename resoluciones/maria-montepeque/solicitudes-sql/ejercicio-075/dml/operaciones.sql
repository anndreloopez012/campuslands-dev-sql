PRAGMA foreign_keys = ON;

-- Ejercicio 075: Track Day Hiperdeportivos
-- Operaciones de mantenimiento sobre los datos base.

-- 1 UPDATE de estado: se confirma que el sistema de cronometraje de
-- la sesion 3 fallo y la sesion se anula.
UPDATE sesiones
SET estado = 'cancelada'
WHERE id_sesion = 3 AND estado = 'finalizada';

-- 1 DELETE controlado: el tiempo de la sesion 3 quedo huerfano apenas
-- se marco 'cancelada' (ya no representa una vuelta oficial). Solo se
-- borran tiempos de sesiones 'cancelada'; una sesion 'finalizada'
-- nunca pierde sus tiempos por este DELETE.
DELETE FROM tiempos
WHERE id_sesion IN (
    SELECT id_sesion FROM sesiones WHERE estado = 'cancelada'
);

-- 1 UPDATE multiple de estado: se confirman todos los pagos
-- pendientes de las sesiones 1 y 2 (ya finalizadas) como 'pagado',
-- con un solo UPDATE.
UPDATE pagos
SET estado = 'pagado', fecha_pago = date('now')
WHERE id_sesion IN (1, 2) AND estado = 'pendiente';

-- Caso que debe fallar / no ser recomendable (queda comentado):
-- borrar tiempos de una sesion que ya quedo 'finalizada' (resultado
-- oficial). El DELETE de arriba solo alcanza sesiones 'cancelada' por
-- diseno.
-- DELETE FROM tiempos WHERE id_sesion = 1;
