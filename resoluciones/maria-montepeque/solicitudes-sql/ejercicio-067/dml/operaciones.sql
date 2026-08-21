PRAGMA foreign_keys = ON;

-- Ejercicio 067: Streaming Musica
-- Operaciones de mantenimiento sobre los datos base.

-- 1 UPDATE de estado: la playlist 5 (vieja, sin uso) se archiva en vez
-- de eliminarse, tal como pidio el cliente, para no perder informacion.
UPDATE playlists
SET estado = 'archivada'
WHERE id_playlist = 5;

-- 1 UPDATE de estado: Cristina Barrios actualiza su cuenta a premium.
UPDATE usuarios
SET plan = 'premium'
WHERE id_usuario = 4;

-- 1 DELETE controlado: se elimina la reproduccion 12, un duplicado
-- exacto de la reproduccion 11 registrado por error al reintentar la
-- peticion (a diferencia de una playlist, un registro de este tipo si
-- se elimina cuando es un error de captura, no un dato de negocio).
DELETE FROM reproducciones
WHERE id_reproduccion = 12;

-- Caso que debe fallar (queda comentado): eliminar una cancion que
-- tiene reproducciones asociadas viola la FOREIGN KEY de
-- reproducciones.id_cancion.
-- DELETE FROM canciones WHERE id_cancion = 5;
