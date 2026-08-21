PRAGMA foreign_keys = ON;

-- Ejercicio 49: FOREIGN KEY Nivel Aplicado
-- Tema central: FOREIGN KEY
-- Contexto: agenda de citas de una clinica.

CREATE TABLE pacientes (
    id_paciente  INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre       TEXT NOT NULL,
    documento    TEXT NOT NULL UNIQUE
);

CREATE TABLE medicos (
    id_medico       INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre          TEXT NOT NULL UNIQUE,
    especialidad    TEXT NOT NULL
);

-- citas: cierra la serie de FOREIGN KEY con la tercera accion ON DELETE que
-- faltaba (RESTRICT en el 47, CASCADE en el 48, aqui SET NULL):
--
-- - id_paciente: ON DELETE RESTRICT. El historial de citas de un paciente
--   es informacion clinica que no se debe perder ni desvincular; no se
--   permite borrar un paciente mientras tenga citas registradas.
--
-- - id_medico: ON DELETE SET NULL. Si un medico deja de trabajar en la
--   clinica y se elimina su registro, las citas ya realizadas siguen
--   siendo validas como historial del paciente, pero pierden la referencia
--   al medico especifico (queda NULL: "medico no disponible") en vez de
--   borrarse o de impedir la eliminacion del medico.
CREATE TABLE citas (
    id_cita       INTEGER PRIMARY KEY AUTOINCREMENT,
    id_paciente   INTEGER NOT NULL,
    id_medico     INTEGER,   -- NULLABLE: puede quedar sin medico tras un SET NULL
    fecha_cita    TEXT NOT NULL,
    estado        TEXT NOT NULL CHECK (estado IN ('programada', 'atendida', 'cancelada')),

    FOREIGN KEY (id_paciente) REFERENCES pacientes (id_paciente)
        ON DELETE RESTRICT,
    FOREIGN KEY (id_medico) REFERENCES medicos (id_medico)
        ON DELETE SET NULL
);
