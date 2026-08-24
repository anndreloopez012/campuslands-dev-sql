.headers on
.mode column

-- Ejercicio 76: UPDATE Nivel Aplicado
-- Consultas de validacion.

-- 1. Mostrar todos los datos principales (inscripciones con camper y
-- ruta).
SELECT i.id_inscripcion,
       c.nombre AS camper,
       r.nombre_ruta,
       i.estado,
       i.fecha_inscripcion
FROM inscripciones i
JOIN campers c ON c.id_camper = i.id_camper
JOIN rutas r ON r.id_ruta = i.id_ruta;

-- 2. Consulta con WHERE: solo las inscripciones activas.
SELECT id_inscripcion, id_camper, id_ruta
FROM inscripciones
WHERE estado = 'activa';

-- 3. Consulta con ORDER BY: inscripciones ordenadas por fecha.
SELECT id_inscripcion, fecha_inscripcion, estado
FROM inscripciones
ORDER BY fecha_inscripcion;

-- 4. Conteo o resumen: total de inscripciones por estado.
SELECT estado, COUNT(*) AS total
FROM inscripciones
GROUP BY estado;

-- 5. Caso de negocio con reporte final (nivel aplicado): se compara
-- el cupo_disponible que quedo despues de todos los UPDATE contra el
-- cupo que deberia haber, calculado desde cero solo con
-- cupo_maximo y el conteo de inscripciones activas. Si coinciden,
-- los UPDATE de cupo cumplieron su proposito.
SELECT r.nombre_ruta,
       r.cupo_maximo,
       r.cupo_disponible AS cupo_guardado,
       r.cupo_maximo - (
           SELECT COUNT(*)
           FROM inscripciones i
           WHERE i.id_ruta = r.id_ruta AND i.estado = 'activa'
       ) AS cupo_calculado
FROM rutas r
ORDER BY r.nombre_ruta;
