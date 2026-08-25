.headers on
.mode column

-- Ejercicio 80: SELECT Nivel Basico
-- Consultas de validacion.

-- 1. Mostrar todos los datos principales, con alias de columnas
-- (AS) y una expresion calculada (edad aproximada a partir de la
-- fecha de nacimiento).
SELECT nombre AS camper,
       nivel AS nivel_experiencia,
       CAST((julianday('now') - julianday(fecha_nacimiento)) / 365.25 AS INTEGER) AS edad_aproximada
FROM campers;

-- 2. Consulta con WHERE: solo los campers de nivel avanzado.
SELECT nombre, nivel
FROM campers
WHERE nivel = 'avanzado';

-- 3. Consulta con ORDER BY: rutas ordenadas por costo de
-- inscripcion, de mas barata a mas cara.
SELECT nombre_ruta, costo_inscripcion
FROM rutas
ORDER BY costo_inscripcion;

-- 4. Conteo o resumen: total de campers por nivel.
SELECT nivel, COUNT(*) AS total
FROM campers
GROUP BY nivel;

-- 5. Validacion especifica de SELECT: un reporte legible que combina
-- columnas de dos tablas (JOIN), alias descriptivos y una expresion
-- calculada (costo con 10% de descuento por inscripcion anticipada),
-- demostrando que SELECT no solo trae datos, tambien los presenta
-- listos para leer.
SELECT c.nombre AS camper,
       r.nombre_ruta AS ruta,
       r.costo_inscripcion AS costo_normal,
       ROUND(r.costo_inscripcion * 0.9, 2) AS costo_con_descuento
FROM inscripciones i
JOIN campers c ON c.id_camper = i.id_camper
JOIN rutas r ON r.id_ruta = i.id_ruta
ORDER BY camper;

-- Caso comentado que debe fallar (no ser recomendable), dejar
-- comentado: seleccionar una columna que no existe en la tabla
-- (typo), en vez de verificar el nombre real de la columna primero.
-- SELECT nombre, apellido FROM campers;
