PRAGMA foreign_keys = ON;

-- PACIENTES

INSERT INTO pacientes (
    id_paciente,
    nombre_completo,
    documento,
    fecha_nacimiento,
    telefono,
    correo
) VALUES
(1, 'Ana Martinez Lopez', 'DOC-1001', '1990-03-15', '5551-1001', 'ana.martinez@email.com'),
(2, 'Carlos Ramirez Gomez', 'DOC-1002', '1985-07-22', '5551-1002', 'carlos.ramirez@email.com'),
(3, 'Laura Hernandez Perez', 'DOC-1003', '1998-11-09', '5551-1003', 'laura.hernandez@email.com'),
(4, 'Miguel Torres Castillo', 'DOC-1004', '1979-05-30', '5551-1004', 'miguel.torres@email.com'),
(5, 'Sofia Morales Diaz', 'DOC-1005', '1993-01-18', '5551-1005', 'sofia.morales@email.com');

-- MEDICOS

INSERT INTO medicos (
    id_medico,
    nombre_completo,
    especialidad,
    registro_profesional,
    telefono,
    correo
) VALUES
(1, 'Andrea Gonzalez Ruiz', 'Cardiologia', 'REG-2001', '5552-2001', 'andrea.gonzalez@clinica.com'),
(2, 'Fernando Lopez Castillo', 'Pediatria', 'REG-2002', '5552-2002', 'fernando.lopez@clinica.com'),
(3, 'Valentina Perez Soto', 'Dermatologia', 'REG-2003', '5552-2003', 'valentina.perez@clinica.com'),
(4, 'Diego Martinez Rojas', 'Neurologia', 'REG-2004', '5552-2004', 'diego.martinez@clinica.com'),
(5, 'Gabriela Torres Mendoza', 'Medicina General', 'REG-2005', '5552-2005', 'gabriela.torres@clinica.com');

-- CONSULTORIOS

INSERT INTO consultorios (
    id_consultorio,
    numero,
    piso,
    especialidad,
    capacidad
) VALUES
(1, 101, 1, 'Cardiologia', 2),
(2, 102, 1, 'Pediatria', 3),
(3, 201, 2, 'Dermatologia', 2),
(4, 202, 2, 'Neurologia', 2),
(5, 301, 3, 'Medicina General', 4);

-- CITAS

INSERT INTO citas (
    id_cita,
    id_paciente,
    id_medico,
    id_consultorio,
    fecha_hora,
    motivo,
    estado
) VALUES
(1, 1, 1, 1, '2026-08-21 08:00', 'Control cardiologico', 'Confirmada'),
(2, 2, 2, 2, '2026-08-21 09:00', 'Consulta pediatrica familiar', 'Programada'),
(3, 3, 3, 3, '2026-08-21 10:00', 'Revision dermatologica', 'Confirmada'),
(4, 4, 4, 4, '2026-08-21 11:00', 'Dolor de cabeza recurrente', 'Programada'),
(5, 5, 5, 5, '2026-08-21 12:00', 'Chequeo general', 'Confirmada'),
(6, 1, 5, 5, '2026-08-22 08:30', 'Seguimiento general', 'Programada'),
(7, 2, 1, 1, '2026-08-22 09:30', 'Evaluacion cardiovascular', 'Programada'),
(8, 3, 3, 3, '2026-08-22 10:30', 'Control de tratamiento', 'Confirmada'),
(9, 4, 4, 4, '2026-08-22 11:30', 'Evaluacion neurologica', 'Programada'),
(10, 5, 5, 5, '2026-08-22 13:00', 'Consulta preventiva', 'Confirmada');