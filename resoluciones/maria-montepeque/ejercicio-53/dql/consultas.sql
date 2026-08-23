.headers on
.mode column

-- Ejercicio 53: NOT NULL Nivel Basico
-- Consultas de validacion.

-- 1. Mostrar todos los datos principales.
SELECT * FROM citas;

-- 2. Consulta con WHERE.
SELECT id_cita, id_paciente, fecha_hora
FROM citas
WHERE estado = 'programada';

-- 3. Consulta con ORDER BY.
SELECT id_cita, fecha_hora, estado
FROM citas
ORDER BY fecha_hora;

-- 4. Conteo o resumen.
SELECT COUNT(*) AS total_citas FROM citas;

-- 5. Validacion especifica del tema NOT NULL:
--    a) ninguna cita puede tener fecha_hora vacia: el conteo de citas con
--       fecha_hora no nulo es igual al total de citas.
SELECT
    COUNT(*) AS total_citas,
    COUNT(fecha_hora) AS citas_con_fecha
FROM citas;

--    b) contraste con un campo OPCIONAL (correo en pacientes): aqui si es
--       normal que falten valores, y NOT NULL nunca lo exigio.
SELECT
    COUNT(*) AS total_pacientes,
    COUNT(correo) AS pacientes_con_correo,
    COUNT(*) - COUNT(correo) AS pacientes_sin_correo
FROM pacientes;
