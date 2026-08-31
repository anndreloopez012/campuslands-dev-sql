PRAGMA foreign_keys = ON;

-- Ejercicio 090: Laboratorio Quimico
-- Operaciones de mantenimiento sobre los datos base.

-- INSERT adicional: llega una muestra nueva de Cloruro de Sodio
-- Estandar, recibida por Carlos.
INSERT INTO muestras (id_formula, id_tecnico, fecha_recepcion, estado) VALUES
    (3, 2, '2026-08-10', 'recibida');

-- UPDATE con WHERE: la muestra 5 ya empezo a analizarse.
UPDATE muestras
SET estado = 'en_analisis'
WHERE id_muestra = 5 AND estado = 'recibida';

-- DELETE controlado: la muestra 3 todavia esta 'en_analisis', asi que
-- es seguro corregir el hidroxido de sodio que se anoto por error
-- (esta formula solo necesitaba cloruro de sodio).
DELETE FROM detalle_reactivos
WHERE id_muestra = 3 AND id_reactivo = 2;

-- Caso que debe fallar / no ser recomendable (queda comentado):
-- borrar una linea de reactivo de la muestra 1, que ya esta
-- 'finalizada' (parte del historico de auditoria). El DELETE de
-- arriba solo se aplico mientras la muestra 3 seguia 'en_analisis',
-- por diseno.
-- DELETE FROM detalle_reactivos WHERE id_muestra = 1 AND id_reactivo = 1;
