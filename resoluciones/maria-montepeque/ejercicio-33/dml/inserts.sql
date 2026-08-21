-- Ejercicio 33: Normalizacion Matriculas Academicas
-- Datos normalizados equivalentes a datos/datos-sin-normalizar.csv
-- (estudiantes 1-2, rutas 1-2, trainers 1-2 y las matriculas 1-2 con sus notas
--  vienen del CSV original; el resto se agrega para cumplir el minimo de datos
--  del ejercicio)
--
-- Nota sobre el CSV original: las filas id_matricula=1 e id_matricula=3
-- correspondian a la MISMA estudiante (Laura Cano), la MISMA ruta (Node JS) y
-- el MISMO trainer (Mario Paz); el archivo plano las repetia como si fueran
-- matriculas distintas solo porque no le alcanzaba una fila para todos sus
-- modulos. En el modelo normalizado esas dos filas se unen en una sola
-- matricula (id_matricula=1) con sus 5 modulos en la tabla notas.

INSERT INTO estudiantes (nombre, documento) VALUES
    ('Laura Cano', 'DPI-100'),
    ('Kevin Rios', 'DPI-101'),
    ('Marta Lopez', 'DPI-102'),
    ('Andres Gil', 'DPI-103'),
    ('Sofia Reyes', 'DPI-104');

INSERT INTO rutas (nombre) VALUES
    ('Node JS'),
    ('Python'),
    ('React'),
    ('Java'),
    ('DevOps');

INSERT INTO trainers (nombre) VALUES
    ('Mario Paz'),
    ('Ana Solis'),
    ('Carla Nunez'),
    ('Diego Marroquin'),
    ('Elena Cruz');

INSERT INTO modulos (nombre) VALUES
    ('SQL'),
    ('Express'),
    ('JWT'),
    ('FastAPI'),
    ('Docker'),
    ('Deploy');

INSERT INTO matriculas (id_estudiante, id_ruta, id_trainer) VALUES
    (1, 1, 1),   -- matricula 1 del CSV: Laura Cano, Node JS, Mario Paz (fusiona filas 1 y 3)
    (2, 2, 2),   -- matricula 2 del CSV: Kevin Rios, Python, Ana Solis
    (3, 3, 3),   -- matricula adicional: Marta Lopez, React, Carla Nunez
    (4, 4, 4),   -- matricula adicional: Andres Gil, Java, Diego Marroquin
    (5, 5, 5),   -- matricula adicional: Sofia Reyes, DevOps, Elena Cruz
    (2, 1, 1);   -- matricula adicional: Kevin Rios tambien cursa Node JS con Mario Paz

INSERT INTO notas (id_matricula, id_modulo, horario, nota) VALUES
    -- matricula 1 (CSV filas 1 y 3): SQL|Express|JWT (08:00|10:00|12:00, 88|91|85)
    -- + Docker|Deploy (15:00|17:00, 92|89)
    (1, 1, '08:00', 88),
    (1, 2, '10:00', 91),
    (1, 3, '12:00', 85),
    (1, 5, '15:00', 92),
    (1, 6, '17:00', 89),
    -- matricula 2 (CSV fila 2): SQL|FastAPI (14:00|16:00, 90|87)
    (2, 1, '14:00', 90),
    (2, 4, '16:00', 87),
    -- matriculas adicionales para completar el minimo de 10 lineas de detalle
    (3, 3, '09:00', 80),
    (3, 2, '11:00', 84),
    (4, 1, '08:30', 75),
    (4, 5, '10:30', 78),
    (5, 5, '09:00', 95),
    (5, 6, '11:00', 93),
    (6, 3, '13:00', 70);

-- 2 casos comentados que deben fallar por restricciones
-- Falla por UNIQUE (estudiantes.documento): el documento ya existe
-- INSERT INTO estudiantes (nombre, documento) VALUES ('Duplicado', 'DPI-100');

-- Falla por CHECK (nota BETWEEN 0 AND 100)
-- INSERT INTO notas (id_matricula, id_modulo, horario, nota) VALUES (2, 6, '09:00', 150);
