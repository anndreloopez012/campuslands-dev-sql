PRAGMA foreign_keys = ON;

-- Ejercicio 018: Escuela de Dibujo
-- Datos de prueba.

INSERT INTO cursos (nombre_curso, nivel, precio) VALUES
    ('Dibujo Basico', 'principiante', 150.00),
    ('Ilustracion Digital', 'intermedio', 250.00),
    ('Anime y Manga', 'intermedio', 220.00),
    ('Retrato Realista', 'avanzado', 300.00),
    ('Comic y Storyboard', 'avanzado', 280.00);

-- La entrega 9 es una entrada de prueba (alumno "Cuenta de Prueba") que
-- se cargo por error: se elimina en dml/operaciones.sql.
INSERT INTO entregas (id_curso, nombre_alumno, fecha_entrega, calificacion, estado) VALUES
    (1, 'Ana Gomez', '2026-07-01', 85, 'evaluada'),
    (2, 'Luis Marroquin', '2026-07-03', 90, 'evaluada'),
    (3, 'Karen Solis', '2026-07-05', NULL, 'pendiente'),
    (1, 'Diego Paz', '2026-07-08', 78, 'evaluada'),
    (4, 'Rosa Chavez', '2026-07-10', NULL, 'rechazada'),
    (5, 'Julio Perez', '2026-07-12', 95, 'evaluada'),
    (1, 'Ana Gomez', '2026-07-15', NULL, 'pendiente'),
    (2, 'Luis Marroquin', '2026-07-18', 88, 'evaluada'),
    (1, 'Cuenta de Prueba', '2026-07-01', NULL, 'pendiente');

-- Caso comentado que debe fallar (no ser recomendable), dejar comentado:
-- calificacion fuera del rango permitido por el CHECK de entregas.
-- INSERT INTO entregas (id_curso, nombre_alumno, calificacion, estado) VALUES (2, 'Tomas Blanco', 150, 'evaluada');
