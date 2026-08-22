.headers on
.mode column

-- Ejercicio 040: Laboratorio Quimico
-- 1. Reactivos disponibles
SELECT id, nombre, pureza_pct FROM reactivos;

-- 2. Ensayos con muestra y reactivo
SELECT e.id, m.codigo AS muestra, r.nombre AS reactivo, e.resultado FROM ensayos e JOIN muestras m ON m.id = e.muestra_id JOIN reactivos r ON r.id = e.reactivo_id;

-- 3. Cantidad de ensayos por muestra
SELECT m.codigo, COUNT(e.id) AS total_ensayos FROM muestras m LEFT JOIN ensayos e ON e.muestra_id = m.id GROUP BY m.id, m.codigo;