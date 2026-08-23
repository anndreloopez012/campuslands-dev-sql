-- Ejercicio 30: Proyecto Integrador SQL
-- Datos base: 5 rutas, 5 trainers, 5 campers, 5 modulos, 10 evaluaciones, 10 asistencias

INSERT INTO rutas (nombre, duracion_semanas) VALUES
    ('Desarrollo Web', 20),
    ('Ciencia de Datos', 24),
    ('Infraestructura Cloud', 18),
    ('Diseno UX/UI', 16),
    ('Ciberseguridad', 22);

INSERT INTO trainers (nombre, correo) VALUES
    ('Ing. Sofia Ramirez', 'sofia.ramirez@campus.edu'),
    ('Ing. Pedro Morales', 'pedro.morales@campus.edu'),
    ('Ing. Laura Gomez', 'laura.gomez@campus.edu'),
    ('Ing. Carlos Vasquez', 'carlos.vasquez@campus.edu'),
    ('Ing. Marta Lopez', 'marta.lopez@campus.edu');

INSERT INTO campers (id_ruta, nombre, correo, fecha_ingreso) VALUES
    (1, 'Manuel Estrada', 'manuel.estrada@correo.com', '2026-01-15'),
    (2, 'Alejandra Chinchilla', 'alejandra.chinchilla@correo.com', '2026-01-15'),
    (1, 'Byron Xicay', 'byron.xicay@correo.com', '2026-01-15'),
    (3, 'Cristina Barrios', 'cristina.barrios@correo.com', '2026-02-01'),
    (4, 'Douglas Pineda', 'douglas.pineda@correo.com', '2026-02-01');

INSERT INTO modulos (id_ruta, id_trainer, nombre, horas) VALUES
    (1, 1, 'Fundamentos de SQL', 40),
    (1, 2, 'JavaScript Avanzado', 60),
    (2, 3, 'Analisis Exploratorio de Datos', 50),
    (3, 4, 'Contenedores y Orquestacion', 45),
    (4, 5, 'Prototipado de Interfaces', 35);

INSERT INTO evaluaciones (id_camper, id_modulo, nota, fecha) VALUES
    (1, 1, 92.0, '2026-02-10'),
    (1, 2, 85.5, '2026-03-05'),
    (2, 3, 78.0, '2026-02-20'),
    (3, 1, 88.0, '2026-02-10'),
    (3, 2, 74.5, '2026-03-05'),
    (4, 4, 90.0, '2026-03-01'),
    (5, 5, 81.0, '2026-03-02'),
    (2, 3, 95.0, '2026-03-15'),
    (4, 4, 87.0, '2026-03-18'),
    (5, 5, 79.0, '2026-03-20');

INSERT INTO asistencias (id_camper, id_modulo, fecha, estado) VALUES
    (1, 1, '2026-02-05', 'presente'),
    (1, 2, '2026-03-01', 'presente'),
    (2, 3, '2026-02-15', 'tardanza'),
    (3, 1, '2026-02-05', 'presente'),
    (3, 2, '2026-03-01', 'ausente'),
    (4, 4, '2026-02-25', 'presente'),
    (5, 5, '2026-02-28', 'presente'),
    (2, 3, '2026-03-10', 'presente'),
    (4, 4, '2026-03-15', 'tardanza'),
    (5, 5, '2026-03-18', 'presente');
