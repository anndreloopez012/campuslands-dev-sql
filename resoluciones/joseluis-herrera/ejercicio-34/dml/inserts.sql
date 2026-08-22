INSERT INTO pacientes (
    id_paciente,
    dpi,
    nombre_completo,
    fecha_nacimiento,
    telefono,
    estado
) VALUES
(1, '1234567890101', 'Ana López García', '1995-03-15', '55510001', 'activo'),
(2, '1234567890102', 'Carlos Méndez Ruiz', '1988-07-21', '55510002', 'activo'),
(3, '1234567890103', 'María González Pérez', '1992-11-08', '55510003', 'activo'),
(4, '1234567890104', 'José Ramírez Soto', '1979-05-30', '55510004', 'activo'),
(5, '1234567890105', 'Sofía Hernández Díaz', '2000-01-17', '55510005', 'activo'),
(6, '1234567890106', 'Luis Castillo Morales', '1985-09-12', '55510006', 'activo'),
(7, '1234567890107', 'Laura Torres Méndez', '1998-06-25', '55510007', 'activo'),
(8, '1234567890108', 'Diego Vargas López', '1990-12-03', '55510008', 'activo');

INSERT INTO especialidades (
    id_especialidad,
    nombre,
    descripcion
) VALUES
(1, 'Medicina general', 'Atención médica general'),
(2, 'Cardiología', 'Diagnóstico y tratamiento del sistema cardiovascular'),
(3, 'Dermatología', 'Diagnóstico y tratamiento de enfermedades de la piel'),
(4, 'Pediatría', 'Atención médica para niños y adolescentes'),
(5, 'Traumatología', 'Diagnóstico y tratamiento del sistema musculoesquelético'),
(6, 'Neurología', 'Diagnóstico y tratamiento del sistema nervioso');

INSERT INTO medicos (
    id_medico,
    nombre_completo,
    colegiado,
    id_especialidad,
    estado
) VALUES
(1, 'Dr. Roberto Morales', 'COL001', 1, 'activo'),
(2, 'Dra. Patricia Gómez', 'COL002', 2, 'activo'),
(3, 'Dr. Fernando Castillo', 'COL003', 3, 'activo'),
(4, 'Dra. Elena Ramírez', 'COL004', 4, 'activo'),
(5, 'Dr. Miguel Torres', 'COL005', 5, 'activo'),
(6, 'Dra. Andrea López', 'COL006', 6, 'activo');

INSERT INTO tratamientos (
    id_tratamiento,
    nombre,
    descripcion,
    costo,
    estado
) VALUES
(1, 'Consulta general', 'Evaluación médica general', 150.00, 'activo'),
(2, 'Electrocardiograma', 'Estudio de actividad eléctrica del corazón', 350.00, 'activo'),
(3, 'Tratamiento dermatológico', 'Tratamiento especializado para afecciones de la piel', 275.00, 'activo'),
(4, 'Terapia física', 'Sesiones de rehabilitación física', 200.00, 'activo'),
(5, 'Control pediátrico', 'Evaluación integral pediátrica', 180.00, 'activo'),
(6, 'Resonancia magnética', 'Estudio diagnóstico mediante resonancia magnética', 950.00, 'activo'),
(7, 'Análisis de laboratorio', 'Pruebas generales de laboratorio clínico', 225.00, 'activo');

INSERT INTO consultas (
    id_consulta,
    id_paciente,
    id_medico,
    fecha_consulta,
    diagnostico,
    estado
) VALUES
(1, 1, 1, '2026-08-01 09:00:00', 'Control médico general', 'realizada'),
(2, 2, 2, '2026-08-01 10:30:00', 'Hipertensión arterial', 'realizada'),
(3, 3, 3, '2026-08-02 11:00:00', 'Dermatitis', 'realizada'),
(4, 4, 5, '2026-08-02 15:00:00', 'Dolor lumbar', 'realizada'),
(5, 5, 4, '2026-08-03 08:30:00', 'Control pediátrico', 'realizada'),
(6, 6, 1, '2026-08-03 09:30:00', 'Gastritis', 'realizada'),
(7, 7, 2, '2026-08-04 10:00:00', 'Arritmia', 'realizada'),
(8, 8, 6, '2026-08-04 14:30:00', 'Migraña', 'realizada'),
(9, 1, 2, '2026-08-05 11:30:00', 'Dolor torácico', 'realizada'),
(10, 2, 1, '2026-08-06 09:00:00', 'Control preventivo', 'realizada'),
(11, 3, 3, '2026-08-07 13:00:00', 'Acné', 'realizada'),
(12, 5, 4, '2026-08-08 08:00:00', 'Control de crecimiento', 'realizada'),
(13, 6, 5, '2026-08-09 16:00:00', 'Lesión muscular', 'programada');

INSERT INTO detalle_tratamiento (
    id_consulta,
    id_tratamiento,
    cantidad,
    indicaciones
) VALUES
(1, 1, 1, 'Control general en treinta días'),
(1, 7, 1, 'Realizar en ayunas'),
(2, 2, 1, 'Realizar durante la consulta'),
(2, 7, 1, 'Realizar pruebas de laboratorio'),
(3, 3, 1, 'Aplicar según indicaciones médicas'),
(4, 4, 5, 'Cinco sesiones de terapia física'),
(5, 5, 1, 'Nuevo control en tres meses'),
(6, 1, 1, 'Control general en quince días'),
(6, 7, 1, 'Realizar pruebas de laboratorio'),
(7, 2, 1, 'Control cardiovascular'),
(8, 6, 1, 'Realizar estudio según programación'),
(9, 2, 1, 'Seguimiento cardiológico'),
(10, 1, 1, 'Control preventivo anual'),
(11, 3, 1, 'Tratamiento dermatológico por cuatro semanas'),
(12, 5, 1, 'Control pediátrico mensual'),
(13, 4, 8, 'Ocho sesiones de rehabilitación');

-- CASOS INVALIDOS

-- INSERT INTO pacientes (id_paciente, dpi, nombre_completo, fecha_nacimiento, telefono, estado)
-- VALUES (9, '1234567890101', 'Pedro López', '1990-01-01', '55510009', 'activo');

-- INSERT INTO detalle_tratamiento (id_consulta, id_tratamiento, cantidad, indicaciones)
-- VALUES (1, 1, 0, 'Cantidad inválida');