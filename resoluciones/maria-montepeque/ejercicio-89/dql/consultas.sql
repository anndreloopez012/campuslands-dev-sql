.headers on
.mode column

-- Ejercicio 89: GROUP BY Nivel Basico
-- Consultas de validacion.

-- 1. Mostrar todos los datos principales.
SELECT c.id_cita, p.nombre_paciente, m.nombre_medico, c.fecha_cita, c.duracion_minutos, c.estado
FROM citas c
JOIN pacientes p ON p.id_paciente = c.id_paciente
JOIN medicos m ON m.id_medico = c.id_medico;

-- 2. Consulta con WHERE: solo las citas programadas.
SELECT id_cita, id_medico, duracion_minutos
FROM citas
WHERE estado = 'programada';

-- 3. Consulta con ORDER BY: citas ordenadas por fecha.
SELECT id_cita, fecha_cita, estado
FROM citas
ORDER BY fecha_cita;

-- 4. Conteo o resumen: total de citas por medico (GROUP BY simple).
SELECT id_medico, COUNT(*) AS total_citas
FROM citas
GROUP BY id_medico;

-- 5. Validacion especifica de GROUP BY: por cada medico, suma y
-- promedio de la duracion de sus citas, filtrando con HAVING solo a
-- los medicos cuyo promedio supera los 30 minutos. HAVING filtra
-- despues de agrupar (a diferencia de WHERE, que filtraria antes de
-- agrupar y no puede usar funciones de agregacion).
SELECT m.nombre_medico,
       COUNT(*) AS total_citas,
       SUM(c.duracion_minutos) AS minutos_totales,
       ROUND(AVG(c.duracion_minutos), 2) AS promedio_minutos
FROM citas c
JOIN medicos m ON m.id_medico = c.id_medico
GROUP BY m.id_medico, m.nombre_medico
HAVING AVG(c.duracion_minutos) > 30;

-- Caso comentado que debe fallar (no ser recomendable), dejar
-- comentado: usar una funcion de agregacion (COUNT) dentro de WHERE
-- en vez de HAVING. Las funciones de agregacion solo se pueden usar
-- despues de que GROUP BY forma los grupos, y WHERE se evalua antes.
-- SELECT id_medico, COUNT(*) FROM citas WHERE COUNT(*) > 2 GROUP BY id_medico;
