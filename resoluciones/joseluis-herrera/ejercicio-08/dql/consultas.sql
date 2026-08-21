SELECT
    id_cita,
    id_paciente,
    id_medico,
    id_consultorio,
    fecha_hora,
    motivo,
    estado
FROM citas;

SELECT
    id_cita,
    fecha_hora
FROM citas;

SELECT
    id_cita,
    fecha_hora,
    estado
FROM citas
WHERE fecha_hora >= '2026-08-05';

SELECT
    id_cita,
    fecha_hora,
    motivo
FROM citas
ORDER BY fecha_hora ASC;

SELECT
    m.nombre_completo AS medico,
    COUNT(c.id_cita) AS cantidad_citas
FROM medicos AS m
JOIN citas AS c
    ON m.id_medico = c.id_medico
GROUP BY m.id_medico, m.nombre_completo
ORDER BY cantidad_citas DESC
LIMIT 5;

SELECT COUNT(*) AS total_citas
FROM citas;

SELECT
    COUNT(*) AS total_citas,
    MIN(fecha_hora) AS primera_cita,
    MAX(fecha_hora) AS ultima_cita
FROM citas;

SELECT
    estado,
    COUNT(*) AS cantidad_citas
FROM citas
GROUP BY estado;

SELECT
    c.id_cita,
    p.nombre_completo AS paciente,
    m.nombre_completo AS medico,
    c.fecha_hora
FROM citas AS c
JOIN pacientes AS p
    ON c.id_paciente = p.id_paciente
JOIN medicos AS m
    ON c.id_medico = m.id_medico;

SELECT
    c.id_cita,
    p.nombre_completo AS paciente,
    m.nombre_completo AS medico,
    c.fecha_hora
FROM citas AS c
JOIN pacientes AS p
    ON c.id_paciente = p.id_paciente
JOIN medicos AS m
    ON c.id_medico = m.id_medico
WHERE c.estado = 'ATENDIDA'
ORDER BY c.fecha_hora DESC
LIMIT 5;

SELECT
    c.id_cita AS "Cita",
    p.nombre_completo AS "Paciente",
    m.nombre_completo AS "Medico",
    m.especialidad AS "Especialidad",
    co.numero AS "Consultorio",
    c.fecha_hora AS "Fecha y Hora",
    c.estado AS "Estado"
FROM citas AS c
JOIN pacientes AS p
    ON c.id_paciente = p.id_paciente
JOIN medicos AS m
    ON c.id_medico = m.id_medico
JOIN consultorios AS co
    ON c.id_consultorio = co.id_consultorio
ORDER BY c.fecha_hora;

SELECT
    m.nombre_completo AS medico,
    m.especialidad,
    COUNT(c.id_cita) AS citas_asignadas,
    CASE
        WHEN COUNT(c.id_cita) >= 3 THEN 'AUMENTAR DISPONIBILIDAD'
        WHEN COUNT(c.id_cita) = 2 THEN 'MANTENER AGENDA'
        ELSE 'DISPONIBILIDAD LIBRE'
    END AS decision
FROM medicos AS m
LEFT JOIN citas AS c
    ON m.id_medico = c.id_medico
GROUP BY m.id_medico, m.nombre_completo, m.especialidad
ORDER BY citas_asignadas DESC;