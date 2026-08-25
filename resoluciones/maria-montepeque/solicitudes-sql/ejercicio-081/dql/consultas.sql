.headers on
.mode column

-- Ejercicio 081: Renta Autos de Lujo
-- Consultas que responden preguntas reales del cliente.

-- 1. Que registros principales existen: se usa la vista
-- vista_resumen_reservas (creada en ddl/schema.sql) en vez de repetir
-- el JOIN de 4 tablas.
SELECT *
FROM vista_resumen_reservas;

-- 2. Que reservas estan reservadas, en curso, finalizadas o
-- canceladas.
SELECT id_reserva, id_cliente, estado
FROM reservas
ORDER BY estado;

-- 3. Que cliente tiene mas reservas (ranking de actividad).
SELECT c.nombre_cliente, COUNT(*) AS total_reservas
FROM clientes c
JOIN reservas r ON r.id_cliente = c.id_cliente
GROUP BY c.id_cliente, c.nombre_cliente
ORDER BY total_reservas DESC, c.nombre_cliente;

-- 4. Reservas ordenadas por fecha de inicio.
SELECT id_reserva, fecha_inicio, fecha_fin, estado
FROM reservas
ORDER BY fecha_inicio;

-- 5. Reporte para decision de negocio: ingresos totales por
-- categoria de vehiculo, para decidir en cual invertir mas flota
-- (GROUP BY + HAVING, usando la vista para no repetir el JOIN).
SELECT categoria,
       SUM(monto_pagado) AS ingresos_totales
FROM vista_resumen_reservas
WHERE monto_pagado IS NOT NULL
GROUP BY categoria
HAVING SUM(monto_pagado) > 0
ORDER BY ingresos_totales DESC;
