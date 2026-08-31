.headers on
.mode column

-- Ejercicio 96: JOIN Nivel Intermedio
-- Consultas de validacion.

-- 1. Mostrar todos los datos principales: INNER JOIN de las 3 tablas.
SELECT i.id_inscripcion, c.nombre_camper, r.nombre_ruta, i.fecha_inscripcion, i.estado
FROM inscripciones i
INNER JOIN campers c ON c.id_camper = i.id_camper
INNER JOIN rutas r ON r.id_ruta = i.id_ruta;

-- 2. Consulta con WHERE: solo las inscripciones activas.
SELECT id_inscripcion, id_camper, id_ruta, fecha_inscripcion
FROM inscripciones
WHERE estado = 'activo';

-- 3. Consulta con ORDER BY: inscripciones ordenadas por fecha.
SELECT id_inscripcion, id_camper, estado, fecha_inscripcion
FROM inscripciones
ORDER BY fecha_inscripcion;

-- 4. Conteo o resumen: total de inscripciones por camper.
SELECT id_camper, COUNT(*) AS total_inscripciones
FROM inscripciones
GROUP BY id_camper;

-- 5. Validacion especifica de JOIN: campers que todavia NO tienen
-- ninguna inscripcion (patron "anti-join" con LEFT JOIN). Se parte de
-- campers (tabla izquierda) con LEFT JOIN hacia inscripciones; los
-- campers sin ninguna inscripcion quedan con id_inscripcion en NULL,
-- y el WHERE se queda solo con esos (aqui SI es correcto filtrar por
-- NULL despues del LEFT JOIN, porque se busca justamente la ausencia
-- de coincidencia).
SELECT c.nombre_camper
FROM campers c
LEFT JOIN inscripciones i ON i.id_camper = c.id_camper
WHERE i.id_inscripcion IS NULL;

-- Caso comentado que no es recomendable, dejar comentado: usar LEFT
-- JOIN pero filtrar con WHERE sobre una columna de la tabla derecha
-- (i.estado = 'activo'), esperando ver TODOS los campers con su
-- estado activo o vacio si no tienen. Como WHERE se evalua despues
-- del JOIN y descarta las filas con NULL, esto elimina exactamente a
-- los campers sin inscripcion o solo con inscripciones retiradas, y
-- el LEFT JOIN termina comportandose igual que un INNER JOIN. Se
-- verifico con Python (sqlite3) que esta consulta devuelve solo 3
-- campers (Ana, Byron, Diego) en vez de los 6 esperados; la condicion
-- sobre la tabla derecha debe ir en el ON, no en el WHERE, para
-- conservar el efecto de LEFT JOIN.
-- SELECT c.nombre_camper, i.estado
-- FROM campers c
-- LEFT JOIN inscripciones i ON i.id_camper = c.id_camper
-- WHERE i.estado = 'activo';
