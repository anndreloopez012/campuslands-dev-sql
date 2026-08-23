-- Ejercicio 34: Normalizacion Clinica Tratamientos

-- 1. Reconstruir una vista similar al archivo original usando JOIN
-- (una fila por cada tratamiento de cada consulta, como quedaria "aplanado" el CSV original)
SELECT
    c.id_consulta,
    p.nombre AS paciente,
    p.dpi AS dpi,
    m.nombre AS medico,
    e.nombre AS especialidad,
    t.nombre AS tratamiento,
    t.costo AS costo,
    c.fecha_consulta AS fecha_consulta
FROM consultas c
JOIN pacientes p ON p.id_paciente = c.id_paciente
JOIN medicos m ON m.id_medico = c.id_medico
JOIN especialidades e ON e.id_especialidad = m.id_especialidad
JOIN tratamientos t ON t.id_consulta = c.id_consulta
ORDER BY c.id_consulta;

-- 2. Listar entidades principales sin duplicados
SELECT DISTINCT nombre, dpi FROM pacientes;
SELECT DISTINCT nombre FROM medicos;
SELECT DISTINCT nombre FROM especialidades;
SELECT DISTINCT nombre FROM tratamientos;

-- 3. Contar registros por categoria o estado (tratamientos por especialidad)
SELECT e.nombre AS especialidad, COUNT(*) AS tratamientos_aplicados
FROM tratamientos t
JOIN consultas c ON c.id_consulta = t.id_consulta
JOIN medicos m ON m.id_medico = c.id_medico
JOIN especialidades e ON e.id_especialidad = m.id_especialidad
GROUP BY e.nombre;

-- 4. Calcular un total por transaccion (costo total por consulta)
SELECT c.id_consulta, SUM(t.costo) AS total_consulta
FROM consultas c
JOIN tratamientos t ON t.id_consulta = c.id_consulta
GROUP BY c.id_consulta;

-- 5. Calcular promedio, minimo y maximo del costo de los tratamientos
SELECT
    AVG(costo) AS promedio,
    MIN(costo) AS minimo,
    MAX(costo) AS maximo
FROM tratamientos;

-- 6. Buscar registros por texto con LIKE
SELECT * FROM pacientes WHERE nombre LIKE 'Rosa%';
SELECT * FROM tratamientos WHERE nombre LIKE '%Limpieza%';

-- 7. Filtrar por fecha o rango numerico
SELECT * FROM consultas WHERE fecha_consulta >= '2026-06-10';
SELECT * FROM tratamientos WHERE costo BETWEEN 200 AND 350;

-- 8. Mostrar top 5 por cantidad o monto (pacientes con mayor gasto total)
SELECT p.nombre AS paciente, SUM(t.costo) AS gasto_total
FROM tratamientos t
JOIN consultas c ON c.id_consulta = t.id_consulta
JOIN pacientes p ON p.id_paciente = c.id_paciente
GROUP BY p.nombre
ORDER BY gasto_total DESC
LIMIT 5;

-- 9. Detectar registros relacionados sin detalle (consultas sin tratamientos registrados)
SELECT c.id_consulta, p.nombre AS paciente, m.nombre AS medico
FROM consultas c
JOIN pacientes p ON p.id_paciente = c.id_paciente
JOIN medicos m ON m.id_medico = c.id_medico
LEFT JOIN tratamientos t ON t.id_consulta = c.id_consulta
WHERE t.id_tratamiento IS NULL;

-- 10. Reporte final con alias legibles
SELECT
    p.nombre AS paciente,
    m.nombre AS medico,
    e.nombre AS especialidad,
    t.nombre AS tratamiento,
    t.costo AS costo_tratamiento,
    c.fecha_consulta AS fecha_consulta
FROM consultas c
JOIN pacientes p ON p.id_paciente = c.id_paciente
JOIN medicos m ON m.id_medico = c.id_medico
JOIN especialidades e ON e.id_especialidad = m.id_especialidad
JOIN tratamientos t ON t.id_consulta = c.id_consulta
ORDER BY c.id_consulta;
