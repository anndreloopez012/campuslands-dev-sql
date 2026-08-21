PRAGMA foreign_keys = ON;

-- Ejercicio 039: Mecanica de Autos
-- Modelo: clientes -> vehiculos -> diagnosticos, una cadena de
-- FOREIGN KEY. fecha_ultimo_cambio guarda cuando cambio el estado por
-- ultima vez, para poder responder auditorias (que paso y cuando).

CREATE TABLE clientes (
    id_cliente     INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_cliente TEXT NOT NULL UNIQUE,
    telefono       TEXT NOT NULL
);

CREATE TABLE vehiculos (
    id_vehiculo INTEGER PRIMARY KEY AUTOINCREMENT,
    placa       TEXT NOT NULL UNIQUE,
    marca       TEXT NOT NULL,
    modelo      TEXT NOT NULL,
    id_cliente  INTEGER NOT NULL,

    FOREIGN KEY (id_cliente) REFERENCES clientes (id_cliente)
);

-- diagnosticos: tabla principal. El estado se corrige con UPDATE
-- (nunca con DELETE) y cada cambio actualiza fecha_ultimo_cambio, tal
-- como pidio el cliente para sus auditorias.
CREATE TABLE diagnosticos (
    id_diagnostico      INTEGER PRIMARY KEY AUTOINCREMENT,
    id_vehiculo         INTEGER NOT NULL,
    fecha_diagnostico   TEXT NOT NULL,
    descripcion         TEXT NOT NULL,
    costo_reparacion    REAL NOT NULL CHECK (costo_reparacion >= 0),
    estado              TEXT NOT NULL DEFAULT 'diagnosticado' CHECK (estado IN ('diagnosticado', 'en_reparacion', 'reparado', 'en_garantia')),
    garantia_meses      INTEGER NOT NULL DEFAULT 0 CHECK (garantia_meses >= 0),
    fecha_ultimo_cambio TEXT NOT NULL,

    FOREIGN KEY (id_vehiculo) REFERENCES vehiculos (id_vehiculo)
);
