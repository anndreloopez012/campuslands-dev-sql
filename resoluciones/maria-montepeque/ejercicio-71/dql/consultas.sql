.headers on
.mode column

-- Ejercicio 71: INSERT Nivel Basico
-- Consultas de validacion.

-- 1. Mostrar todos los datos principales (citas con paciente y
-- medico).
SELECT c.id_cita, p.nombre_paciente, m.nombre_medico,
       c.fecha_cita, c.estado
FROM citas c
JOIN pacientes p ON p.id_paciente = c.id_paciente
JOIN medicos m ON m.id_medico = c.id_medico;

-- 2. Consulta con WHERE: citas ya atendidas.
SELECT id_cita, fecha_cita
FROM citas
WHERE estado = 'atendida';

-- 3. Consulta con ORDER BY: citas ordenadas por fecha.
SELECT id_cita, fecha_cita, estado
FROM citas
ORDER BY fecha_cita;

-- 4. Conteo o resumen: total de citas por estado.
SELECT estado, COUNT(*) AS total
FROM citas
GROUP BY estado;

-- 5. Validacion especifica de INSERT: las citas 3 y 4 se insertaron
-- SIN indicar estado, y aun asi quedaron completas gracias al
-- DEFAULT ('programada'). Esto confirma que el INSERT multiple con
-- columnas parciales cumplio su proposito: no quedo ninguna fila con
-- datos faltantes.
SELECT id_cita, fecha_cita, estado
FROM citas
WHERE id_cita IN (3, 4);
