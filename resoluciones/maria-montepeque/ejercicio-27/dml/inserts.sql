-- Ejercicio 27: Indices y Busquedas
-- Datos base: 5 categorias, 5 instructores, 5 cursos, 10 inscripciones

INSERT INTO categorias (nombre) VALUES
    ('Programacion'),
    ('Bases de Datos'),
    ('Diseno Grafico'),
    ('Marketing Digital'),
    ('Idiomas');

INSERT INTO instructores (nombre, correo) VALUES
    ('Ing. Sofia Ramirez', 'sofia.ramirez@campus.edu'),
    ('Ing. Pedro Morales', 'pedro.morales@campus.edu'),
    ('Lic. Laura Gomez', 'laura.gomez@campus.edu'),
    ('Lic. Carlos Vasquez', 'carlos.vasquez@campus.edu'),
    ('Prof. Marta Lopez', 'marta.lopez@campus.edu');

INSERT INTO cursos (id_categoria, id_instructor, nombre, precio, duracion_horas) VALUES
    (1, 1, 'Introduccion a Python', 350.00, 40),
    (2, 2, 'SQL desde Cero', 300.00, 30),
    (3, 3, 'Fundamentos de Diseno UX/UI', 400.00, 35),
    (4, 4, 'Marketing en Redes Sociales', 280.00, 25),
    (5, 5, 'Ingles para Negocios', 320.00, 45);

INSERT INTO inscripciones (id_curso, estudiante_nombre, estudiante_correo, fecha_inscripcion, estado) VALUES
    (1, 'Manuel Estrada', 'manuel.estrada@correo.com', '2026-07-01', 'completado'),
    (1, 'Alejandra Chinchilla', 'alejandra.chinchilla@correo.com', '2026-07-05', 'inscrito'),
    (2, 'Byron Xicay', 'byron.xicay@correo.com', '2026-07-02', 'completado'),
    (2, 'Cristina Barrios', 'cristina.barrios@correo.com', '2026-07-08', 'inscrito'),
    (3, 'Douglas Pineda', 'douglas.pineda@correo.com', '2026-07-03', 'completado'),
    (3, 'Manuel Estrada', 'manuel.estrada@correo.com', '2026-07-09', 'cancelado'),
    (4, 'Alejandra Chinchilla', 'alejandra.chinchilla@correo.com', '2026-07-04', 'inscrito'),
    (4, 'Byron Xicay', 'byron.xicay@correo.com', '2026-07-10', 'completado'),
    (5, 'Cristina Barrios', 'cristina.barrios@correo.com', '2026-07-05', 'inscrito'),
    (5, 'Douglas Pineda', 'douglas.pineda@correo.com', '2026-07-11', 'completado');
