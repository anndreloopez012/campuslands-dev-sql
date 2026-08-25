PRAGMA foreign_keys = ON;

-- Ejercicio 084: Estudio Animacion 3D
-- Operaciones de mantenimiento sobre los datos base.

-- 1 DELETE controlado: se confirma que el alcance extra del proyecto
-- 2 (etiqueta adicional) fue cancelado por el cliente; la tarea que
-- ya se habia registrado por ese trabajo se elimina.
DELETE FROM tareas
WHERE id_proyecto = 2 AND descripcion = 'Texturizado etiqueta extra (alcance cancelado)';

-- 1 UPDATE de estado: el cliente revisa y aprueba la entrega de la
-- semana 2 del proyecto 1.
UPDATE entregas
SET aprobada = 1
WHERE id_proyecto = 1 AND semana = 2 AND aprobada = 0;

-- Caso que debe fallar / no ser recomendable (queda comentado):
-- borrar una tarea real ya confirmada (no un error de captura), por
-- ejemplo el modelado de la nave principal. El historico real de
-- tareas no se borra.
-- DELETE FROM tareas WHERE id_proyecto = 1 AND descripcion = 'Modelado nave principal';
