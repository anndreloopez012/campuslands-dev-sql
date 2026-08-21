PRAGMA foreign_keys = ON;

-- Ejercicio 064: Mecanica de Autos
-- Operaciones de mantenimiento sobre los datos base.

-- 1 UPDATE de estado: el diagnostico 3 (fuga de aceite) termina de
-- repararse y pasa de 'en_reparacion' a 'finalizado'.
UPDATE diagnosticos
SET estado = 'finalizado'
WHERE id_diagnostico = 3;

-- 1 UPDATE de correccion: el mecanico jefe revisa y corrige el costo de
-- mano de obra de esa reparacion (se cobro tiempo extra).
UPDATE reparaciones
SET costo_mano_obra = 180.00
WHERE id_diagnostico = 3;

-- 1 DELETE controlado: se elimina el diagnostico 8 (revision de
-- suspension), que el cliente cancelo antes de generar reparacion (no
-- rompe integridad referencial porque no existe fila en reparaciones
-- para id_diagnostico = 8).
DELETE FROM diagnosticos
WHERE id_diagnostico = 8 AND estado = 'pendiente';

-- Caso que debe fallar (queda comentado): eliminar un vehiculo que tiene
-- diagnosticos asociados viola la FOREIGN KEY de diagnosticos.id_vehiculo.
-- DELETE FROM vehiculos WHERE id_vehiculo = 1;
