.headers on
.mode column

-- Ejercicio 080: Cine Horror Nights
-- 1. Cartelera de funciones
SELECT f.id, p.titulo, s.nombre AS sala, f.horario, f.precio FROM funciones f JOIN peliculas p ON p.id = f.pelicula_id JOIN salas s ON s.id = f.sala_id;

-- 2. Peliculas de duracion mayor a 100 minutos
SELECT id, titulo, duracion_min FROM peliculas WHERE duracion_min > 100;

-- 3. Funciones por sala
SELECT s.nombre, COUNT(f.id) AS total_funciones FROM salas s LEFT JOIN funciones f ON f.sala_id = s.id GROUP BY s.id, s.nombre;