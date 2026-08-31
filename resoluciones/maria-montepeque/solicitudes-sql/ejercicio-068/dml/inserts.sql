PRAGMA foreign_keys = ON;

-- Ejercicio 068: Escuela de Dibujo
-- Datos base: 2 profesores, 3 cursos, 5 alumnos, 10 entregas,
-- 7 evaluaciones.

INSERT INTO profesores (nombre, especialidad) VALUES
    ('Prof. Ana Solares', 'Dibujo Realista'),
    ('Prof. Luis Marroquin', 'Ilustracion Digital');

INSERT INTO cursos (id_profesor, nombre, nivel) VALUES
    (1, 'Dibujo Basico', 'principiante'),
    (1, 'Retrato Avanzado', 'avanzado'),
    (2, 'Ilustracion Digital', 'intermedio');

INSERT INTO alumnos (nombre, email) VALUES
    ('Manuel Estrada', 'manuel.estrada@correo.com'),
    ('Alejandra Chinchilla', 'alejandra.chinchilla@correo.com'),
    ('Byron Xicay', 'byron.xicay@correo.com'),
    ('Cristina Barrios', 'cristina.barrios@correo.com'),
    ('Douglas Pineda', 'douglas.pineda@correo.com');

INSERT INTO entregas (id_alumno, id_curso, titulo_obra, fecha_entrega, estado) VALUES
    (1, 1, 'Bodegon a lapiz', '2026-08-01', 'evaluada'),
    (2, 3, 'Personaje fantasia', '2026-08-02', 'evaluada'),
    (3, 2, 'Retrato autorretrato', '2026-08-03', 'evaluada'),
    (4, 1, 'Estudio de manos', '2026-08-04', 'pendiente'),
    (5, 3, 'Escena urbana digital', '2026-08-05', 'evaluada'),
    (1, 1, 'Naturaleza muerta', '2026-08-06', 'rechazada'),
    (2, 3, 'Concepto de criatura', '2026-08-07', 'evaluada'),
    (3, 2, 'Retrato de perfil', '2026-08-08', 'pendiente'),
    (1, 2, 'Retrato de familiar', '2026-08-09', 'evaluada'),
    (5, 1, 'Estudio de sombras', '2026-08-10', 'evaluada');

-- evaluaciones: solo de entregas ya 'evaluada'.
INSERT INTO evaluaciones (id_entrega, nota, comentario) VALUES
    (1, 85, 'Buen manejo de sombras'),
    (2, 92, 'Excelente composicion'),
    (3, 78, 'Falta simetria facial'),
    (5, 88, 'Buena perspectiva'),
    (7, 95, 'Diseno de personaje sobresaliente'),
    (9, 90, 'Gran parecido y detalle'),
    (10, 70, 'Sombras poco definidas');

-- Caso que debe fallar (queda comentado): una segunda evaluacion para la
-- misma entrega viola UNIQUE (id_entrega) en evaluaciones.
-- INSERT INTO evaluaciones (id_entrega, nota, comentario) VALUES (1, 80, 'Segunda revision');
