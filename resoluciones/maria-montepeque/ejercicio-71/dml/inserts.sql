PRAGMA foreign_keys = ON;

-- Ejercicio 71: INSERT Nivel Basico
-- Datos de prueba para validar el tema INSERT.

-- 1. INSERT de una sola fila: se registra un medico.
INSERT INTO medicos (nombre_medico, especialidad) VALUES
    ('Dra. Sofia Ramirez', 'Medicina General');

-- 2. INSERT multiple (varias filas en una sola sentencia): se
-- registran el resto de los medicos.
INSERT INTO medicos (nombre_medico, especialidad) VALUES
    ('Dr. Carlos Perez', 'Pediatria'),
    ('Dra. Marta Lopez', 'Traumatologia');

-- 3. INSERT multiple de pacientes, con todas las columnas explicitas.
INSERT INTO pacientes (nombre_paciente, telefono) VALUES
    ('Manuel Estrada', '5555-7001'),
    ('Alejandra Chinchilla', '5555-7002'),
    ('Byron Xicay', '5555-7003'),
    ('Cristina Barrios', '5555-7004');

-- 4. INSERT de citas con estado explicito (no depende de DEFAULT).
INSERT INTO citas (id_paciente, id_medico, fecha_cita, estado) VALUES
    (1, 1, '2026-08-01 09:00', 'atendida'),
    (2, 2, '2026-08-01 10:30', 'atendida');

-- 5. INSERT de citas SIN indicar estado: se omite a proposito para
-- que INSERT complete la columna con su DEFAULT ('programada'). Esto
-- demuestra que INSERT no exige escribir todas las columnas, solo las
-- que no tienen DEFAULT ni permiten NULL.
INSERT INTO citas (id_paciente, id_medico, fecha_cita) VALUES
    (3, 1, '2026-08-02 08:00'),
    (4, 3, '2026-08-03 11:00');

-- Casos comentados que deben fallar (no ser recomendables), dejar
-- comentados:

-- 1) Registro repetido: nombre_medico ya existe, viola el UNIQUE.
-- INSERT INTO medicos (nombre_medico, especialidad) VALUES ('Dra. Sofia Ramirez', 'Cardiologia');

-- 2) Relacion invalida: id_medico = 99 no existe, viola el FOREIGN KEY.
-- INSERT INTO citas (id_paciente, id_medico, fecha_cita) VALUES (1, 99, '2026-08-04 09:00');

-- 3) Valor fuera de rango: estado con un valor que no esta en la
-- lista permitida, viola el CHECK.
-- INSERT INTO citas (id_paciente, id_medico, fecha_cita, estado) VALUES (2, 2, '2026-08-04 10:00', 'reagendada');
