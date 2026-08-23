.headers on
.mode column

-- Ejercicio 58: CHECK Nivel Aplicado
-- Consultas de validacion.

-- 1. Mostrar todos los datos principales.
SELECT * FROM inscripciones;

-- 2. Consulta con WHERE.
SELECT id_inscripcion, id_camper, id_ruta, calificacion_final
FROM inscripciones
WHERE estado = 'completada';

-- 3. Consulta con ORDER BY.
SELECT id_inscripcion, fecha_inscripcion, estado
FROM inscripciones
ORDER BY fecha_inscripcion;

-- 4. Reporte final del caso de negocio: cupo ocupado y disponible por
--    ruta (no cuenta las inscripciones 'cancelada' como cupo ocupado).
SELECT
    r.nombre_ruta,
    r.cupo_maximo,
    COUNT(CASE WHEN i.estado IN ('activa', 'completada') THEN 1 END) AS cupo_ocupado,
    r.cupo_maximo - COUNT(CASE WHEN i.estado IN ('activa', 'completada') THEN 1 END) AS cupo_disponible
FROM rutas r
LEFT JOIN inscripciones i ON i.id_ruta = r.id_ruta
GROUP BY r.id_ruta, r.nombre_ruta, r.cupo_maximo
ORDER BY r.nombre_ruta;

-- 5. Validacion especifica del tema CHECK:
--    a) toda calificacion_final registrada esta dentro del rango 0-100.
SELECT
    MIN(calificacion_final) AS calificacion_minima,
    MAX(calificacion_final) AS calificacion_maxima
FROM inscripciones
WHERE calificacion_final IS NOT NULL;

--    b) ninguna inscripcion tiene calificacion_final sin estar
--       'completada' (el CHECK a nivel de tabla lo impide).
SELECT COUNT(*) AS inscripciones_invalidas
FROM inscripciones
WHERE calificacion_final IS NOT NULL AND estado <> 'completada';
