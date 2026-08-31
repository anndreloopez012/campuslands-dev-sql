PRAGMA foreign_keys = ON;

-- Ejercicio 69: DROP Nivel Intermedio
-- Tema central: DROP
-- Contexto: agenda de citas medicas por fecha.

-- Tablas principales, permanentes.
CREATE TABLE medicos (
    id_medico      INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre         TEXT NOT NULL UNIQUE,
    especialidad   TEXT NOT NULL
);

CREATE TABLE pacientes (
    id_paciente   INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre        TEXT NOT NULL,
    telefono      TEXT NOT NULL UNIQUE
);

CREATE TABLE citas (
    id_cita        INTEGER PRIMARY KEY AUTOINCREMENT,
    id_paciente    INTEGER NOT NULL,
    id_medico      INTEGER NOT NULL,
    fecha_cita     TEXT NOT NULL,
    estado         TEXT NOT NULL DEFAULT 'programada'
                       CHECK (estado IN ('programada', 'atendida', 'cancelada')),

    FOREIGN KEY (id_paciente) REFERENCES pacientes (id_paciente),
    FOREIGN KEY (id_medico) REFERENCES medicos (id_medico)
);

-- Tabla temporal de importacion: la clinica recibio el listado de
-- medicos en un formato plano, sin las restricciones finales, y se uso
-- esta tabla solo para migrar los datos a la tabla definitiva.
CREATE TABLE medicos_temporal (
    nombre_bruto         TEXT,
    especialidad_bruta   TEXT
);

INSERT INTO medicos_temporal (nombre_bruto, especialidad_bruta) VALUES
    ('Dra. Sofia Ramirez', 'Medicina General'),
    ('Dr. Carlos Perez', 'Pediatria');

INSERT INTO medicos (nombre, especialidad)
SELECT nombre_bruto, especialidad_bruta FROM medicos_temporal;

INSERT INTO pacientes (nombre, telefono) VALUES
    ('Manuel Estrada', '5555-7001'),
    ('Alejandra Chinchilla', '5555-7002'),
    ('Byron Xicay', '5555-7003');

INSERT INTO citas (id_paciente, id_medico, fecha_cita, estado) VALUES
    (1, 1, '2026-08-01 09:00', 'atendida'),
    (2, 2, '2026-08-01 10:30', 'atendida'),
    (3, 1, '2026-08-02 08:00', 'programada');

-- DROP TABLE: la tabla de importacion ya cumplio su proposito (los
-- datos ya viven en `medicos`) y se elimina para no dejar datos
-- duplicados. Este es el riesgo de DROP: si se ejecutara antes de
-- migrar los datos, esa informacion se perderia para siempre.
DROP TABLE medicos_temporal;

-- Vista de apoyo para un reporte puntual de citas ya atendidas...
CREATE VIEW vista_citas_atendidas AS
    SELECT c.id_cita, p.nombre AS paciente, m.nombre AS medico, c.fecha_cita
    FROM citas c
    JOIN pacientes p ON p.id_paciente = c.id_paciente
    JOIN medicos m ON m.id_medico = c.id_medico
    WHERE c.estado = 'atendida';

-- ...y una vez entregado el reporte, se elimina porque ya no se va a
-- reutilizar. DROP VIEW solo borra la definicion de la vista: los datos
-- de `citas`, `pacientes` y `medicos` siguen intactos.
DROP VIEW vista_citas_atendidas;

-- Caso que debe fallar / no recomendable (queda comentado): intentar
-- eliminar una tabla que todavia esta referenciada por FOREIGN KEY
-- desde otra tabla con filas. SQLite, con PRAGMA foreign_keys = ON, no
-- permite este DROP mientras existan citas que dependan de medicos: hay
-- que eliminar o reasignar esas citas primero (o eliminar la tabla
-- `citas` antes que `medicos`).
-- DROP TABLE medicos;
