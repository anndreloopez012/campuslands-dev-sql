PRAGMA foreign_keys = ON;

-- Ejercicio 58: CHECK Nivel Aplicado
-- Datos de prueba para validar el tema CHECK.

-- Casos validos: nivel dentro de la lista permitida.
INSERT INTO campers (nombre, email, nivel) VALUES
    ('Ana Gomez', 'ana.gomez@campus.com', 'principiante'),
    ('Luis Marroquin', 'luis.marroquin@campus.com', 'intermedio'),
    ('Karen Solis', 'karen.solis@campus.com', 'avanzado'),
    ('Diego Paz', 'diego.paz@campus.com', 'intermedio'),
    ('Rosa Chavez', 'rosa.chavez@campus.com', 'principiante');

-- Casos validos: dificultad dentro de la lista permitida y cupo_maximo > 0.
INSERT INTO rutas (nombre_ruta, dificultad, cupo_maximo) VALUES
    ('Sendero del Canon', 'baja', 3),
    ('Ruta del Volcan', 'media', 2),
    ('Cumbre Extrema', 'alta', 4);

-- Casos validos: estado dentro de la lista permitida, calificacion_final
-- entre 0 y 100 (solo en inscripciones 'completada'), y NULL en las que
-- todavia no terminan.
INSERT INTO inscripciones (id_camper, id_ruta, fecha_inscripcion, estado, calificacion_final) VALUES
    (1, 1, '2026-06-01 08:00', 'completada', 85),
    (2, 1, '2026-06-01 08:00', 'completada', 92),
    (3, 1, '2026-06-15 08:00', 'activa', NULL),
    (3, 2, '2026-06-05 08:00', 'completada', 78),
    (4, 2, '2026-06-05 08:00', 'activa', NULL),
    (5, 3, '2026-06-10 08:00', 'activa', NULL),
    (1, 3, '2026-06-10 08:00', 'cancelada', NULL);

-- Caso comentado que debe fallar (no ser recomendable), dejar comentado:
-- nivel fuera de la lista permitida por el CHECK de campers.
-- INSERT INTO campers (nombre, email, nivel) VALUES ('Mario Ixtabalan', 'mario.ixtabalan@campus.com', 'experto');

-- Otro caso comentado que debe fallar: cupo_maximo en cero o negativo,
-- viola el CHECK de rango numerico en rutas.
-- INSERT INTO rutas (nombre_ruta, dificultad, cupo_maximo) VALUES ('Ruta Fantasma', 'baja', 0);

-- Otro caso comentado que debe fallar: calificacion_final fuera del rango
-- 0-100, viola el CHECK de rango numerico en inscripciones.
-- INSERT INTO inscripciones (id_camper, id_ruta, fecha_inscripcion, estado, calificacion_final) VALUES (2, 2, '2026-06-20 08:00', 'completada', 150);

-- Otro caso comentado que debe fallar: calificacion_final asignada sin que
-- la inscripcion este 'completada', viola el CHECK a nivel de tabla (regla
-- de negocio entre columnas).
-- INSERT INTO inscripciones (id_camper, id_ruta, fecha_inscripcion, estado, calificacion_final) VALUES (4, 3, '2026-06-20 08:00', 'activa', 90);
