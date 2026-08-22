SELECT
    p.nombre_completo AS paciente,
    p.dpi,
    m.nombre_completo AS medico,
    e.nombre AS especialidad,
    GROUP_CONCAT(t.nombre, ', ') AS tratamientos,
    GROUP_CONCAT(t.costo, ', ') AS costos,
    c.fecha_consulta
FROM consultas c
JOIN pacientes p
    ON c.id_paciente = p.id_paciente
JOIN medicos m
    ON c.id_medico = m.id_medico
JOIN especialidades e
    ON m.id_especialidad = e.id_especialidad
JOIN detalle_tratamiento dt
    ON c.id_consulta = dt.id_consulta
JOIN tratamientos t
    ON dt.id_tratamiento = t.id_tratamiento
GROUP BY c.id_consulta
ORDER BY c.fecha_consulta;

SELECT DISTINCT
    nombre_completo AS paciente
FROM pacientes
ORDER BY paciente;

SELECT DISTINCT
    nombre_completo AS medico
FROM medicos
ORDER BY medico;

SELECT DISTINCT
    nombre AS especialidad
FROM especialidades
ORDER BY especialidad;

SELECT
    e.nombre AS especialidad,
    COUNT(m.id_medico) AS cantidad_medicos
FROM especialidades e
LEFT JOIN medicos m
    ON e.id_especialidad = m.id_especialidad
GROUP BY e.id_especialidad, e.nombre
ORDER BY cantidad_medicos DESC;

SELECT
    c.id_consulta,
    p.nombre_completo AS paciente,
    ROUND(SUM(dt.cantidad * t.costo), 2) AS total_tratamiento
FROM consultas c
JOIN pacientes p
    ON c.id_paciente = p.id_paciente
JOIN detalle_tratamiento dt
    ON c.id_consulta = dt.id_consulta
JOIN tratamientos t
    ON dt.id_tratamiento = t.id_tratamiento
GROUP BY c.id_consulta, p.nombre_completo
ORDER BY c.id_consulta;

SELECT
    ROUND(AVG(costo), 2) AS costo_promedio,
    MIN(costo) AS costo_minimo,
    MAX(costo) AS costo_maximo
FROM tratamientos;

SELECT
    id_paciente,
    nombre_completo,
    dpi
FROM pacientes
WHERE nombre_completo LIKE '%López%'
ORDER BY nombre_completo;

SELECT
    id_consulta,
    fecha_consulta,
    diagnostico
FROM consultas
WHERE date(fecha_consulta) BETWEEN '2026-08-01' AND '2026-08-05'
ORDER BY fecha_consulta;

SELECT
    id_tratamiento,
    nombre,
    costo
FROM tratamientos
WHERE costo BETWEEN 200 AND 500
ORDER BY costo;

SELECT
    t.nombre AS tratamiento,
    SUM(dt.cantidad) AS cantidad_aplicada,
    ROUND(SUM(dt.cantidad * t.costo), 2) AS monto_total
FROM detalle_tratamiento dt
JOIN tratamientos t
    ON dt.id_tratamiento = t.id_tratamiento
GROUP BY t.id_tratamiento, t.nombre
ORDER BY monto_total DESC
LIMIT 5;

SELECT
    c.id_consulta,
    p.nombre_completo AS paciente,
    c.fecha_consulta,
    c.estado
FROM consultas c
JOIN pacientes p
    ON c.id_paciente = p.id_paciente
LEFT JOIN detalle_tratamiento dt
    ON c.id_consulta = dt.id_consulta
WHERE dt.id_consulta IS NULL;

SELECT
    c.id_consulta AS consulta,
    p.nombre_completo AS paciente,
    p.dpi AS dpi,
    m.nombre_completo AS medico,
    e.nombre AS especialidad,
    c.fecha_consulta AS fecha_consulta,
    c.diagnostico AS diagnostico,
    c.estado AS estado_consulta,
    COUNT(DISTINCT dt.id_tratamiento) AS tratamientos,
    ROUND(COALESCE(SUM(dt.cantidad * t.costo), 0), 2) AS costo_total
FROM consultas c
JOIN pacientes p
    ON c.id_paciente = p.id_paciente
JOIN medicos m
    ON c.id_medico = m.id_medico
JOIN especialidades e
    ON m.id_especialidad = e.id_especialidad
LEFT JOIN detalle_tratamiento dt
    ON c.id_consulta = dt.id_consulta
LEFT JOIN tratamientos t
    ON dt.id_tratamiento = t.id_tratamiento
GROUP BY
    c.id_consulta,
    p.nombre_completo,
    p.dpi,
    m.nombre_completo,
    e.nombre,
    c.fecha_consulta,
    c.diagnostico,
    c.estado
ORDER BY c.fecha_consulta;

SELECT
    estado,
    COUNT(*) AS cantidad_consultas
FROM consultas
GROUP BY estado
ORDER BY cantidad_consultas DESC;