PRAGMA foreign_keys = ON;

-- Ejercicio 077: Taller de Motos
-- Operaciones de mantenimiento sobre los datos base.

-- 1 DELETE controlado: la orden 4 todavia esta 'recibida' (no se
-- empezo a trabajar), asi que es seguro corregir la Cadena
-- Transmision que se agrego por error; esta moto solo necesitaba
-- revision de frenos.
DELETE FROM detalle_repuestos
WHERE id_orden = 4 AND id_repuesto = 4;

-- 1 UPDATE de estado: la orden 4 pasa a 'en_reparacion' porque el
-- mecanico ya empezo a trabajar en ella.
UPDATE ordenes_servicio
SET estado = 'en_reparacion'
WHERE id_orden = 4 AND estado = 'recibida';

-- Caso que debe fallar / no ser recomendable (queda comentado):
-- borrar un repuesto de la orden 1, que ya esta 'finalizada' (parte
-- del historial oficial del trabajo). El DELETE de arriba solo se
-- aplico mientras la orden 4 seguia 'recibida', por diseno: el
-- cliente pidio poder corregir estados sin borrar informacion
-- importante, y una orden finalizada ya es informacion importante.
-- DELETE FROM detalle_repuestos WHERE id_orden = 1 AND id_repuesto = 1;
