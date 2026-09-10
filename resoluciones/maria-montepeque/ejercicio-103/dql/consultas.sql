.headers on
.mode column

-- Ejercicio 103: Procedimientos almacenados Nivel Aplicado
-- Consultas de validacion.

-- 1. Mostrar todos los datos principales.
SELECT c.id_cita, p.nombre_paciente, m.nombre_medico, c.fecha_cita, c.hora_cita, c.estado
FROM citas c
JOIN pacientes p ON p.id_paciente = c.id_paciente
JOIN medicos m ON m.id_medico = c.id_medico;

-- 2. Consulta con WHERE: solo las citas del 2026-09-01.
SELECT id_cita, id_paciente, id_medico, hora_cita
FROM citas
WHERE fecha_cita = '2026-09-01';

-- 3. Consulta con ORDER BY: agenda del dia ordenada por medico y hora.
SELECT id_medico, fecha_cita, hora_cita, estado
FROM citas
ORDER BY id_medico, fecha_cita, hora_cita;

-- 4. Conteo o resumen: total de citas por medico.
SELECT id_medico, COUNT(*) AS total_citas
FROM citas
GROUP BY id_medico;

-- 5. Caso de negocio con Procedimientos almacenados (via su
-- alternativa ejecutable, el trigger): agendar una cita nueva en un
-- horario libre para "Dra. Sofia Martinez" (id_medico = 1), que no
-- choca con ninguna de sus citas existentes. Este es el reporte /
-- validacion final que el negocio necesita: la agenda solo acepta
-- citas nuevas cuando de verdad hay espacio libre.
INSERT INTO citas (id_paciente, id_medico, fecha_cita, hora_cita)
VALUES (4, 1, '2026-09-01', '11:00');

SELECT id_cita, id_medico, fecha_cita, hora_cita, estado
FROM citas
WHERE id_medico = 1
ORDER BY fecha_cita, hora_cita;

-- Caso comentado que no es recomendable, dejar comentado: intentar
-- agendar otra cita para "Dra. Sofia Martinez" (id_medico = 1) el
-- 2026-09-01 a las 09:00, horario que ya tiene ocupado con la
-- paciente Ana Lopez (ver dml/inserts.sql). Se verifico con Python
-- (sqlite3) que trg_validar_choque_agenda aborta la operacion con el
-- error "El medico ya tiene una cita programada en esa fecha y hora"
-- y la cita no llega a registrarse: es la misma validacion que, en el
-- procedimiento almacenado teorico, se resolveria con un
-- SIGNAL SQLSTATE (MySQL) o un RAISE EXCEPTION (PostgreSQL).
-- INSERT INTO citas (id_paciente, id_medico, fecha_cita, hora_cita)
-- VALUES (5, 1, '2026-09-01', '09:00');
