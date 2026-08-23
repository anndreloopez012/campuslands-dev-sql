PRAGMA foreign_keys = ON;

-- Ejercicio 51: UNIQUE Nivel Intermedio
-- Tema central: UNIQUE
-- Contexto: agenda de citas de una clinica.

CREATE TABLE pacientes (
    id_paciente  INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre       TEXT NOT NULL,
    documento    TEXT NOT NULL UNIQUE   -- UNIQUE simple: campo candidato tipico (numero de documento)
);

CREATE TABLE medicos (
    id_medico   INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre      TEXT NOT NULL,
    correo      TEXT NOT NULL UNIQUE    -- UNIQUE simple: campo candidato tipico (email)
);

-- citas: aqui esta el punto central del nivel intermedio, un UNIQUE
-- COMPUESTO: (id_medico, fecha_hora). Ninguna de las dos columnas por
-- separado necesita ser unica (un medico atiende muchas citas, y a la misma
-- hora pueden citarse varios medicos distintos), pero la COMBINACION de
-- ambas si debe serlo: evita que el mismo medico quede agendado dos veces
-- a la misma hora (doble reserva).
CREATE TABLE citas (
    id_cita       INTEGER PRIMARY KEY AUTOINCREMENT,
    id_paciente   INTEGER NOT NULL,
    id_medico     INTEGER NOT NULL,
    fecha_hora    TEXT NOT NULL,
    estado        TEXT NOT NULL CHECK (estado IN ('programada', 'atendida', 'cancelada')),

    FOREIGN KEY (id_paciente) REFERENCES pacientes (id_paciente),
    FOREIGN KEY (id_medico) REFERENCES medicos (id_medico),
    UNIQUE (id_medico, fecha_hora)
);
