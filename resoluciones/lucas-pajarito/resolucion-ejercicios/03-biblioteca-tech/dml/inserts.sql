PRAGMA foreign_keys = ON;

-- Ejercicio 03: Biblioteca Tech
-- Inserte aqui los datos base.
-- Debe incluir datos suficientes para probar todas las consultas.


-- ============================================
-- INSERCIÓN DE DATOS
-- Base de datos: Biblioteca Campus
-- Mínimo 10 registros por tabla
-- ============================================


-- ============================================
-- 1. AUTORES
-- ============================================

INSERT INTO autores (autor) VALUES
('Gabriel Garcia Marquez'),
('Mario Vargas Llosa'),
('Isabel Allende'),
('Julio Cortazar'),
('Jorge Luis Borges'),
('Pablo Neruda'),
('Laura Esquivel'),
('Carlos Fuentes'),
('Miguel de Cervantes'),
('Jane Austen');


-- ============================================
-- 2. EDITORIALES
-- ============================================

INSERT INTO editorial (editorial) VALUES
('Editorial Planeta'),
('Penguin Random House'),
('Alfaguara'),
('Editorial Sudamericana'),
('Fondo de Cultura Economica'),
('Anagrama'),
('Seix Barral'),
('Debolsillo'),
('Editorial Oceano'),
('HarperCollins');


-- ============================================
-- 3. LIBROS
-- ============================================

INSERT INTO libros
(titulo, id_autor, id_editorial, fecha_publicacion, cantidad) VALUES
('Cien anos de soledad', 1, 4, '1967-05-30', 15),
('La ciudad y los perros', 2, 1, '1963-10-01', 12),
('La casa de los espiritus', 3, 2, '1982-01-01', 10),
('Rayuela', 4, 3, '1963-06-28', 8),
('Ficciones', 5, 5, '1944-01-01', 14),
('Veinte poemas de amor', 6, 6, '1924-06-15', 20),
('Como agua para chocolate', 7, 7, '1989-09-01', 11),
('La muerte de Artemio Cruz', 8, 8, '1962-05-01', 9),
('Don Quijote de la Mancha', 9, 9, '1605-01-16', 18),
('Orgullo y prejuicio', 10, 10, '1813-01-28', 13);


-- ============================================
-- 4. SEDES CAMPUS
-- ============================================

INSERT INTO sedes_campus (departamento) VALUES
('Santander'),
('Norte de Santander'),
('Cundinamarca'),
('Antioquia'),
('Atlantico'),
('Valle del Cauca'),
('Bolivar'),
('Boyaca'),
('Meta'),
('Risaralda');


-- ============================================
-- 5. CAMPERS
-- ============================================

INSERT INTO campers
(nombre, apellido, email, telefono, id_sede) VALUES
('Carlos', 'Gomez', 'carlos.gomez@campus.edu', '3001000001', 1),
('Ana', 'Torres', 'ana.torres@campus.edu', '3001000002', 2),
('Luis', 'Martinez', 'luis.martinez@campus.edu', '3001000003', 3),
('Maria', 'Lopez', 'maria.lopez@campus.edu', '3001000004', 4),
('Pedro', 'Ramirez', 'pedro.ramirez@campus.edu', '3001000005', 5),
('Sofia', 'Castillo', 'sofia.castillo@campus.edu', '3001000006', 6),
('David', 'Morales', 'david.morales@campus.edu', '3001000007', 7),
('Laura', 'Hernandez', 'laura.hernandez@campus.edu', '3001000008', 8),
('Fernando', 'Perez', 'fernando.perez@campus.edu', '3001000009', 9),
('Elena', 'Vargas', 'elena.vargas@campus.edu', '3001000010', 10);


-- ============================================
-- 6. PRESTAMOS
-- ============================================

INSERT INTO prestamos
(id_camper, id_libro, fecha_prestamo, punto_de_vista) VALUES
(1, 1, '2026-08-01 08:30:00', 'Prestamo para actividad de lectura y analisis literario.'),
(2, 2, '2026-08-02 09:15:00', 'Libro solicitado para proyecto academico.'),
(3, 3, '2026-08-03 10:00:00', 'Prestamo para investigacion sobre literatura latinoamericana.'),
(4, 4, '2026-08-04 11:20:00', 'Material utilizado para trabajo de literatura.'),
(5, 5, '2026-08-05 13:00:00', 'Lectura complementaria para el modulo academico.'),
(6, 6, '2026-08-06 14:10:00', 'Prestamo para actividad de poesia.'),
(7, 7, '2026-08-07 15:30:00', 'Libro requerido para proyecto de lectura.'),
(8, 8, '2026-08-08 08:45:00', 'Material para investigacion y exposicion.'),
(9, 9, '2026-08-09 10:30:00', 'Prestamo para estudio de literatura clasica.'),
(10, 10, '2026-08-10 12:15:00', 'Lectura asignada para actividad academica.');