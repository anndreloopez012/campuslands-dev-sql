PRAGMA foreign_keys = ON;

-- Ejercicio 69: DROP Nivel Intermedio
-- Se ejecuta despues de que ddl/schema.sql migro los datos de medicos y
-- elimino la tabla temporal y la vista de apoyo. Aqui solo se agregan
-- registros nuevos directamente a las tablas definitivas.

INSERT INTO pacientes (nombre, telefono) VALUES
    ('Cristina Barrios', '5555-7004');

INSERT INTO citas (id_paciente, id_medico, fecha_cita, estado) VALUES
    (4, 2, '2026-08-03 11:00', 'programada');
