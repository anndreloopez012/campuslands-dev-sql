.headers on
.mode column

-- Ejercicio 49: FOREIGN KEY Nivel Aplicado
-- Consultas de validacion y reporte final.

-- 1. Mostrar todos los datos principales.
SELECT * FROM citas;

-- 2. Consulta con WHERE.
SELECT id_cita, id_paciente, id_medico, fecha_cita
FROM citas
WHERE estado = 'programada';

-- 3. Consulta con ORDER BY.
SELECT id_cita, fecha_cita, estado
FROM citas
ORDER BY fecha_cita;

-- 4. Conteo o resumen.
SELECT
    COUNT(*) AS total_citas,
    SUM(CASE WHEN id_medico IS NULL THEN 1 ELSE 0 END) AS citas_sin_medico_asignado
FROM citas;

-- 5. Validacion especifica del tema FOREIGN KEY:
--    a) ON DELETE RESTRICT protege el historial clinico: todo paciente que
--       aparece en citas sigue existiendo en pacientes (se demuestra en el
--       caso comentado del DML; aqui se confirma que Jorge Alvarado sigue
--       en el catalogo con sus citas intactas).
SELECT p.nombre AS paciente, COUNT(*) AS cantidad_citas
FROM citas c
JOIN pacientes p ON p.id_paciente = c.id_paciente
GROUP BY p.nombre
ORDER BY cantidad_citas DESC;

--    b) ON DELETE SET NULL ya se ejecuto en el DML (se borro el Dr. Felipe
--       Ramos, id_medico = 4): esta consulta confirma que sus 3 citas
--       siguen existiendo, solo que ahora con id_medico = NULL, en vez de
--       haberse eliminado o haber bloqueado el borrado del medico.
SELECT id_cita, id_paciente, fecha_cita, estado
FROM citas
WHERE id_medico IS NULL;

-- Reporte final de negocio: citas por medico, mostrando "Medico no
-- disponible" (via COALESCE) para las citas que quedaron con id_medico NULL
-- tras el SET NULL, sin perderlas del reporte.
SELECT
    COALESCE(m.nombre, 'Medico no disponible') AS medico,
    COUNT(*) AS cantidad_citas
FROM citas c
LEFT JOIN medicos m ON m.id_medico = c.id_medico
GROUP BY medico
ORDER BY cantidad_citas DESC;
