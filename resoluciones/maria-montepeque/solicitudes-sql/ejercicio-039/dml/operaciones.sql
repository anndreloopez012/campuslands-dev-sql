PRAGMA foreign_keys = ON;

-- Ejercicio 039: Mecanica de Autos
-- Operaciones de mantenimiento (UPDATE / DELETE controlados).
-- El cliente pidio guardar historico para auditorias: por eso los
-- cambios reales de negocio son UPDATE (y actualizan
-- fecha_ultimo_cambio), y DELETE solo se usa para el duplicado.

-- 1. La alineacion del Corolla de Walter Xitamul (id_diagnostico = 5)
--    entro a taller: se corrige el estado de 'diagnosticado' a
--    'en_reparacion' y se registra cuando paso.
UPDATE diagnosticos
SET estado = 'en_reparacion',
    fecha_ultimo_cambio = '2026-08-09'
WHERE id_diagnostico = 5 AND estado = 'diagnosticado';

-- 2. La revision de motor de la Hilux de Walter Xitamul
--    (id_diagnostico = 3) se termino de reparar: se corrige el estado
--    de 'en_reparacion' a 'reparado' y se registra cuando paso.
UPDATE diagnosticos
SET estado = 'reparado',
    fecha_ultimo_cambio = '2026-08-18'
WHERE id_diagnostico = 3 AND estado = 'en_reparacion';

-- 3. Se elimina el diagnostico duplicado (id_diagnostico = 10): es
--    una copia exacta del diagnostico 1 por error de digitacion.
--    DELETE seguro porque usa el id exacto de la fila y es el unico
--    caso que no es un dato real de auditoria.
DELETE FROM diagnosticos
WHERE id_diagnostico = 10;
