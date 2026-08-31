PRAGMA foreign_keys = ON;

-- Ejercicio 78: DELETE Nivel Intermedio
-- Datos de prueba y DELETE de validacion.

INSERT INTO campers (nombre, email) VALUES
    ('Karen Solis', 'karen.solis@campus.com'),
    ('Mario Ixtabalan', 'mario.ixtabalan@campus.com'),
    ('Ana Gomez', 'ana.gomez@campus.com'),
    ('Luis Marroquin', 'luis.marroquin@campus.com'),
    ('Rosa Chavez', 'rosa.chavez@campus.com'),
    ('Diego Paz', 'diego.paz@campus.com');

INSERT INTO rutas (nombre_ruta) VALUES
    ('Cumbre Extrema'),
    ('Sendero del Canon'),
    ('Ruta del Volcan');

INSERT INTO inscripciones (id_camper, id_ruta, estado) VALUES
    (1, 1, 'activa'),
    (2, 1, 'activa'),
    (2, 1, 'activa'),
    (3, 2, 'cancelada'),
    (4, 2, 'cancelada'),
    (5, 3, 'activa'),
    (6, 1, 'cancelada');

-- 1. DELETE de una sola fila: Mario Ixtabalan quedo inscrito dos
-- veces en Cumbre Extrema por error de digitacion. Se elimina la
-- copia duplicada (id_inscripcion = 3), con WHERE por id especifico.
DELETE FROM inscripciones
WHERE id_inscripcion = 3;

-- 2. DELETE multiple: se limpian de una sola vez todas las
-- inscripciones canceladas de cualquier ruta, con un solo DELETE y un
-- WHERE por estado (no un id a la vez).
DELETE FROM inscripciones
WHERE estado = 'cancelada';

-- 3. Baja logica (no DELETE): Cumbre Extrema se descontinua, pero
-- Karen Solis y Mario Ixtabalan todavia tienen inscripciones activas
-- ahi. En vez de intentar borrar la ruta, se marca como inactiva.
UPDATE rutas
SET activa = 0
WHERE id_ruta = 1;

-- Caso comentado que debe fallar (no ser recomendable), dejar
-- comentado: intentar el DELETE fisico de una ruta que todavia tiene
-- inscripciones activas asociadas. SQLite, con
-- PRAGMA foreign_keys = ON, no lo permite. Esto es justo lo que
-- justifica usar baja logica (UPDATE activa = 0) en vez de DELETE
-- para rutas.
-- DELETE FROM rutas WHERE id_ruta = 1;
