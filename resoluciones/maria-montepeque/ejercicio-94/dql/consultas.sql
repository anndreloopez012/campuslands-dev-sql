.headers on
.mode column

-- Ejercicio 94: HAVING Nivel Aplicado
-- Consultas de validacion.

-- 1. Mostrar todos los datos principales.
SELECT i.id_inscripcion, c.nombre_camper, r.nombre_ruta, i.fecha_inscripcion, i.estado
FROM inscripciones i
JOIN campers c ON c.id_camper = i.id_camper
JOIN rutas r ON r.id_ruta = i.id_ruta;

-- 2. Consulta con WHERE: solo las inscripciones activas.
SELECT id_inscripcion, id_camper, id_ruta, fecha_inscripcion
FROM inscripciones
WHERE estado = 'activo';

-- 3. Consulta con ORDER BY: inscripciones ordenadas por fecha.
SELECT id_inscripcion, id_ruta, estado, fecha_inscripcion
FROM inscripciones
ORDER BY fecha_inscripcion;

-- 4. Conteo o resumen: total de inscripciones por ruta, sin importar el estado (GROUP BY simple).
SELECT r.id_ruta, r.nombre_ruta, COUNT(*) AS total_inscripciones
FROM inscripciones i
JOIN rutas r ON r.id_ruta = i.id_ruta
GROUP BY r.id_ruta, r.nombre_ruta;

-- 5. Caso de negocio con HAVING: rutas en sobrecupo real, es decir,
-- rutas cuyo numero de inscripciones ACTIVAS supera su cupo_maximo.
-- Primero WHERE deja solo las inscripciones activas (filtro por
-- fila, antes de agrupar; los retirados y completados no ocupan
-- cupo), luego GROUP BY agrupa por ruta, y HAVING COUNT(*) >
-- r.cupo_maximo filtra los grupos resultantes quedandose solo con
-- las rutas realmente sobrecupadas. Esta es la validacion final que
-- el negocio necesita para decidir donde abrir mas cupo.
SELECT r.nombre_ruta, r.cupo_maximo, COUNT(*) AS inscritos_activos
FROM inscripciones i
JOIN rutas r ON r.id_ruta = i.id_ruta
WHERE i.estado = 'activo'
GROUP BY r.id_ruta, r.nombre_ruta, r.cupo_maximo
HAVING COUNT(*) > r.cupo_maximo;

-- Caso comentado que no es recomendable, dejar comentado: omitir el
-- WHERE estado = 'activo' y contar TODAS las inscripciones (incluyendo
-- retirados y completados) para decidir el sobrecupo. Esta consulta
-- no falla, pero da un reporte de negocio incorrecto: se verifico con
-- Python (sqlite3) que "Ruta Frontend Nivel 1" aparece como
-- sobrecupada (4 inscripciones totales > cupo 3) cuando en realidad
-- solo tiene 2 inscripciones activas y le sobra cupo, porque 2 de
-- esas 4 son un retiro y una inscripcion ya completada que no ocupan
-- un lugar activo. La version correcta es la de la consulta 5.
-- SELECT r.nombre_ruta, r.cupo_maximo, COUNT(*) AS total_inscripciones
-- FROM inscripciones i
-- JOIN rutas r ON r.id_ruta = i.id_ruta
-- GROUP BY r.id_ruta, r.nombre_ruta, r.cupo_maximo
-- HAVING COUNT(*) > r.cupo_maximo;
