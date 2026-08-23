PRAGMA foreign_keys = ON;

-- Ejercicio 060: Biblioteca Sci-Fi
-- Datos de prueba.

INSERT INTO autores (nombre_autor, nacionalidad) VALUES
    ('Frank Herbert', 'Estadounidense'),
    ('Isaac Asimov', 'Estadounidense'),
    ('William Gibson', 'Estadounidense'),
    ('George Orwell', 'Britanico'),
    ('Ursula K. Le Guin', 'Estadounidense');

INSERT INTO libros (titulo, id_autor, genero) VALUES
    ('Dune', 1, 'space_opera'),
    ('Fundacion', 2, 'space_opera'),
    ('Neuromante', 3, 'cyberpunk'),
    ('1984', 4, 'distopia'),
    ('Los Desposeidos', 5, 'space_opera'),
    ('Yo, Robot', 2, 'hard_sci_fi'),
    ('Conde Cero', 3, 'cyberpunk');

INSERT INTO lectores (nombre_lector, email) VALUES
    ('Karla Rivas', 'karla.rivas@correo.com'),
    ('Bryan Solis', 'bryan.solis@correo.com'),
    ('Fernanda Lopez', 'fernanda.lopez@correo.com'),
    ('Jorge Cifuentes', 'jorge.cifuentes@correo.com'),
    ('Priscila Ajanel', 'priscila.ajanel@correo.com');

-- El prestamo 11 es un duplicado exacto por error de digitacion
-- (mismo libro, lector y fecha de prestamo que el prestamo 1): se
-- corrige en dml/operaciones.sql con una deteccion general de
-- duplicados, no solo borrando ese id especifico.
INSERT INTO prestamos (id_libro, id_lector, fecha_prestamo, fecha_devolucion_esperada, estado) VALUES
    (1, 1, '2026-08-01', '2026-08-15', 'devuelto'),
    (2, 2, '2026-08-02', '2026-08-16', 'prestado'),
    (1, 3, '2026-08-03', '2026-08-17', 'devuelto'),
    (4, 4, '2026-08-04', '2026-08-18', 'atrasado'),
    (3, 1, '2026-08-05', '2026-08-19', 'prestado'),
    (5, 5, '2026-08-06', '2026-08-20', 'devuelto'),
    (6, 2, '2026-08-07', '2026-08-21', 'prestado'),
    (2, 3, '2026-08-08', '2026-08-22', 'perdido'),
    (7, 4, '2026-08-09', '2026-08-23', 'prestado'),
    (2, 1, '2026-08-10', '2026-08-24', 'prestado'),
    (1, 1, '2026-08-01', '2026-08-15', 'devuelto');

-- Casos comentados que deben fallar (no ser recomendables), dejar
-- comentados. Cada uno demuestra uno de los tres errores que pidio
-- detectar el cliente:

-- 1) Registro repetido: nombre_autor ya existe, viola el UNIQUE.
-- INSERT INTO autores (nombre_autor, nacionalidad) VALUES ('Frank Herbert', 'Britanico');

-- 2) Relacion invalida: id_lector = 99 no existe, viola el FOREIGN KEY.
-- INSERT INTO prestamos (id_libro, id_lector, fecha_prestamo, fecha_devolucion_esperada) VALUES (2, 99, '2026-08-11', '2026-08-25');

-- 3) Valor fuera de rango: fecha_devolucion_esperada antes que fecha_prestamo, viola el CHECK.
-- INSERT INTO prestamos (id_libro, id_lector, fecha_prestamo, fecha_devolucion_esperada) VALUES (3, 2, '2026-08-20', '2026-08-10');
