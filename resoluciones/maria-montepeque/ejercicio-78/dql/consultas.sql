.headers on
.mode column

-- Ejercicio 78: DELETE Nivel Intermedio
-- Consultas de validacion.

-- 1. Mostrar todos los datos principales (inscripciones con camper y
-- ruta).
SELECT i.id_inscripcion,
       c.nombre AS camper,
       r.nombre_ruta,
       i.estado
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

-- 4. Conteo o resumen: total de inscripciones por ruta.
SELECT id_ruta, COUNT(*) AS total_inscripciones
FROM inscripciones
GROUP BY id_ruta;

-- 5. Validacion especifica de DELETE: ya no queda ninguna
-- inscripcion 'cancelada' (se borraron todas de una vez), ni la copia
-- duplicada de Mario Ixtabalan. Solo quedan las 3 inscripciones
-- 'activa' originales.
SELECT COUNT(*) AS canceladas_restantes
FROM inscripciones
WHERE estado = 'cancelada';
-- Debe devolver 0: el DELETE multiple elimino todas las canceladas.

SELECT COUNT(*) AS total_restante
FROM inscripciones;
-- Debe devolver 3: empezaron 7, se borro 1 duplicado y 3 canceladas.
