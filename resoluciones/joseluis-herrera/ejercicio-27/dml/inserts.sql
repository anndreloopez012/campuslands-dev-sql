INSERT INTO categorias (id_categoria, nombre, descripcion) VALUES
(1, 'Desarrollo Web', 'Cursos enfocados en desarrollo de aplicaciones web.'),
(2, 'Bases de Datos', 'Cursos relacionados con diseño y gestion de bases de datos.'),
(3, 'Programacion', 'Cursos de fundamentos y lenguajes de programacion.'),
(4, 'Ciencia de Datos', 'Cursos orientados al analisis y procesamiento de datos.'),
(5, 'DevOps', 'Cursos sobre automatizacion, despliegue e infraestructura.');

INSERT INTO instructores (id_instructor, nombre_completo, email, especialidad) VALUES
(1, 'Carlos Mendoza', 'carlos.mendoza@campuslands.com', 'Desarrollo Web'),
(2, 'Laura Ramirez', 'laura.ramirez@campuslands.com', 'Bases de Datos'),
(3, 'Andres Castillo', 'andres.castillo@campuslands.com', 'Programacion'),
(4, 'Sofia Herrera', 'sofia.herrera@campuslands.com', 'Ciencia de Datos'),
(5, 'Miguel Torres', 'miguel.torres@campuslands.com', 'DevOps');

INSERT INTO cursos (
    id_curso,
    id_categoria,
    id_instructor,
    nombre,
    descripcion,
    precio,
    fecha_inicio,
    cupo_maximo
) VALUES
(1, 1, 1, 'HTML y CSS Profesional', 'Fundamentos para construir interfaces web modernas.', 180.00, '2026-09-01', 25),
(2, 1, 1, 'JavaScript Moderno', 'Programacion web utilizando JavaScript moderno.', 260.00, '2026-09-05', 30),
(3, 2, 2, 'SQL desde Cero', 'Fundamentos de consultas y bases de datos relacionales.', 220.00, '2026-09-08', 25),
(4, 2, 2, 'SQLite Practico', 'Diseño e implementacion de bases de datos SQLite.', 200.00, '2026-09-12', 20),
(5, 3, 3, 'Python Fundamental', 'Fundamentos de programacion con Python.', 280.00, '2026-09-15', 30),
(6, 3, 3, 'Algoritmos y Estructuras', 'Resolucion de problemas mediante algoritmos.', 300.00, '2026-09-18', 25),
(7, 4, 4, 'Analisis de Datos', 'Analisis y visualizacion de datos para toma de decisiones.', 350.00, '2026-09-20', 20),
(8, 4, 4, 'Python para Datos', 'Procesamiento de datos utilizando Python.', 380.00, '2026-09-22', 25),
(9, 5, 5, 'Docker desde Cero', 'Introduccion a contenedores y aplicaciones Docker.', 320.00, '2026-09-25', 20),
(10, 5, 5, 'CI/CD Practico', 'Automatizacion de integracion y despliegue continuo.', 400.00, '2026-09-28', 15);

INSERT INTO inscripciones (
    id_inscripcion,
    id_curso,
    nombre_estudiante,
    email_estudiante,
    fecha_inscripcion,
    estado
) VALUES
(1, 1, 'Jose Perez', 'jose.perez@email.com', '2026-08-01', 'activa'),
(2, 1, 'Maria Lopez', 'maria.lopez@email.com', '2026-08-02', 'activa'),
(3, 2, 'Carlos Gomez', 'carlos.gomez@email.com', '2026-08-03', 'activa'),
(4, 2, 'Ana Martinez', 'ana.martinez@email.com', '2026-08-04', 'activa'),
(5, 3, 'Luis Ramirez', 'luis.ramirez@email.com', '2026-08-05', 'activa'),
(6, 3, 'Sofia Morales', 'sofia.morales@email.com', '2026-08-06', 'finalizada'),
(7, 4, 'Pedro Castillo', 'pedro.castillo@email.com', '2026-08-07', 'activa'),
(8, 5, 'Laura Torres', 'laura.torres@email.com', '2026-08-08', 'activa'),
(9, 7, 'Diego Herrera', 'diego.herrera@email.com', '2026-08-09', 'activa'),
(10, 10, 'Valentina Cruz', 'valentina.cruz@email.com', '2026-08-10', 'activa');