.headers on
.mode column

-- Ejercicio 055: Cine Horror Nights
-- Consultas de validacion.

-- 1. Que registros principales existen (con JOIN a pelicula y sala,
--    mas el conteo de boletos vendidos de cada funcion).
SELECT
    f.id_funcion,
    p.titulo,
    s.nombre_sala,
    f.fecha_hora,
    f.precio_boleto,
    f.estado,
    SUM(CASE WHEN b.estado <> 'reembolsado' THEN 1 ELSE 0 END) AS boletos_vendidos
FROM funciones f
JOIN peliculas p ON p.id_pelicula = f.id_pelicula
JOIN salas s ON s.id_sala = f.id_sala
LEFT JOIN boletos b ON b.id_funcion = f.id_funcion
GROUP BY f.id_funcion, p.titulo, s.nombre_sala, f.fecha_hora, f.precio_boleto, f.estado
ORDER BY f.id_funcion;

-- 2. Que funciones no estan finalizadas todavia.
SELECT id_funcion, id_pelicula, id_sala, fecha_hora, estado
FROM funciones
WHERE estado <> 'finalizada';

-- 3. Que pelicula tiene mas boletos vendidos en total.
SELECT p.titulo, SUM(CASE WHEN b.estado <> 'reembolsado' THEN 1 ELSE 0 END) AS boletos_vendidos
FROM peliculas p
JOIN funciones f ON f.id_pelicula = p.id_pelicula
JOIN boletos b ON b.id_funcion = f.id_funcion
GROUP BY p.id_pelicula, p.titulo
ORDER BY boletos_vendidos DESC, p.titulo;

-- 4. Funciones ordenadas por fecha y hora.
SELECT p.titulo, s.nombre_sala, f.fecha_hora
FROM funciones f
JOIN peliculas p ON p.id_pelicula = f.id_pelicula
JOIN salas s ON s.id_sala = f.id_sala
ORDER BY f.fecha_hora;

-- 5. Funciones programadas o en curso con menor porcentaje de
--    ocupacion, para decidir cuales necesitan mas promocion.
SELECT
    p.titulo,
    s.nombre_sala,
    f.fecha_hora,
    f.estado,
    SUM(CASE WHEN b.estado <> 'reembolsado' THEN 1 ELSE 0 END) AS boletos_vendidos,
    s.capacidad,
    ROUND(100.0 * SUM(CASE WHEN b.estado <> 'reembolsado' THEN 1 ELSE 0 END) / s.capacidad, 1) AS ocupacion_pct
FROM funciones f
JOIN peliculas p ON p.id_pelicula = f.id_pelicula
JOIN salas s ON s.id_sala = f.id_sala
LEFT JOIN boletos b ON b.id_funcion = f.id_funcion
WHERE f.estado IN ('programada', 'en_curso')
GROUP BY f.id_funcion, p.titulo, s.nombre_sala, f.fecha_hora, f.estado, s.capacidad
ORDER BY ocupacion_pct ASC;
