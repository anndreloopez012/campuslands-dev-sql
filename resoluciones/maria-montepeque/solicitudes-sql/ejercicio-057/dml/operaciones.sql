PRAGMA foreign_keys = ON;

-- Ejercicio 057: Academia Kickboxing
-- Operaciones de mantenimiento: UPDATE de estado y DELETE controlado.
-- El cliente pidio corregir estados sin borrar informacion: por eso
-- las primeras dos operaciones son UPDATE, no DELETE.

-- 1. Kevin Aju presento un justificante medico por su falta del
--    2026-08-03 (id_asistencia = 4): se corrige el estado de
--    'ausente' a 'justificada', sin borrar el registro.
UPDATE asistencias
SET estado = 'justificada'
WHERE id_asistencia = 4 AND estado = 'ausente';

-- 2. Diego Chavajay reactivo su membresia (id_alumno = 3): se
--    corrige el estado de 'suspendido' a 'activo'.
UPDATE alumnos
SET estado = 'activo'
WHERE id_alumno = 3 AND estado = 'suspendido';

-- 3. DELETE controlado: solo se borra una asistencia 'ausente' si el
--    alumno correspondiente ya esta 'inactivo'. La asistencia 9
--    (Bryan Ical, ya dado de baja) cumple la condicion; una
--    inasistencia de un alumno activo o suspendido, como la de Diego
--    (id_asistencia = 8), no se toca.
DELETE FROM asistencias
WHERE id_asistencia = 9
  AND estado = 'ausente'
  AND EXISTS (
      SELECT 1 FROM alumnos WHERE alumnos.id_alumno = asistencias.id_alumno AND alumnos.estado = 'inactivo'
  );

-- 4. Se elimina la asistencia duplicada (id_asistencia = 11): es una
--    copia exacta de la asistencia 1 por error de digitacion. DELETE
--    seguro porque usa el id exacto de la fila (esto si es un error
--    de captura, no un estado de negocio que corregir).
DELETE FROM asistencias
WHERE id_asistencia = 11;
