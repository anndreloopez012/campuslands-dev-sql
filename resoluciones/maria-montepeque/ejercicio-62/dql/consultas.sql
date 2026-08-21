.headers on
.mode column

-- Ejercicio 62: AUTO_INCREMENT Nivel Basico
-- Consultas de validacion.

-- 1. Mostrar todos los datos principales.
SELECT id_camper, nombre, email FROM campers;

-- 2. Consulta con WHERE.
SELECT id_camper, nombre, email
FROM campers
WHERE email LIKE '%@correo.com';

-- 3. Consulta con ORDER BY.
SELECT id_camper, nombre
FROM campers
ORDER BY nombre;

-- 4. Conteo o resumen.
SELECT COUNT(*) AS total_campers FROM campers;

-- 5. Validacion especifica del tema AUTO_INCREMENT: el id 3 (camper
-- eliminado) nunca vuelve a aparecer, y el ultimo camper insertado
-- recibio un id nuevo (6), no el que quedo libre.
SELECT id_camper, nombre
FROM campers
ORDER BY id_camper;

SELECT id_camper, nombre
FROM campers
WHERE id_camper = 3;
-- Debe devolver 0 filas: el id 3 quedo libre pero AUTOINCREMENT no lo reutilizo.
