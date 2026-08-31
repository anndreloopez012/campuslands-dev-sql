.headers on
.mode column

-- Ejercicio 105: Triggers Nivel Intermedio
-- Consultas de validacion.

-- 1. Mostrar todos los datos principales.
SELECT c.id_cita, p.nombre_paciente, m.nombre_medico, c.fecha_cita, c.hora_cita, c.estado
FROM citas c
JOIN pacientes p ON p.id_paciente = c.id_paciente
JOIN medicos m ON m.id_medico = c.id_medico;

-- 2. Consulta con WHERE: solo las citas que siguen programadas.
SELECT id_cita, id_paciente, id_medico, fecha_cita, hora_cita
FROM citas
WHERE estado = 'programada';

-- 3. Consulta con ORDER BY: agenda ordenada por fecha y hora.
SELECT id_cita, id_medico, fecha_cita, hora_cita, estado
FROM citas
ORDER BY fecha_cita, hora_cita;

-- 4. Conteo o resumen: total de citas por medico.
SELECT id_medico, COUNT(*) AS total_citas
FROM citas
GROUP BY id_medico;

-- 5. Validacion especifica de Triggers: citas_auditoria debe tener
-- exactamente 2 filas (una por cada UPDATE de dml/inserts.sql),
-- generadas SOLAS por trg_auditar_cambio_estado_cita, sin ningun
-- INSERT manual sobre esa tabla. Esto demuestra que el trigger
-- cumple su proposito: automatizar el registro de auditoria ante
-- cambios de estado en "citas".
SELECT id_auditoria, id_cita, estado_anterior, estado_nuevo
FROM citas_auditoria
ORDER BY id_auditoria;

-- Caso comentado que no es recomendable, dejar comentado: intentar
-- modificar la cita 3, que ya quedo "atendida" en dml/inserts.sql
-- (registro historico cerrado). Se verifico con Python (sqlite3) que
-- trg_bloquear_edicion_cita_atendida aborta la operacion con el error
-- "No se puede modificar una cita que ya fue atendida" antes de que
-- el UPDATE llegue a aplicarse, y como el trigger BEFORE UPDATE
-- cancelo la operacion, trg_auditar_cambio_estado_cita (que es
-- AFTER UPDATE) nunca llega a dispararse.
-- UPDATE citas SET estado = 'cancelada' WHERE id_cita = 3;
