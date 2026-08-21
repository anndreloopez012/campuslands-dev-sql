PRAGMA foreign_keys = ON;

-- 1. LISTAR TODOS LOS REGISTROS DE LA ENTIDAD CENTRAL

SELECT
    id_cita,
    id_paciente,
    id_medico,
    id_consultorio,
    fecha_hora,
    motivo,
    estado
FROM citas;

-- 2. MOSTRAR DOS COLUMNAS RELEVANTES

SELECT
    fecha_hora,
    estado
FROM citas;

-- 3. FILTRAR POR FECHA

SELECT
    id_cita,
    fecha_hora,
    motivo,
    estado
FROM citas
WHERE fecha_hora >= '2026-08-22 00:00';

-- 4. ORDENAR POR FECHA

SELECT
    id_cita,
    fecha_hora,
    motivo
FROM citas
ORDER BY fecha_hora ASC;

-- 5. CINCO REGISTROS MAS IMPORTANTES SEGUN FECHA

SELECT
    id_cita,
    fecha_hora,
    motivo,
    estado
FROM citas
WHERE estado IN ('Programada', 'Confirmada')
ORDER BY fecha_hora ASC
LIMIT 5;

-- 6. CONTAR REGISTROS TOTALES

SELECT
    COUNT(*) AS total_citas
FROM citas;

-- 7. CALCULAR MINIMO Y MAXIMO DE CITAS POR MEDICO

SELECT
    MIN(total_citas) AS minimo_citas_por_medico,
    MAX(total_citas) AS maximo_citas_por_medico
FROM (
    SELECT
        id_medico,
        COUNT(*) AS total_citas
    FROM citas
    GROUP BY id_medico
);

-- 8. AGRUPAR CITAS POR ESTADO

SELECT
    estado,
    COUNT(*) AS total_citas
FROM citas
GROUP BY estado
ORDER BY total_citas DESC;

-- 9. RELACIONAR PACIENTES Y CITAS

SELECT
    p.nombre_completo AS paciente,
    c.fecha_hora,
    c.motivo,
    c.estado
FROM pacientes AS p
INNER JOIN citas AS c
    ON c.id_paciente = p.id_paciente
ORDER BY c.fecha_hora ASC;

-- 10. WHERE, ORDER BY Y LIMIT

SELECT
    id_cita,
    fecha_hora,
    estado
FROM citas
WHERE estado = 'Confirmada'
ORDER BY fecha_hora ASC
LIMIT 5;

-- 11. REPORTE CON ALIAS LEGIBLES

SELECT
    c.id_cita AS "ID Cita",
    p.nombre_completo AS "Paciente",
    m.nombre_completo AS "Medico",
    m.especialidad AS "Especialidad",
    co.numero AS "Consultorio",
    c.fecha_hora AS "Fecha y Hora",
    c.estado AS "Estado"
FROM citas AS c
INNER JOIN pacientes AS p
    ON p.id_paciente = c.id_paciente
INNER JOIN medicos AS m
    ON m.id_medico = c.id_medico
INNER JOIN consultorios AS co
    ON co.id_consultorio = c.id_consultorio
ORDER BY c.fecha_hora ASC;

-- 12. DECISION DE NEGOCIO: MEDICOS CON MAYOR CARGA DE CITAS

SELECT
    m.nombre_completo AS "Medico",
    m.especialidad AS "Especialidad",
    COUNT(c.id_cita) AS "Citas Asignadas",
    CASE
        WHEN COUNT(c.id_cita) >= 3 THEN 'Alta demanda'
        WHEN COUNT(c.id_cita) = 2 THEN 'Demanda media'
        ELSE 'Baja demanda'
    END AS "Nivel de Demanda"
FROM medicos AS m
LEFT JOIN citas AS c
    ON c.id_medico = m.id_medico
    AND c.estado <> 'Cancelada'
GROUP BY
    m.id_medico,
    m.nombre_completo,
    m.especialidad
ORDER BY COUNT(c.id_cita) DESC;