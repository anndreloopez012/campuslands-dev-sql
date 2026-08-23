-- Ejercicio 25: Reportes Biblioteca
-- Entidad central: prestamos

-- 1. Listar todos los registros principales de la entidad central
SELECT * FROM prestamos;

-- 2. Mostrar solo dos columnas relevantes
SELECT estado, fecha_prestamo FROM prestamos;

-- 3. Filtrar registros por una condicion de fecha
SELECT * FROM prestamos WHERE fecha_prestamo >= '2026-07-01';

-- 4. Ordenar resultados por fecha de prestamo
SELECT * FROM prestamos ORDER BY fecha_prestamo;

-- 5. Mostrar los 5 prestamos mas recientes
SELECT * FROM prestamos ORDER BY fecha_prestamo DESC LIMIT 5;

-- 6. Contar registros totales
SELECT COUNT(*) AS total_prestamos FROM prestamos;

-- 7. Contar prestamos por estado (frecuencia de cada estado)
SELECT estado, COUNT(*) AS cantidad
FROM prestamos
GROUP BY estado;

-- 8. Agrupar prestamos por libro
SELECT id_libro, COUNT(*) AS cantidad_prestamos
FROM prestamos
GROUP BY id_libro;

-- 9. Relacionar prestamos, libros y usuarios con JOIN
SELECT p.id_prestamo, u.nombre AS usuario, l.titulo AS libro
FROM prestamos p
JOIN libros l ON l.id_libro = p.id_libro
JOIN usuarios u ON u.id_usuario = p.id_usuario;

-- 10. WHERE + ORDER BY + LIMIT
SELECT * FROM prestamos
WHERE estado = 'atrasado'
ORDER BY fecha_prestamo DESC
LIMIT 3;

-- 11. Reporte con alias legibles
SELECT
    u.nombre AS usuario,
    l.titulo AS libro,
    s.nombre AS sede,
    p.fecha_prestamo AS fecha_prestamo,
    p.fecha_devolucion AS fecha_devolucion,
    p.estado AS estado_prestamo
FROM prestamos p
JOIN libros l ON l.id_libro = p.id_libro
JOIN usuarios u ON u.id_usuario = p.id_usuario
JOIN sedes s ON s.id_sede = l.id_sede;

-- 12. Consulta para decision de negocio: libro con mas prestamos atrasados (para revisar disponibilidad)
SELECT l.titulo, COUNT(*) AS total_atrasados
FROM prestamos p
JOIN libros l ON l.id_libro = p.id_libro
WHERE p.estado = 'atrasado'
GROUP BY l.titulo
ORDER BY total_atrasados DESC
LIMIT 1;
