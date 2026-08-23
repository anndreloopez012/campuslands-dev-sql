PRAGMA foreign_keys = ON;

-- Ejercicio 059: Estudio Animacion 3D
-- Operaciones de mantenimiento: UPDATE de estado y DELETE controlado.

-- 1. Karla Fong termino el modelado del personaje secundario
--    (id_tarea = 4): se corrige el estado de 'pendiente' a
--    'completada' y se registra cuando paso.
UPDATE tareas
SET estado = 'completada',
    fecha_ultimo_cambio = '2026-07-20'
WHERE id_tarea = 4 AND estado = 'pendiente';

-- 2. Cinematica Andes paso la revision del cliente y se entrego
--    (id_proyecto = 3): se corrige el estado de 'revision' a
--    'entregado'.
UPDATE proyectos
SET estado = 'entregado'
WHERE id_proyecto = 3 AND estado = 'revision';

-- 3. DELETE controlado: solo se borra una tarea 'pendiente' si el
--    proyecto al que pertenece esta 'cancelado'. La tarea 9 (del
--    proyecto Nivel Quetzal 1, cancelado) cumple la condicion; una
--    tarea pendiente de un proyecto activo, como la tarea 6, no se
--    toca.
DELETE FROM tareas
WHERE id_tarea = 9
  AND estado = 'pendiente'
  AND EXISTS (
      SELECT 1 FROM proyectos WHERE proyectos.id_proyecto = tareas.id_proyecto AND proyectos.estado = 'cancelado'
  );

-- 4. Se elimina la tarea duplicada (id_tarea = 11): es una copia
--    exacta de la tarea 1 por error de digitacion. DELETE seguro
--    porque usa el id exacto de la fila (error de captura, no una
--    decision de negocio).
DELETE FROM tareas
WHERE id_tarea = 11;
