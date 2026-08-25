PRAGMA foreign_keys = ON;

-- Ejercicio 088: Clinica de Tatuajes
-- Operaciones de mantenimiento sobre los datos base.

-- 1 UPDATE de estado: se confirma que Manuel Estrada pidio posponer
-- la sesion 5.
UPDATE sesiones
SET estado = 'cancelada'
WHERE id_sesion = 5 AND estado = 'finalizada';

-- 1 DELETE controlado: el pago de la sesion 5 quedo invalido apenas
-- se corrigio el estado (la sesion nunca se realizo de verdad). Solo
-- se borran pagos de sesiones 'cancelada'; una sesion 'finalizada'
-- nunca pierde su pago por este DELETE.
DELETE FROM pagos
WHERE id_sesion IN (
    SELECT id_sesion FROM sesiones WHERE estado = 'cancelada'
);

-- Caso que debe fallar / no ser recomendable (queda comentado):
-- borrar el pago de la sesion 1, que ya esta 'finalizada' (resultado
-- oficial). El DELETE de arriba solo alcanza sesiones 'cancelada' por
-- diseno.
-- DELETE FROM pagos WHERE id_sesion = 1;
