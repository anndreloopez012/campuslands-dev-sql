PRAGMA foreign_keys = ON;
-- Ejercicio 33: Normalizacion Matriculas Academicas

CREATE TABLE estudiante (
    documento TEXT PRIMARY KEY,
    nombre TEXT NOT NULL,
    CHECK (length(trim(nombre)) > 0),
    CHECK (documento LIKE 'DPI-%')
);

CREATE TABLE trainer (
    id_trainer INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL UNIQUE,
    CHECK (length(trim(nombre)) > 0)
);

CREATE TABLE ruta (
    id_ruta INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL UNIQUE,
    id_trainer INTEGER NOT NULL,
    FOREIGN KEY (id_trainer) REFERENCES trainer (id_trainer)
);

CREATE TABLE modulo (
    id_modulo INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL UNIQUE,
    CHECK (length(trim(nombre)) > 0)
);

CREATE TABLE matricula (
    id_matricula INTEGER PRIMARY KEY,
    documento TEXT NOT NULL,
    id_ruta INTEGER NOT NULL,
    FOREIGN KEY (documento) REFERENCES estudiante (documento),
    FOREIGN KEY (id_ruta) REFERENCES ruta (id_ruta)
);

CREATE TABLE matricula_modulo (
    id_matricula INTEGER NOT NULL,
    id_modulo INTEGER NOT NULL,
    horario TEXT NOT NULL,
    nota INTEGER NOT NULL,
    PRIMARY KEY (id_matricula, id_modulo),
    FOREIGN KEY (id_matricula) REFERENCES matricula (id_matricula),
    FOREIGN KEY (id_modulo) REFERENCES modulo (id_modulo),
    CHECK (nota BETWEEN 0 AND 100),
    CHECK (horario LIKE '__:__')
);  