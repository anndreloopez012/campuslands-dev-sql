-- Ejercicio 03: Biblioteca Tech
-- Entidad central: prestamos

-- 1. Listar todos los registros principales de la entidad central
SELECT * FROM prestamos;

-- 2. Mostrar solo dos columnas relevantes
SELECT fecha_prestamo, estado FROM prestamos;

-- 3. Filtrar registros por una condicion de fecha
SELECT * FROM prestamos WHERE fecha_prestamo >= '2026-07-10';

-- 4. Ordenar resultados por fecha
SELECT * FROM prestamos ORDER BY fecha_prestamo;

-- 5. Mostrar los 5 prestamos mas recientes
SELECT * FROM prestamos ORDER BY fecha_prestamo DESC LIMIT 5;

-- 6. Contar registros totales
SELECT COUNT(*) AS total_prestamos FROM prestamos;

-- 7. Contar prestamos por estado (usa MIN/MAX de fecha como referencia)
SELECT
    MIN(fecha_prestamo) AS primer_prestamo,
    MAX(fecha_prestamo) AS ultimo_prestamo,
    COUNT(*) AS total
FROM prestamos;

-- 8. Agrupar prestamos por estado
SELECT estado, COUNT(*) AS cantidad
FROM prestamos
GROUP BY estado;

-- 9. Relacionar prestamos, campers y libros con JOIN
SELECT p.id_prestamo, c.nombre AS camper, l.titulo AS libro
FROM prestamos p
JOIN campers c ON c.id_camper = p.id_camper
JOIN libros l ON l.id_libro = p.id_libro;

-- 10. WHERE + ORDER BY + LIMIT
SELECT * FROM prestamos
WHERE estado = 'atrasado'
ORDER BY fecha_prestamo
LIMIT 3;
