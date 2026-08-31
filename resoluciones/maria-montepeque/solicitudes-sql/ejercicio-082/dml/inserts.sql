PRAGMA foreign_keys = ON;

-- Ejercicio 082: Academia Kickboxing
-- Datos base: 4 alumnos, 3 planes, 2 entrenadores, 7 asistencias
-- (incluye 1 cargada por error para un alumno que en realidad no
-- fue) y 4 pagos.

INSERT INTO alumnos (nombre_alumno, telefono) VALUES
    ('Manuel Estrada', '5555-8001'),
    ('Alejandra Chinchilla', '5555-8002'),
    ('Byron Xicay', '5555-8003'),
    ('Cristina Barrios', '5555-8004');

INSERT INTO planes (nombre_plan, precio_mensual, clases_por_semana) VALUES
    ('Plan Basico', 250.00, 2),
    ('Plan Intermedio', 400.00, 4),
    ('Plan Premium', 600.00, 6);

INSERT INTO entrenadores (nombre_entrenador, especialidad) VALUES
    ('Coach Hugo Marroquin', 'Kickboxing basico'),
    ('Coach Esteban Cifuentes', 'Kickboxing avanzado');

INSERT INTO asistencias (id_alumno, id_entrenador, fecha_clase) VALUES
    (1, 1, '2026-08-01'),
    (1, 1, '2026-08-03'),
    (2, 2, '2026-08-01'),
    (2, 2, '2026-08-04'),
    (3, 1, '2026-08-02'),
    (4, 2, '2026-08-02');

-- Asistencia cargada por error: el entrenador marco a Byron Xicay en
-- una clase a la que en realidad no asistio. Se corrige con DELETE en
-- dml/operaciones.sql.
INSERT INTO asistencias (id_alumno, id_entrenador, fecha_clase) VALUES
    (3, 1, '2026-08-05');

INSERT INTO pagos (id_alumno, id_plan, monto, estado) VALUES
    (1, 2, 400.00, 'pendiente'),
    (2, 1, 250.00, 'pagado'),
    (3, 3, 600.00, 'pendiente'),
    (4, 1, 250.00, 'pagado');

-- Caso comentado que debe fallar (queda comentado): registrar de
-- nuevo la asistencia de Manuel Estrada con el mismo entrenador el
-- mismo dia, exactamente el tipo de duplicado que este UNIQUE esta
-- disenado para evitar.
-- INSERT INTO asistencias (id_alumno, id_entrenador, fecha_clase) VALUES (1, 1, '2026-08-01');
