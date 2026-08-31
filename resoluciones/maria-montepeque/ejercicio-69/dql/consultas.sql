.headers on
.mode column

-- Ejercicio 69: DROP Nivel Intermedio
-- Consultas de validacion.

-- 1. Mostrar todos los datos principales (citas con paciente y medico).
SELECT c.id_cita, p.nombre AS paciente, m.nombre AS medico,
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

-- 5. Validacion especifica de DROP: la tabla temporal de medicos y la
-- vista de reporte que se usaron y luego se eliminaron ya no existen en
-- el catalogo de la base de datos, pero los 2 medicos migrados desde la
-- tabla temporal si siguen ahi.
SELECT name, type
FROM sqlite_master
WHERE name IN ('medicos_temporal', 'vista_citas_atendidas');
-- Debe devolver 0 filas: los 2 objetos se eliminaron con DROP.

SELECT nombre, especialidad
FROM medicos;
-- Los 2 medicos migrados desde la tabla temporal siguen disponibles.
