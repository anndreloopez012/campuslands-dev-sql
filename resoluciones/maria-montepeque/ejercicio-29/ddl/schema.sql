PRAGMA foreign_keys = ON;

-- Ejercicio 29: Transacciones Reservas
-- Modelo: usuarios, recursos, reservas, pagos

CREATE TABLE usuarios (
    id_usuario  INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre      TEXT NOT NULL,
    correo      TEXT NOT NULL UNIQUE
);

CREATE TABLE recursos (
    id_recurso     INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre         TEXT NOT NULL UNIQUE,
    precio_hora    REAL NOT NULL CHECK (precio_hora > 0)
);

CREATE TABLE reservas (
    id_reserva      INTEGER PRIMARY KEY AUTOINCREMENT,
    id_usuario      INTEGER NOT NULL,
    id_recurso      INTEGER NOT NULL,
    fecha_inicio    TEXT NOT NULL,   -- ISO 'YYYY-MM-DD HH:MM'
    fecha_fin       TEXT NOT NULL,   -- ISO 'YYYY-MM-DD HH:MM'
    estado          TEXT NOT NULL CHECK (estado IN ('pendiente', 'confirmada', 'cancelada')),

    CHECK (fecha_fin > fecha_inicio),
    FOREIGN KEY (id_usuario) REFERENCES usuarios (id_usuario),
    FOREIGN KEY (id_recurso) REFERENCES recursos (id_recurso)
);

-- Un pago por reserva (relacion 1 a 1): UNIQUE en id_reserva evita pagos duplicados
CREATE TABLE pagos (
    id_pago      INTEGER PRIMARY KEY AUTOINCREMENT,
    id_reserva   INTEGER NOT NULL UNIQUE,
    monto        REAL NOT NULL CHECK (monto > 0),
    fecha        TEXT NOT NULL,   -- ISO 'YYYY-MM-DD'

    FOREIGN KEY (id_reserva) REFERENCES reservas (id_reserva)
);
