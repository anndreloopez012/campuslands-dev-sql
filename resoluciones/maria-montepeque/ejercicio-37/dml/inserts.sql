-- Ejercicio 37: Normalizacion Biblioteca Multiautor
-- Datos normalizados equivalentes a datos/datos-sin-normalizar.csv
-- (autores 1-3, generos 1-4, libros 1-2, usuarios 1-3 y los prestamos 1-3
--  vienen del CSV original; el resto se agrega para cumplir el minimo de
--  datos del ejercicio)
--
-- Nota sobre el CSV original: "Bases de Datos I" aparece en las filas 1 y 3
-- con exactamente los mismos autores (A. Torres|M. Ruiz) y generos
-- (SQL|Academico) repetidos por completo. En el modelo normalizado esa
-- lista de autores/generos se registra UNA sola vez en las tablas puente;
-- cada fila del CSV se convierte solo en un prestamo nuevo.

INSERT INTO autores (nombre) VALUES
    ('A. Torres'),
    ('M. Ruiz'),
    ('L. Cano'),
    ('J. Ramirez'),
    ('S. Bran');

INSERT INTO generos (nombre) VALUES
    ('SQL'),
    ('Academico'),
    ('Programacion'),
    ('Backend'),
    ('Ficcion');

INSERT INTO libros (titulo) VALUES
    ('Bases de Datos I'),
    ('Python Practico'),
    ('Redes I'),
    ('Ingles Tecnico'),
    ('Historia Contemporanea');

INSERT INTO usuarios (nombre) VALUES
    ('Juan Perez'),
    ('Maria Lopez'),
    ('Ana Diaz'),
    ('Carlos Xoc'),
    ('Diana Mux');

-- Tabla puente libro_autor (un renglon por cada autor de cada libro, sin
-- repetirse aunque el libro se preste varias veces)
INSERT INTO libro_autor (id_libro, id_autor) VALUES
    (1, 1),   -- Bases de Datos I: A. Torres
    (1, 2),   -- Bases de Datos I: M. Ruiz
    (2, 3),   -- Python Practico: L. Cano
    (3, 4),   -- Redes I: J. Ramirez
    (4, 5),   -- Ingles Tecnico: S. Bran
    (5, 1);   -- Historia Contemporanea: A. Torres (mismo autor, otro libro)

-- Tabla puente libro_genero
INSERT INTO libro_genero (id_libro, id_genero) VALUES
    (1, 1),   -- Bases de Datos I: SQL
    (1, 2),   -- Bases de Datos I: Academico
    (2, 3),   -- Python Practico: Programacion
    (2, 4),   -- Python Practico: Backend
    (3, 2),   -- Redes I: Academico
    (4, 2),   -- Ingles Tecnico: Academico
    (5, 5);   -- Historia Contemporanea: Ficcion

INSERT INTO prestamos (id_libro, id_usuario, fecha_devolucion) VALUES
    (1, 1, '2026-06-12'),   -- prestamo 1 del CSV: Bases de Datos I, Juan Perez
    (2, 2, '2026-06-15'),   -- prestamo 2 del CSV: Python Practico, Maria Lopez
    (1, 3, '2026-06-20'),   -- prestamo 3 del CSV: Bases de Datos I, Ana Diaz
    (3, 4, '2026-06-21'),   -- prestamo adicional
    (4, 5, '2026-06-22'),
    (5, 1, '2026-06-23'),
    (2, 3, '2026-06-24'),
    (1, 4, '2026-06-25'),
    (3, 5, '2026-06-26'),
    (4, 2, '2026-06-27'),
    (5, 3, '2026-06-28');

-- 2 casos comentados que deben fallar por restricciones
-- Falla por UNIQUE (libros.titulo): el libro ya existe
-- INSERT INTO libros (titulo) VALUES ('Bases de Datos I');

-- Falla por CHECK (formato de fecha_devolucion)
-- INSERT INTO prestamos (id_libro, id_usuario, fecha_devolucion) VALUES (1, 1, '12-06-2026');
