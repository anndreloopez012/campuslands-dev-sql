INSERT INTO pacientes (
    id_paciente,
    nombre_completo,
    documento,
    fecha_nacimiento,
    telefono,
    estado
) VALUES
    (1, 'Ana Lopez', 'DOC1001', '1998-03-15', '55510001', 'ACTIVO'),
    (2, 'Carlos Ramirez', 'DOC1002', '1992-07-20', '55510002', 'ACTIVO'),
    (3, 'Maria Gonzalez', 'DOC1003', '1987-11-05', '55510003', 'ACTIVO'),
    (4, 'Luis Martinez', 'DOC1004', '2001-01-18', '55510004', 'ACTIVO'),
    (5, 'Andrea Castillo', 'DOC1005', '1995-09-27', '55510005', 'ACTIVO');

INSERT INTO medicos (
    id_medico,
    nombre_completo,
    licencia,
    especialidad,
    telefono,
    estado
) VALUES
    (1, 'Dr. Juan Perez', 'LIC2001', 'Cardiologia', '55520001', 'ACTIVO'),
    (2, 'Dra. Sofia Morales', 'LIC2002', 'Pediatria', '55520002', 'ACTIVO'),
    (3, 'Dr. Miguel Torres', 'LIC2003', 'Dermatologia', '55520003', 'ACTIVO'),
    (4, 'Dra. Laura Hernandez', 'LIC2004', 'Medicina General', '55520004', 'ACTIVO'),
    (5, 'Dr. Carlos Mendoza', 'LIC2005', 'Traumatologia', '55520005', 'ACTIVO');

INSERT INTO consultorios (
    id_consultorio,
    numero,
    piso,
    especialidad,
    estado
) VALUES
    (1, 101, 1, 'Cardiologia', 'DISPONIBLE'),
    (2, 102, 1, 'Pediatria', 'DISPONIBLE'),
    (3, 201, 2, 'Dermatologia', 'DISPONIBLE'),
    (4, 202, 2, 'Medicina General', 'DISPONIBLE'),
    (5, 301, 3, 'Traumatologia', 'DISPONIBLE');

INSERT INTO citas (
    id_cita,
    id_paciente,
    id_medico,
    id_consultorio,
    fecha_hora,
    motivo,
    estado
) VALUES
    (1, 1, 1, 1, '2026-08-01 08:00', 'Control cardiaco', 'ATENDIDA'),
    (2, 2, 2, 2, '2026-08-01 09:00', 'Revision pediatrica', 'ATENDIDA'),
    (3, 3, 3, 3, '2026-08-02 10:00', 'Revision de piel', 'ATENDIDA'),
    (4, 4, 4, 4, '2026-08-02 11:00', 'Consulta general', 'ATENDIDA'),
    (5, 5, 5, 5, '2026-08-03 08:30', 'Dolor muscular', 'ATENDIDA'),
    (6, 1, 4, 4, '2026-08-04 09:30', 'Consulta preventiva', 'ATENDIDA'),
    (7, 2, 1, 1, '2026-08-05 10:30', 'Seguimiento cardiaco', 'ATENDIDA'),
    (8, 3, 3, 3, '2026-08-06 14:00', 'Control dermatologico', 'ATENDIDA'),
    (9, 4, 4, 4, '2026-08-07 15:00', 'Consulta general', 'ATENDIDA'),
    (10, 5, 5, 5, '2026-08-08 16:00', 'Revision traumatologica', 'ATENDIDA');