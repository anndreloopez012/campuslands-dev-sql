.headers on
.mode column

-- Ejercicio 87: ORDER BY Nivel Intermedio
-- Consultas de validacion.

-- 1. Mostrar todos los datos principales.
SELECT c.id_cita, p.nombre_paciente, m.nombre_medico, c.fecha_cita, c.hora_cita, c.estado
FROM citas c
JOIN pacientes p ON p.id_paciente = c.id_paciente
JOIN medicos m ON m.id_medico = c.id_medico;

-- 2. Consulta con WHERE: citas del medico 1.
SELECT id_cita, fecha_cita, hora_cita, estado
FROM citas
WHERE id_medico = 1;

-- 3. Consulta con ORDER BY: citas ordenadas por fecha y hora.
SELECT id_cita, fecha_cita, hora_cita
FROM citas
ORDER BY fecha_cita, hora_cita;

-- 4. Conteo o resumen: citas por estado.
SELECT estado, COUNT(*) AS total
FROM citas
GROUP BY estado;

-- 5. Validacion especifica de ORDER BY (nivel intermedio): orden por
-- prioridad de negocio en vez de orden alfabetico, usando CASE WHEN
-- dentro del ORDER BY, combinado con LIMIT para quedarse solo con las
-- 3 proximas citas mas urgentes (las programadas van primero, sin
-- importar que "atendida" y "cancelada" vengan antes alfabeticamente).
SELECT c.id_cita, p.nombre_paciente, c.fecha_cita, c.hora_cita, c.estado
FROM citas c
JOIN pacientes p ON p.id_paciente = c.id_paciente
ORDER BY
    CASE c.estado
        WHEN 'programada' THEN 1
        WHEN 'atendida' THEN 2
        WHEN 'cancelada' THEN 3
    END,
    c.fecha_cita,
    c.hora_cita
LIMIT 3;

-- Caso comentado que debe fallar (no ser recomendable), dejar
-- comentado: escribir mal el nombre de la columna en el ORDER BY
-- (typo: "horacita" en vez de "hora_cita").
-- SELECT estado, COUNT(*) FROM citas GROUP BY estado ORDER BY horacita;
