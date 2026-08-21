.headers on
.mode column

-- Ejercicio 67: ALTER TABLE Nivel Aplicado
-- Consultas de validacion.

-- 1. Mostrar todos los datos principales (citas con paciente y medico).
SELECT c.id_cita, p.nombre AS paciente, m.nombre AS medico,
       m.consultorio, c.fecha_hora_cita, c.motivo, c.estado
FROM citas c
JOIN pacientes p ON p.id_paciente = c.id_paciente
JOIN medicos m ON m.id_medico = c.id_medico;

-- 2. Consulta con WHERE: citas ya atendidas.
SELECT id_cita, fecha_hora_cita, motivo
FROM citas
WHERE estado = 'atendida';

-- 3. Consulta con ORDER BY: citas ordenadas por fecha y hora.
SELECT id_cita, fecha_hora_cita, estado
FROM citas
ORDER BY fecha_hora_cita;

-- 4. Conteo o resumen: total de citas por estado.
SELECT estado, COUNT(*) AS total
FROM citas
GROUP BY estado;

-- 5. Validacion especifica de ALTER TABLE: las 4 citas creadas antes de
-- las modificaciones conservaron su fecha original (ahora en la
-- columna renombrada fecha_hora_cita), y los 2 medicos originales ya
-- tienen consultorio asignado (dejo de ser 'Sin asignar').
SELECT id_cita, fecha_hora_cita
FROM citas
WHERE id_cita IN (1, 2, 3, 4);

SELECT nombre, consultorio
FROM medicos;

-- 6. Consulta de decision de negocio (nivel aplicado): medico con mas
-- citas atendidas, para decidir a quien asignarle mas horarios.
SELECT m.nombre AS medico,
       m.consultorio,
       COUNT(*) AS citas_atendidas
FROM citas c
JOIN medicos m ON m.id_medico = c.id_medico
WHERE c.estado = 'atendida'
GROUP BY m.id_medico
ORDER BY citas_atendidas DESC
LIMIT 1;
