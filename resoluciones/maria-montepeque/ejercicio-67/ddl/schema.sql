PRAGMA foreign_keys = ON;

-- Ejercicio 67: ALTER TABLE Nivel Aplicado
-- Tema central: ALTER TABLE
-- Contexto: agenda de citas medicas por fecha.

-- Version inicial de las 3 tablas, tal como se crearon antes de que la
-- clinica pidiera controlar el estado de cada cita.
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

    FOREIGN KEY (id_paciente) REFERENCES pacientes (id_paciente),
    FOREIGN KEY (id_medico) REFERENCES medicos (id_medico)
);

-- Se insertan datos con la estructura original, antes de modificar las
-- tablas. Sirve para demostrar que ALTER TABLE no destruye los datos ya
-- existentes.
INSERT INTO medicos (nombre, especialidad) VALUES
    ('Dra. Sofia Ramirez', 'Medicina General'),
    ('Dr. Carlos Perez', 'Pediatria');

INSERT INTO pacientes (nombre, telefono) VALUES
    ('Manuel Estrada', '5555-6001'),
    ('Alejandra Chinchilla', '5555-6002'),
    ('Byron Xicay', '5555-6003');

INSERT INTO citas (id_paciente, id_medico, fecha_cita) VALUES
    (1, 1, '2026-08-01 09:00'),
    (2, 2, '2026-08-01 10:30'),
    (3, 1, '2026-08-02 08:00'),
    (1, 2, '2026-08-03 11:00');

-- ALTER TABLE 1: la clinica pide saber el estado de cada cita
-- (programada, atendida o cancelada). Se agrega con DEFAULT para que
-- las 4 citas ya existentes queden validas de inmediato.
ALTER TABLE citas
    ADD COLUMN estado TEXT NOT NULL DEFAULT 'programada'
        CHECK (estado IN ('programada', 'atendida', 'cancelada'));

-- ALTER TABLE 2: la clinica pide registrar el motivo de cada cita.
ALTER TABLE citas
    ADD COLUMN motivo TEXT NOT NULL DEFAULT 'consulta general';

-- ALTER TABLE 3: la clinica pide saber en que consultorio atiende cada
-- medico.
ALTER TABLE medicos
    ADD COLUMN consultorio TEXT NOT NULL DEFAULT 'Sin asignar';

-- ALTER TABLE 4: renombrar una columna para que el nombre sea mas claro
-- (fecha_cita -> fecha_hora_cita), ahora que la cita tiene mas columnas.
ALTER TABLE citas
    RENAME COLUMN fecha_cita TO fecha_hora_cita;

-- Caso que debe fallar / no recomendable (queda comentado): SQLite no
-- permite agregar una columna con UNIQUE mediante ALTER TABLE ADD
-- COLUMN, aunque la tabla este vacia de esa columna. Para agregar una
-- restriccion UNIQUE a una columna nueva hay que crear un indice unico
-- aparte (CREATE UNIQUE INDEX) despues del ALTER TABLE.
-- ALTER TABLE medicos ADD COLUMN codigo_colegiado TEXT UNIQUE;
