SELECT * FROM prestamos;

SELECT id_prestamo, estado
FROM prestamos;

SELECT id_prestamo, fecha_prestamo, estado
FROM prestamos
WHERE fecha_prestamo >= '2026-08-05';

SELECT id_prestamo, fecha_prestamo
FROM prestamos
ORDER BY fecha_prestamo DESC;

SELECT
l.titulo,
COUNT(p.id_prestamo) AS total_prestamos
FROM libros l
LEFT JOIN prestamos p ON l.id_libro=p.id_libro
GROUP BY l.id_libro,l.titulo
ORDER BY total_prestamos DESC
LIMIT 5;

SELECT COUNT(*) AS total_prestamos
FROM prestamos;

SELECT
AVG(stock) AS stock_promedio,
MIN(stock) AS stock_minimo,
MAX(stock) AS stock_maximo
FROM libros;

SELECT
estado,
COUNT(*) AS cantidad
FROM prestamos
GROUP BY estado;

SELECT
u.nombre AS usuario,
l.titulo AS libro,
s.nombre AS sede,
p.fecha_prestamo,
p.estado
FROM prestamos p
JOIN usuarios u ON p.id_usuario=u.id_usuario
JOIN libros l ON p.id_libro=l.id_libro
JOIN sedes s ON l.id_sede=s.id_sede;

SELECT
u.nombre,
l.titulo,
p.fecha_prestamo
FROM prestamos p
JOIN usuarios u ON p.id_usuario=u.id_usuario
JOIN libros l ON p.id_libro=l.id_libro
WHERE p.estado='ACTIVO'
ORDER BY p.fecha_prestamo DESC
LIMIT 5;

SELECT
s.nombre AS sede,
COUNT(l.id_libro) AS libros,
COUNT(p.id_prestamo) AS prestamos_realizados
FROM sedes s
LEFT JOIN libros l ON s.id_sede=l.id_sede
LEFT JOIN prestamos p ON l.id_libro=p.id_libro
GROUP BY s.id_sede,s.nombre
ORDER BY prestamos_realizados DESC;

SELECT
u.nombre AS usuario,
COUNT(p.id_prestamo) AS prestamos_totales,
SUM(CASE WHEN p.estado='ATRASADO' THEN 1 ELSE 0 END) AS atrasados,
CASE
WHEN SUM(CASE WHEN p.estado='ATRASADO' THEN 1 ELSE 0 END)>=2 THEN 'Restringir prestamos'
WHEN SUM(CASE WHEN p.estado='ATRASADO' THEN 1 ELSE 0 END)=1 THEN 'Enviar recordatorio'
ELSE 'Usuario al dia'
END AS decision
FROM usuarios u
LEFT JOIN prestamos p ON u.id_usuario=p.id_usuario
GROUP BY u.id_usuario,u.nombre
ORDER BY atrasados DESC, prestamos_totales DESC;