PRAGMA foreign_keys = ON;

-- Ejercicio 007: Academia Kickboxing
-- Datos de prueba.

INSERT INTO planes (nombre_plan, precio_mensual, clases_por_semana) VALUES
    ('Plan Basico', 250.00, 2),
    ('Plan Intermedio', 350.00, 3),
    ('Plan Avanzado', 480.00, 5),
    ('Plan Elite Personalizado', 700.00, 5),
    ('Plan Kids', 180.00, 2);

-- El alumno 9 (Cuenta de Prueba) es una entrada de prueba que se cargo
-- por error: se elimina en dml/operaciones.sql. Es la UNICA fila que se
-- elimina; el resto de casos especiales (suspendido, inactivo, graduado)
-- se resuelven corrigiendo el estado, no borrando el registro.
INSERT INTO alumnos (id_plan, nombre_completo, fecha_inscripcion, estado) VALUES
    (1, 'Andres Lopez', '2026-06-01', 'activo'),
    (2, 'Marta Vega', '2026-06-05', 'activo'),
    (3, 'Carlos Ruiz', '2026-06-10', 'activo'),
    (1, 'Diana Cruz', '2026-06-15', 'suspendido'),
    (4, 'Pedro Gomez', '2026-07-01', 'activo'),
    (2, 'Laura Ortiz', '2026-07-05', 'inactivo'),
    (5, 'Sofia Reyes', '2026-07-10', 'activo'),
    (3, 'Mario Paz', '2026-05-01', 'graduado'),
    (1, 'Cuenta de Prueba', '2026-08-15', 'activo');

-- Caso comentado que debe fallar (no ser recomendable), dejar comentado:
-- clases_por_semana en cero, viola el CHECK de planes.
-- INSERT INTO planes (nombre_plan, precio_mensual, clases_por_semana) VALUES ('Plan Fantasma', 100.00, 0);
