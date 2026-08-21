PRAGMA foreign_keys = ON;

-- Ejercicio 53: NOT NULL Nivel Basico
-- Tema central: NOT NULL
-- Contexto: agenda de citas de una clinica.

CREATE TABLE pacientes (
    id_paciente  INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre       TEXT NOT NULL,   -- obligatorio: no se puede registrar un paciente sin nombre
    telefono     TEXT NOT NULL,   -- obligatorio: la clinica siempre pide un telefono de contacto
    correo       TEXT             -- OPCIONAL: no todos los pacientes tienen o quieren dar correo
);

CREATE TABLE medicos (
    id_medico       INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre          TEXT NOT NULL,
    especialidad    TEXT NOT NULL
);

-- citas: tabla principal. Distingue claramente los campos obligatorios
-- (todo lo necesario para que la cita exista y se pueda ubicar) de los
-- opcionales (informacion adicional que puede completarse despues).
CREATE TABLE citas (
    id_cita       INTEGER PRIMARY KEY AUTOINCREMENT,
    id_paciente   INTEGER NOT NULL,   -- obligatorio: una cita siempre es de alguien
    id_medico     INTEGER NOT NULL,   -- obligatorio: una cita siempre es con alguien
    fecha_hora    TEXT NOT NULL,      -- obligatorio: sin fecha/hora, no hay como agendarla
    estado        TEXT NOT NULL DEFAULT 'programada' CHECK (estado IN ('programada', 'atendida', 'cancelada')),
    notas         TEXT,               -- OPCIONAL: observaciones del medico, se llenan despues de atender

    FOREIGN KEY (id_paciente) REFERENCES pacientes (id_paciente),
    FOREIGN KEY (id_medico) REFERENCES medicos (id_medico)
);
