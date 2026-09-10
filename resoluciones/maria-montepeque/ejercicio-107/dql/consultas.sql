.headers on
.mode column

-- Ejercicio 107: Indices Nivel Basico
-- Consultas de validacion.

-- 1. Mostrar todos los datos principales.
SELECT id_cita, nombre_paciente, nombre_medico, fecha_cita, hora_cita, estado
FROM citas;

-- 2. Consulta con WHERE: solo las citas del 2026-09-01 (usa idx_citas_fecha).
SELECT id_cita, nombre_paciente, nombre_medico, hora_cita
FROM citas
WHERE fecha_cita = '2026-09-01';

-- 3. Consulta con ORDER BY: agenda ordenada por fecha y hora.
SELECT id_cita, fecha_cita, hora_cita, estado
FROM citas
ORDER BY fecha_cita, hora_cita;

-- 4. Conteo o resumen: total de citas por fecha.
SELECT fecha_cita, COUNT(*) AS total_citas
FROM citas
GROUP BY fecha_cita;

-- 5. Validacion especifica de Indices: EXPLAIN QUERY PLAN confirma
-- que la misma consulta de la 2 (filtrar por fecha_cita) usa
-- idx_citas_fecha para buscar directamente (SEARCH) en vez de
-- revisar fila por fila toda la tabla (SCAN). Este es el proposito
-- central de un indice: acelerar las busquedas frecuentes por la
-- columna indexada.
EXPLAIN QUERY PLAN
SELECT id_cita, nombre_paciente, hora_cita
FROM citas
WHERE fecha_cita = '2026-09-01';

-- Caso comentado que no es recomendable, dejar comentado: crear un
-- indice UNICO sobre nombre_paciente, asumiendo (de forma incorrecta)
-- que cada paciente aparece una sola vez en "citas". Un mismo
-- paciente puede tener varias citas (aqui, "Ana Lopez" aparece 2
-- veces), asi que esa columna NO deberia ser unica. Se verifico con
-- Python (sqlite3) que SQLite rechaza la creacion del indice con el
-- error "UNIQUE constraint failed: citas.nombre_paciente" apenas
-- encuentra el segundo "Ana Lopez".
-- CREATE UNIQUE INDEX idx_pacientes_unicos ON citas (nombre_paciente);
