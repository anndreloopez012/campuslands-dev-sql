.headers on
.mode column

-- Ejercicio 032: Academia Kickboxing
-- Consultas de validacion.

-- 1. Que registros principales existen (con JOIN para mostrar el
--    nombre del alumno en vez de solo el id numerico).
SELECT
    p.id_pago,
    a.nombre_completo,
    p.monto_pagado,
    p.fecha_pago,
    p.metodo_pago,
    p.estado
FROM pagos p
JOIN alumnos a ON a.id_alumno = p.id_alumno;

-- 2. Que pagos no estan confirmados todavia.
SELECT id_pago, id_alumno, monto_pagado, estado
FROM pagos
WHERE estado <> 'confirmado';

-- 3. Que alumno tiene mas pagos registrados.
SELECT a.nombre_completo, COUNT(*) AS total_pagos
FROM alumnos a
JOIN pagos p ON p.id_alumno = a.id_alumno
GROUP BY a.id_alumno, a.nombre_completo
ORDER BY total_pagos DESC;

-- 4. Pagos ordenados por fecha.
SELECT a.nombre_completo, p.monto_pagado, p.fecha_pago
FROM pagos p
JOIN alumnos a ON a.id_alumno = p.id_alumno
ORDER BY p.fecha_pago;

-- 5. Cuanto recaudo la academia por plan (sin pagos rechazados), para
--    decisiones financieras. JOIN de las tres tablas.
SELECT
    pl.nombre_plan,
    SUM(p.monto_pagado) AS total_recaudado
FROM planes pl
JOIN alumnos a ON a.id_plan = pl.id_plan
JOIN pagos p ON p.id_alumno = a.id_alumno
WHERE p.estado <> 'rechazado'
GROUP BY pl.id_plan, pl.nombre_plan
ORDER BY total_recaudado DESC;
