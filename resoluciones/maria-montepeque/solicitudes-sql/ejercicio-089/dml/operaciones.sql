PRAGMA foreign_keys = ON;

-- Ejercicio 089: Mecanica de Autos
-- Operaciones de mantenimiento sobre los datos base.

-- 1 DELETE controlado: la reparacion 3 todavia esta 'pendiente', asi
-- que es seguro corregir el filtro de aceite que se anoto por error
-- (este vehiculo solo necesitaba bujias nuevas).
DELETE FROM detalle_repuestos
WHERE id_reparacion = 3 AND id_repuesto = 2;

-- 1 UPDATE de estado: el mecanico ya empezo a trabajar en la
-- reparacion 3.
UPDATE reparaciones
SET estado = 'en_proceso'
WHERE id_reparacion = 3 AND estado = 'pendiente';

-- Caso que debe fallar / no ser recomendable (queda comentado):
-- borrar una linea de repuesto de la reparacion 1, que ya esta
-- 'completada' (parte del historico de auditoria). El DELETE de
-- arriba solo se aplico mientras la reparacion 3 seguia 'pendiente',
-- por diseno.
-- DELETE FROM detalle_repuestos WHERE id_reparacion = 1 AND id_repuesto = 1;
