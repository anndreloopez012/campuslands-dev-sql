-- Ejercicio 08: Clinica de Citas
-- Entidad central: citas

-- 1. Listar todos los registros principales de la entidad central
SELECT * FROM citas;

-- 2. Mostrar solo dos columnas relevantes
SELECT fecha_hora, estado FROM citas;

-- 3. Filtrar registros por una condicion de fecha
SELECT * FROM citas WHERE fecha_hora >= '2026-08-06';

-- 4. Ordenar resultados por fecha
SELECT * FROM citas ORDER BY fecha_hora;

-- 5. Mostrar las 5 citas mas proximas
SELECT * FROM citas ORDER BY fecha_hora ASC LIMIT 5;

-- 6. Contar registros totales
SELECT COUNT(*) AS total_citas FROM citas;

-- 7. Contar citas por dia (usa MIN/MAX de fecha como referencia)
SELECT
    MIN(fecha_hora) AS primera_cita,
    MAX(fecha_hora) AS ultima_cita,
    COUNT(*) AS total
FROM citas;

-- 8. Agrupar citas por estado
SELECT estado, COUNT(*) AS cantidad
FROM citas
GROUP BY estado;

-- 9. Relacionar citas, pacientes y medicos con JOIN
SELECT c.id_cita, p.nombre AS paciente, m.nombre AS medico
FROM citas c
JOIN pacientes p ON p.id_paciente = c.id_paciente
JOIN medicos m ON m.id_medico = c.id_medico;

-- 10. WHERE + ORDER BY + LIMIT
SELECT * FROM citas
WHERE estado = 'programada'
ORDER BY fecha_hora
LIMIT 3;

-- 11. Reporte con alias legibles
SELECT
    p.nombre AS paciente,
    m.nombre AS medico,
    m.especialidad AS especialidad,
    co.numero AS consultorio,
    c.fecha_hora AS fecha_cita,
    c.estado AS estado_actual
FROM citas c
JOIN pacientes p ON p.id_paciente = c.id_paciente
JOIN medicos m ON m.id_medico = c.id_medico
JOIN consultorios co ON co.id_consultorio = c.id_consultorio;

-- 12. Consulta para decision de negocio: medico con mas citas atendidas
SELECT m.nombre, COUNT(*) AS citas_atendidas
FROM citas c
JOIN medicos m ON m.id_medico = c.id_medico
WHERE c.estado = 'atendida'
GROUP BY m.nombre
ORDER BY citas_atendidas DESC
LIMIT 1;
