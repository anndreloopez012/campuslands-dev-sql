.headers on
.mode column

-- Ejercicio 51: UNIQUE Nivel Intermedio
-- Consultas de validacion.

-- 1. Mostrar todos los datos principales.
SELECT * FROM citas;

-- 2. Consulta con WHERE.
SELECT id_cita, id_medico, fecha_hora
FROM citas
WHERE estado = 'programada';

-- 3. Consulta con ORDER BY.
SELECT id_medico, fecha_hora, estado
FROM citas
ORDER BY fecha_hora;

-- 4. Conteo o resumen.
SELECT
    COUNT(*) AS total_citas,
    COUNT(DISTINCT id_medico) AS medicos_con_citas
FROM citas;

-- 5. Validacion especifica del tema UNIQUE:
--    a) el mismo id_medico se repite en varias citas (horas distintas) sin
--       problema: UNIQUE aplica a la COMBINACION (id_medico, fecha_hora),
--       no a id_medico por si solo.
SELECT id_medico, COUNT(*) AS cantidad_citas
FROM citas
GROUP BY id_medico
ORDER BY cantidad_citas DESC;

--    b) confirmar que nunca hay dos citas con el mismo medico Y la misma
--       hora: si UNIQUE no estuviera funcionando, esta consulta devolveria
--       filas con conteo mayor a 1.
SELECT id_medico, fecha_hora, COUNT(*) AS veces
FROM citas
GROUP BY id_medico, fecha_hora
HAVING COUNT(*) > 1;
