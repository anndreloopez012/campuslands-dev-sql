.headers on
.mode column

-- Ejercicio 032: Academia Kickboxing
-- 1. Alumnos inscritos activos
SELECT i.id, a.nombre AS alumno, p.nombre AS plan, i.fecha FROM inscripciones i JOIN alumnos a ON a.id = i.alumno_id JOIN planes p ON p.id = i.plan_id WHERE i.estado = 'activo';

-- 2. Planes y precios
SELECT id, nombre, precio FROM planes ORDER BY precio;

-- 3. Recaudacion por tipo de plan
SELECT p.nombre, COUNT(i.id) AS total_alumnos, SUM(p.precio) AS recaudado FROM inscripciones i JOIN planes p ON p.id = i.plan_id WHERE i.estado = 'activo' GROUP BY p.id, p.nombre;