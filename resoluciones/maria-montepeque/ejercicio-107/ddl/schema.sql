PRAGMA foreign_keys = ON;

-- Ejercicio 107: Indices Nivel Basico
-- Tema central: Indices
-- Contexto: agenda de citas medicas programadas por fecha.

CREATE TABLE citas (
    id_cita          INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_paciente  TEXT NOT NULL,
    nombre_medico    TEXT NOT NULL,
    fecha_cita       TEXT NOT NULL,
    hora_cita        TEXT NOT NULL,
    estado           TEXT NOT NULL DEFAULT 'programada'
                         CHECK (estado IN ('programada', 'cancelada', 'atendida'))
);

-- Indice: la agenda se consulta constantemente filtrando por fecha
-- ("que citas hay el 2026-09-01"), que es justo el caso de uso del
-- contexto del ejercicio. Sin un indice, SQLite tendria que revisar
-- fila por fila toda la tabla (SCAN) para encontrar las citas de una
-- fecha; con el indice, puede saltar directo a ellas (SEARCH).
CREATE INDEX idx_citas_fecha ON citas (fecha_cita);
