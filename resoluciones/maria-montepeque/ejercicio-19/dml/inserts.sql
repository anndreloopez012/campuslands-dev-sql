-- Ejercicio 19: Universidad Notas
-- Datos base: 5 estudiantes, 5 materias, 5 profesores, 10 notas

INSERT INTO estudiantes (nombre, carnet, correo) VALUES
    ('Manuel Estrada', 'CARN-3001', 'manuel.estrada@correo.com'),
    ('Alejandra Chinchilla', 'CARN-3002', 'alejandra.chinchilla@correo.com'),
    ('Byron Xicay', 'CARN-3003', 'byron.xicay@correo.com'),
    ('Cristina Barrios', 'CARN-3004', 'cristina.barrios@correo.com'),
    ('Douglas Pineda', 'CARN-3005', 'douglas.pineda@correo.com');

INSERT INTO materias (nombre, creditos) VALUES
    ('Bases de Datos', 4),
    ('Programacion I', 5),
    ('Redes', 3),
    ('Matematica Discreta', 4),
    ('Ingenieria de Software', 4);

INSERT INTO profesores (nombre, correo) VALUES
    ('Ing. Sofia Ramirez', 'sofia.ramirez@campus.edu'),
    ('Ing. Pedro Morales', 'pedro.morales@campus.edu'),
    ('Ing. Laura Gomez', 'laura.gomez@campus.edu'),
    ('Ing. Carlos Vasquez', 'carlos.vasquez@campus.edu'),
    ('Ing. Marta Lopez', 'marta.lopez@campus.edu');

INSERT INTO notas (id_estudiante, id_materia, id_profesor, nota, fecha) VALUES
    (1, 1, 1, 85.0, '2026-06-01'),
    (1, 2, 2, 78.5, '2026-06-02'),
    (2, 1, 1, 92.0, '2026-06-01'),
    (2, 3, 3, 88.0, '2026-06-03'),
    (3, 2, 2, 65.0, '2026-06-02'),
    (3, 4, 4, 74.5, '2026-06-04'),
    (4, 1, 1, 96.0, '2026-06-01'),
    (4, 5, 5, 81.0, '2026-06-05'),
    (5, 3, 3, 70.0, '2026-06-03'),
    (5, 4, 4, 90.0, '2026-06-04');
