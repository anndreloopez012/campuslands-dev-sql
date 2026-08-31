PRAGMA foreign_keys = ON;

-- Ejercicio 105: Triggers Nivel Intermedio
-- Tema central: Triggers
-- Contexto: agenda de citas medicas programadas por fecha.

CREATE TABLE pacientes (
    id_paciente      INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_paciente  TEXT NOT NULL,
    telefono         TEXT NOT NULL UNIQUE
);

CREATE TABLE medicos (
    id_medico       INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_medico   TEXT NOT NULL UNIQUE,
    especialidad    TEXT NOT NULL
);

CREATE TABLE citas (
    id_cita        INTEGER PRIMARY KEY AUTOINCREMENT,
    id_paciente    INTEGER NOT NULL,
    id_medico      INTEGER NOT NULL,
    fecha_cita     TEXT NOT NULL,
    hora_cita      TEXT NOT NULL,
    estado         TEXT NOT NULL DEFAULT 'programada'
                       CHECK (estado IN ('programada', 'cancelada', 'atendida')),

    FOREIGN KEY (id_paciente) REFERENCES pacientes (id_paciente),
    FOREIGN KEY (id_medico) REFERENCES medicos (id_medico)
);

-- Tabla de auditoria: historial de cambios de estado de cada cita.
CREATE TABLE citas_auditoria (
    id_auditoria      INTEGER PRIMARY KEY AUTOINCREMENT,
    id_cita           INTEGER NOT NULL,
    estado_anterior   TEXT NOT NULL,
    estado_nuevo      TEXT NOT NULL,
    fecha_evento      TEXT NOT NULL DEFAULT (datetime('now')),

    FOREIGN KEY (id_cita) REFERENCES citas (id_cita)
);

-- Trigger 1: automatiza el registro de auditoria (tema central del
-- ejercicio). Cada vez que cambia el "estado" de una cita, se dispara
-- DESPUES del UPDATE y guarda una fila en "citas_auditoria" con el
-- estado anterior (OLD) y el nuevo (NEW).
CREATE TRIGGER trg_auditar_cambio_estado_cita
AFTER UPDATE OF estado ON citas
FOR EACH ROW
WHEN OLD.estado <> NEW.estado
BEGIN
    INSERT INTO citas_auditoria (id_cita, estado_anterior, estado_nuevo)
    VALUES (NEW.id_cita, OLD.estado, NEW.estado);
END;

-- Trigger 2: regla de negocio de dos tablas relacionadas (citas +
-- citas_auditoria a traves del historial). Una vez que una cita quedo
-- "atendida", se considera un registro historico cerrado: cualquier
-- intento de modificarla (cambiar su estado, su horario, etc.) se
-- bloquea ANTES de que el UPDATE llegue a aplicarse.
CREATE TRIGGER trg_bloquear_edicion_cita_atendida
BEFORE UPDATE ON citas
FOR EACH ROW
WHEN OLD.estado = 'atendida'
BEGIN
    SELECT RAISE(ABORT, 'No se puede modificar una cita que ya fue atendida');
END;
