.headers on
.mode column

-- Ejercicio 85: WHERE Nivel Aplicado
-- Consultas de validacion.

-- 1. Mostrar todos los datos principales.
SELECT c.id_cita, p.nombre_paciente, m.nombre_medico, c.fecha_cita, c.hora_cita, c.estado
FROM citas c
JOIN pacientes p ON p.id_paciente = c.id_paciente
JOIN medicos m ON m.id_medico = c.id_medico;

-- 2. Consulta con WHERE: agenda pendiente del 2026-08-20 (solo citas
-- programadas de ese dia especifico), ordenada por hora. Es el caso
-- de negocio: lo que la recepcion necesita ver esa manana.
SELECT c.id_cita, p.nombre_paciente, m.nombre_medico, c.hora_cita
FROM citas c
JOIN pacientes p ON p.id_paciente = c.id_paciente
JOIN medicos m ON m.id_medico = c.id_medico
WHERE c.fecha_cita = '2026-08-20' AND c.estado = 'programada'
ORDER BY c.hora_cita;

-- 3. Consulta con ORDER BY: todas las citas ordenadas por fecha y
-- hora.
SELECT id_cita, fecha_cita, hora_cita, estado
FROM citas
ORDER BY fecha_cita, hora_cita;

-- 4. Conteo o resumen: citas por estado.
SELECT estado, COUNT(*) AS total
FROM citas
GROUP BY estado;

-- 5. Caso de negocio con reporte final (nivel aplicado): pacientes
-- con 2 o mas citas canceladas, para que la clinica los contacte
-- antes de agendarles una cita nueva. Combina WHERE con una
-- subconsulta que a su vez usa GROUP BY y HAVING.
SELECT nombre_paciente, telefono
FROM pacientes
WHERE id_paciente IN (
    SELECT id_paciente
    FROM citas
    WHERE estado = 'cancelada'
    GROUP BY id_paciente
    HAVING COUNT(*) >= 2
);

-- Caso comentado que debe fallar (no ser recomendable), dejar
-- comentado: usar un alias de tabla que no se declaro en el FROM.
-- SELECT nombre_paciente FROM pacientes p WHERE x.nombre_paciente = 'Manuel Estrada';
