.headers on
.mode column

-- Ejercicio 082: Academia Kickboxing
-- Consultas que responden preguntas reales del cliente.

-- 1. Que registros principales existen: se usa la vista
-- vista_pagos_alumnos (creada en ddl/schema.sql), que responde
-- directamente quien pago, que plan, cuando y cuanto.
SELECT *
FROM vista_pagos_alumnos;

-- 2. Que pagos estan pendientes, pagados o vencidos.
SELECT id_pago, id_alumno, estado
FROM pagos
ORDER BY estado;

-- 3. Que alumno tiene mas asistencias (ranking de actividad).
SELECT al.nombre_alumno, COUNT(*) AS total_asistencias
FROM alumnos al
JOIN asistencias a ON a.id_alumno = al.id_alumno
GROUP BY al.id_alumno, al.nombre_alumno
ORDER BY total_asistencias DESC, al.nombre_alumno;

-- 4. Pagos ordenados por fecha.
SELECT id_pago, fecha_pago, monto
FROM pagos
ORDER BY fecha_pago;

-- 5. Reporte para decision de negocio: ingresos totales por plan,
-- para decidir en cual invertir mas promocion (GROUP BY + HAVING,
-- usando la vista para no repetir el JOIN).
SELECT nombre_plan,
       SUM(monto) AS ingresos_totales
FROM vista_pagos_alumnos
WHERE estado = 'pagado'
GROUP BY nombre_plan
HAVING SUM(monto) > 0
ORDER BY ingresos_totales DESC;
