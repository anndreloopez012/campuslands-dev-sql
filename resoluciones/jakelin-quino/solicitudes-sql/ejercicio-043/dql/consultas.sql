.headers on
.mode column

-- Ejercicio 043: Escuela de Dibujo
-- 1. Cursos impartidos por cada profesor
SELECT c.titulo, c.costo, p.nombre AS profesor FROM cursos c JOIN profesores p ON p.id = c.profesor_id;

-- 2. Alumnos inscritos por curso
SELECT i.id, i.alumno, c.titulo AS curso FROM inscripciones i JOIN cursos c ON c.id = i.curso_id;

-- 3. Ingresos totales recaudados por curso
SELECT c.titulo, COUNT(i.id) AS alumnos, SUM(c.costo) AS recaudado FROM inscripciones i JOIN cursos c ON c.id = i.curso_id GROUP BY c.id, c.titulo;