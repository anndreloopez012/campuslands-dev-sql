.headers on
.mode column

-- Ejercicio 030: Cine Horror Nights
-- Consultas de validacion.

-- 1. Que registros principales existen (con JOIN para mostrar el
--    titulo y la sala en vez de solo los id numericos).
SELECT
    f.id_funcion,
    p.titulo,
    s.nombre_sala,
    f.fecha_hora,
    f.precio_boleto,
    f.estado
FROM funciones f
JOIN peliculas p ON p.id_pelicula = f.id_pelicula
JOIN salas s ON s.id_sala = f.id_sala;

-- 2. Que funciones no estan finalizadas todavia.
SELECT id_funcion, id_pelicula, id_sala, fecha_hora, estado
FROM funciones
WHERE estado <> 'finalizada';

-- 3. Que sala tiene mas funciones programadas.
SELECT s.nombre_sala, COUNT(*) AS total_funciones
FROM salas s
JOIN funciones f ON f.id_sala = s.id_sala
GROUP BY s.id_sala, s.nombre_sala
ORDER BY total_funciones DESC;

-- 4. Funciones ordenadas por fecha y hora.
SELECT p.titulo, s.nombre_sala, f.fecha_hora
FROM funciones f
JOIN peliculas p ON p.id_pelicula = f.id_pelicula
JOIN salas s ON s.id_sala = f.id_sala
ORDER BY f.fecha_hora;

-- 5. Ingreso potencial por sala (sin contar canceladas), para decidir
--    que sala usar mas.
SELECT
    s.nombre_sala,
    s.capacidad,
    SUM(f.precio_boleto) AS ingreso_potencial
FROM salas s
JOIN funciones f ON f.id_sala = s.id_sala
WHERE f.estado <> 'cancelada'
GROUP BY s.id_sala, s.nombre_sala, s.capacidad
ORDER BY ingreso_potencial DESC;
