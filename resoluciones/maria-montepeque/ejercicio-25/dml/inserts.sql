-- Ejercicio 25: Reportes Biblioteca
-- Datos base: 5 sedes, 5 libros, 5 usuarios, 10 prestamos

INSERT INTO sedes (nombre, ciudad) VALUES
    ('Sede Central', 'Ciudad de Guatemala'),
    ('Sede Norte', 'Cobán'),
    ('Sede Occidente', 'Quetzaltenango'),
    ('Sede Sur', 'Escuintla'),
    ('Sede Campus', 'Ciudad de Guatemala');

INSERT INTO libros (id_sede, titulo, autor, isbn) VALUES
    (1, 'Cien Anos de Soledad', 'Gabriel Garcia Marquez', 'ISBN-6001'),
    (2, 'El Principito', 'Antoine de Saint-Exupery', 'ISBN-6002'),
    (3, 'Don Quijote de la Mancha', 'Miguel de Cervantes', 'ISBN-6003'),
    (4, 'Rayuela', 'Julio Cortazar', 'ISBN-6004'),
    (5, 'Clean Code', 'Robert C. Martin', 'ISBN-6005');

INSERT INTO usuarios (nombre, correo) VALUES
    ('Manuel Estrada', 'manuel.estrada@correo.com'),
    ('Alejandra Chinchilla', 'alejandra.chinchilla@correo.com'),
    ('Byron Xicay', 'byron.xicay@correo.com'),
    ('Cristina Barrios', 'cristina.barrios@correo.com'),
    ('Douglas Pineda', 'douglas.pineda@correo.com');

INSERT INTO prestamos (id_libro, id_usuario, fecha_prestamo, fecha_devolucion, estado) VALUES
    (1, 1, '2026-06-01', '2026-06-10', 'devuelto'),
    (1, 2, '2026-07-01', NULL, 'prestado'),
    (2, 3, '2026-06-02', '2026-06-15', 'devuelto'),
    (2, 4, '2026-07-02', NULL, 'atrasado'),
    (3, 5, '2026-06-03', '2026-06-12', 'devuelto'),
    (3, 1, '2026-07-03', NULL, 'prestado'),
    (4, 2, '2026-06-04', '2026-06-20', 'devuelto'),
    (4, 3, '2026-07-04', NULL, 'atrasado'),
    (5, 4, '2026-06-05', '2026-06-18', 'devuelto'),
    (5, 5, '2026-07-05', NULL, 'prestado');
