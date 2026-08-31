PRAGMA foreign_keys = ON;

-- Ejercicio 085: Biblioteca Sci-Fi
-- Datos base: 4 autores, 5 libros, 5 lectores, 6 prestamos (3 con
-- devolucion registrada, 2 activos, 1 que se corrige a atrasado) y
-- una devolucion cargada por error en el prestamo equivocado.

INSERT INTO autores (nombre_autor, nacionalidad) VALUES
    ('Frank Herbert', 'Estadounidense'),
    ('Isaac Asimov', 'Estadounidense'),
    ('William Gibson', 'Estadounidense'),
    ('George Orwell', 'Britanico');

INSERT INTO libros (titulo, id_autor, genero) VALUES
    ('Dune', 1, 'space_opera'),
    ('Fundacion', 2, 'space_opera'),
    ('Neuromante', 3, 'cyberpunk'),
    ('1984', 4, 'distopia'),
    ('Yo, Robot', 2, 'hard_sci_fi');

INSERT INTO lectores (nombre_lector, email) VALUES
    ('Karla Rivas', 'karla.rivas@correo.com'),
    ('Bryan Solis', 'bryan.solis@correo.com'),
    ('Fernanda Lopez', 'fernanda.lopez@correo.com'),
    ('Jorge Cifuentes', 'jorge.cifuentes@correo.com'),
    ('Priscila Ajanel', 'priscila.ajanel@correo.com');

INSERT INTO prestamos (id_libro, id_lector, fecha_prestamo, fecha_devolucion_esperada, estado) VALUES
    (1, 1, '2026-08-01', '2026-08-15', 'devuelto'),
    (2, 2, '2026-08-02', '2026-08-16', 'prestado'),
    (1, 3, '2026-08-03', '2026-08-17', 'devuelto'),
    (4, 4, '2026-08-04', '2026-08-18', 'prestado'),
    (3, 1, '2026-08-05', '2026-08-19', 'prestado'),
    (5, 5, '2026-08-06', '2026-08-20', 'devuelto');

-- Devoluciones reales de los prestamos 1, 3 y 6.
INSERT INTO devoluciones (id_prestamo, fecha_devolucion_real, estado_libro) VALUES
    (1, '2026-08-14', 'bueno'),
    (3, '2026-08-16', 'bueno'),
    (6, '2026-08-19', 'danado');

-- Devolucion cargada por error: el bibliotecario registro por
-- accidente la devolucion del prestamo 2 (Bryan Solis, Fundacion),
-- que en realidad sigue prestado. Se corrige con DELETE en
-- dml/operaciones.sql.
INSERT INTO devoluciones (id_prestamo, fecha_devolucion_real, estado_libro) VALUES
    (2, '2026-08-10', 'bueno');

-- Caso comentado que debe fallar (queda comentado): registrar una
-- segunda devolucion para el prestamo 1, exactamente el problema que
-- este UNIQUE esta disenado para evitar.
-- INSERT INTO devoluciones (id_prestamo, fecha_devolucion_real, estado_libro) VALUES (1, '2026-08-15', 'bueno');
