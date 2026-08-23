.headers on
.mode column

-- Ejercicio 44: PRIMARY KEY Nivel Basico
-- Consultas de validacion.

-- 1. Mostrar todos los datos principales.
SELECT * FROM campers;

-- 2. Consulta con WHERE.
SELECT nombre, documento
FROM campers
WHERE documento LIKE 'DPI-900%';

-- 3. Consulta con ORDER BY.
SELECT nombre, documento
FROM campers
ORDER BY nombre;

-- 4. Conteo o resumen.
SELECT COUNT(*) AS total_campers FROM campers;

-- 5. Validacion especifica del tema PRIMARY KEY:
--    a) la PRIMARY KEY compuesta (id_camper, id_ruta) permite que un camper
--       aparezca varias veces en inscripciones (una fila por ruta distinta),
--       pero nunca repetido con la misma ruta. Aqui se ve a Manuel Estrada
--       (id_camper = 1) con dos filas, una por cada ruta.
SELECT id_camper, id_ruta, fecha_inscripcion
FROM inscripciones
WHERE id_camper = 1;

--    b) contar inscripciones por camper demuestra que cada PRIMARY KEY
--       (id_camper, id_ruta) es unica: la suma de filas por camper nunca
--       tiene una ruta repetida.
SELECT c.nombre AS camper, COUNT(*) AS rutas_inscritas
FROM inscripciones i
JOIN campers c ON c.id_camper = i.id_camper
GROUP BY c.nombre
ORDER BY rutas_inscritas DESC;
