.headers on
.mode column

-- Ejercicio 068: Escuela de Dibujo
-- Consultas que responden preguntas reales del cliente.

-- 1. Que registros principales existen: todas las entregas con alumno
-- y curso.
SELECT e.id_entrega,
       a.nombre AS alumno,
       c.nombre AS curso,
       e.titulo_obra,
       e.fecha_entrega,
       e.estado
FROM entregas e
JOIN alumnos a ON a.id_alumno = e.id_alumno
JOIN cursos c ON c.id_curso = e.id_curso;

-- 2. Que registros estan pendientes, evaluados o rechazados.
SELECT id_entrega, estado
FROM entregas
ORDER BY estado;

-- 3. Que alumno tiene mas actividad (ranking por numero de entregas).
SELECT a.nombre AS alumno,
       COUNT(*) AS total_entregas
FROM entregas e
JOIN alumnos a ON a.id_alumno = e.id_alumno
GROUP BY a.id_alumno
ORDER BY total_entregas DESC;

-- 4. Entregas ordenadas por fecha, de la mas reciente a la mas antigua.
SELECT id_entrega, fecha_entrega, estado
FROM entregas
ORDER BY fecha_entrega DESC;

-- 5. Reporte para decision de negocio: promedio de notas por alumno,
-- para decidir a quien destacar o becar (GROUP BY + HAVING).
SELECT a.nombre AS alumno,
       COUNT(*) AS entregas_evaluadas,
       ROUND(AVG(ev.nota), 1) AS promedio_nota
FROM evaluaciones ev
JOIN entregas e ON e.id_entrega = ev.id_entrega
JOIN alumnos a ON a.id_alumno = e.id_alumno
GROUP BY a.id_alumno
HAVING COUNT(*) >= 1
ORDER BY promedio_nota DESC;
