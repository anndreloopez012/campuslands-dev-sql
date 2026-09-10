.headers on
.mode column

-- Ejercicio 98: Vistas Nivel Basico
-- Consultas de validacion.

-- 1. Mostrar todos los datos principales.
SELECT i.id_inscripcion, c.nombre_camper, i.nombre_ruta, i.fecha_inscripcion, i.estado
FROM inscripciones i
JOIN campers c ON c.id_camper = i.id_camper;

-- 2. Consulta con WHERE: solo las inscripciones activas (sin usar la vista).
SELECT id_inscripcion, id_camper, nombre_ruta, fecha_inscripcion
FROM inscripciones
WHERE estado = 'activo';

-- 3. Consulta con ORDER BY: inscripciones ordenadas por fecha.
SELECT id_inscripcion, nombre_ruta, estado, fecha_inscripcion
FROM inscripciones
ORDER BY fecha_inscripcion;

-- 4. Conteo o resumen: total de inscripciones por camper.
SELECT id_camper, COUNT(*) AS total_inscripciones
FROM inscripciones
GROUP BY id_camper;

-- 5. Validacion especifica de Vistas: usar vista_inscripciones_activas
-- (definida en ddl/schema.sql) en vez de repetir el JOIN + WHERE de
-- la consulta 2. La vista se consulta igual que una tabla, pero por
-- dentro siempre ejecuta la logica con la que se definio, asi que si
-- cambian los datos de base, el resultado de la vista cambia solo.
SELECT * FROM vista_inscripciones_activas;

-- Caso comentado que no es recomendable, dejar comentado: intentar
-- insertar directamente en la vista, como si fuera una tabla normal.
-- Se verifico con Python (sqlite3) que SQLite rechaza esta operacion
-- con el error "cannot modify vista_inscripciones_activas because it
-- is a view": una vista simple en SQLite es de solo lectura; para que
-- aceptara INSERT/UPDATE/DELETE haria falta definir un trigger
-- INSTEAD OF sobre ella, cosa que este ejercicio no requiere.
-- INSERT INTO vista_inscripciones_activas (id_inscripcion, nombre_camper, nombre_ruta, fecha_inscripcion)
-- VALUES (99, 'Camper Fantasma', 'Ruta Inventada', '2026-08-09');
