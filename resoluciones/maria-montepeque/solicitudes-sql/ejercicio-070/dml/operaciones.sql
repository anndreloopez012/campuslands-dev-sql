PRAGMA foreign_keys = ON;

-- Ejercicio 070: Soldadura Industrial
-- Operaciones de mantenimiento: UPDATE de estado y DELETE controlado.

-- 1. La orden 3 (refuerzo de vigas) fue rechazada en su inspeccion y
--    el tecnico ya empezo a corregir las uniones: pasa de
--    'pendiente' a 'en_proceso'.
UPDATE ordenes
SET estado = 'en_proceso'
WHERE id_orden = 3 AND estado = 'pendiente';

-- 2. Se corrigio la union rechazada de la orden 3: se registra una
--    nueva inspeccion de seguimiento en vez de borrar o modificar la
--    inspeccion original, para conservar el historico de calidad tal
--    como lo necesita el cliente.
INSERT INTO inspecciones (id_orden, resultado, observaciones) VALUES
    (3, 'aprobada', 'Uniones reforzadas, se aprueba en segunda revision');

-- 3. DELETE controlado: se elimina el material duplicado por error de
--    digitacion en la orden 2 (mismo material, misma cantidad, mismo
--    costo, sin ninguna inspeccion asociada a esa orden todavia).
--    Solo se permite este DELETE porque la orden 2 no tiene
--    inspecciones registradas; si ya las tuviera, borrar un material
--    cambiaria un costo que ya se audito.
DELETE FROM materiales
WHERE id_material = (
    SELECT MAX(m2.id_material)
    FROM materiales m2
    WHERE m2.id_orden = 2
      AND m2.nombre_material = 'Electrodo 7018'
      AND m2.cantidad = 30
      AND m2.costo_unitario = 4.20
)
AND NOT EXISTS (
    SELECT 1 FROM inspecciones i WHERE i.id_orden = 2
);

-- Caso que debe fallar (queda comentado): eliminar un material de la
-- orden 1, que ya tiene inspecciones asociadas. La condicion de arriba
-- (NOT EXISTS inspecciones) ya evita que esto pase de forma automatica,
-- pero ademas seria un error de negocio: cambiaria el costo de una
-- orden que ya se audito.
-- DELETE FROM materiales WHERE id_orden = 1;
