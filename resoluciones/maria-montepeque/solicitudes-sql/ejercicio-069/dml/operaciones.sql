PRAGMA foreign_keys = ON;

-- Ejercicio 069: Diseno 3D Arquitectura
-- Operaciones de mantenimiento sobre los datos base.

-- 1 UPDATE de estado: el render 3 (torre_exterior) termina su proceso
-- de revision y pasa de 'en_proceso' a 'terminado'.
UPDATE renders
SET estado = 'terminado'
WHERE id_render = 3;

-- 1 UPDATE de correccion: se corrige un comentario de revision con un
-- error de captura, SIN eliminarlo, para conservar el historico de
-- auditoria tal como pidio el cliente.
UPDATE revisiones
SET comentario = 'Ajustado segun observaciones; queda pendiente una segunda revision del cliente'
WHERE id_render = 3 AND comentario = 'Ajustado, pendiente segunda revision';

-- 1 DELETE controlado: se elimina el render 9 (duplicado, creado por
-- error), que todavia no tenia ninguna revision asociada. Este es el
-- unico caso del modelo donde un DELETE real es aceptable; el resto del
-- historico (revisiones) nunca se borra.
DELETE FROM renders
WHERE id_render = 9;

-- Caso que debe fallar (queda comentado): eliminar un render que ya
-- tiene revisiones asociadas viola la FOREIGN KEY de
-- revisiones.id_render.
-- DELETE FROM renders WHERE id_render = 1;
