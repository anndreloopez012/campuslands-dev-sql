PRAGMA foreign_keys = ON;

-- Ejercicio 063: Clinica de Tatuajes
-- Modelo: clientes, artistas, estilos, sesiones, pagos

CREATE TABLE clientes (
    id_cliente   INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre       TEXT NOT NULL,
    telefono     TEXT NOT NULL UNIQUE
);

CREATE TABLE artistas (
    id_artista     INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre         TEXT NOT NULL,
    especialidad   TEXT NOT NULL
);

CREATE TABLE estilos (
    id_estilo   INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre      TEXT NOT NULL UNIQUE
);

CREATE TABLE sesiones (
    id_sesion         INTEGER PRIMARY KEY AUTOINCREMENT,
    -- NOT NULL en las 3 relaciones: para evitar registros incompletos
    -- que despues no permiten hacer reportes confiables.
    id_cliente        INTEGER NOT NULL,
    id_artista        INTEGER NOT NULL,
    id_estilo         INTEGER NOT NULL,
    fecha_sesion      TEXT NOT NULL DEFAULT (date('now')),
    duracion_horas    REAL NOT NULL CHECK (duracion_horas > 0),
    estado            TEXT NOT NULL DEFAULT 'agendada'
                          CHECK (estado IN ('agendada', 'completada', 'cancelada')),

    FOREIGN KEY (id_cliente) REFERENCES clientes (id_cliente),
    FOREIGN KEY (id_artista) REFERENCES artistas (id_artista),
    FOREIGN KEY (id_estilo) REFERENCES estilos (id_estilo)
);

CREATE TABLE pagos (
    id_pago        INTEGER PRIMARY KEY AUTOINCREMENT,
    -- UNIQUE: cada sesion tiene como maximo un pago (relacion 1:1).
    id_sesion      INTEGER NOT NULL UNIQUE,
    monto          REAL NOT NULL CHECK (monto > 0),
    metodo_pago    TEXT NOT NULL CHECK (metodo_pago IN ('efectivo', 'tarjeta', 'transferencia')),
    estado_pago    TEXT NOT NULL DEFAULT 'pendiente'
                       CHECK (estado_pago IN ('pendiente', 'pagado', 'reembolsado')),

    FOREIGN KEY (id_sesion) REFERENCES sesiones (id_sesion)
);
