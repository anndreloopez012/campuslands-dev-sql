PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS pagos;
DROP TABLE IF EXISTS reservas;
DROP TABLE IF EXISTS recursos;
DROP TABLE IF EXISTS usuarios;

CREATE TABLE usuarios (
    id_usuario INTEGER PRIMARY KEY,
    nombre_completo VARCHAR(150) NOT NULL,
    correo VARCHAR(150) NOT NULL UNIQUE,
    telefono VARCHAR(30) NOT NULL
);

CREATE TABLE recursos (
    id_recurso INTEGER PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    capacidad INTEGER NOT NULL CHECK (capacidad > 0),
    precio_hora DECIMAL(10, 2) NOT NULL CHECK (precio_hora > 0),
    estado VARCHAR(20) NOT NULL DEFAULT 'Disponible'
        CHECK (estado IN ('Disponible', 'Mantenimiento', 'Inactivo'))
);

CREATE TABLE reservas (
    id_reserva INTEGER PRIMARY KEY,
    id_usuario INTEGER NOT NULL,
    id_recurso INTEGER NOT NULL,
    fecha_inicio TEXT NOT NULL,
    fecha_fin TEXT NOT NULL,
    estado VARCHAR(20) NOT NULL DEFAULT 'Confirmada'
        CHECK (estado IN ('Confirmada', 'Pendiente', 'Cancelada', 'Finalizada')),
    total DECIMAL(10, 2) NOT NULL CHECK (total > 0),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (id_recurso) REFERENCES recursos(id_recurso)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CHECK (fecha_fin > fecha_inicio)
);

CREATE TABLE pagos (
    id_pago INTEGER PRIMARY KEY,
    id_reserva INTEGER NOT NULL,
    monto DECIMAL(10, 2) NOT NULL CHECK (monto > 0),
    fecha_pago TEXT NOT NULL,
    metodo_pago VARCHAR(30) NOT NULL
        CHECK (metodo_pago IN ('Efectivo', 'Tarjeta', 'Transferencia')),
    estado VARCHAR(20) NOT NULL DEFAULT 'Confirmado'
        CHECK (estado IN ('Confirmado', 'Pendiente', 'Rechazado')),
    FOREIGN KEY (id_reserva) REFERENCES reservas(id_reserva)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE INDEX idx_reservas_usuario
ON reservas(id_usuario);

CREATE INDEX idx_reservas_recurso
ON reservas(id_recurso);

CREATE INDEX idx_reservas_fecha_inicio
ON reservas(fecha_inicio);

CREATE INDEX idx_reservas_estado
ON reservas(estado);

CREATE INDEX idx_pagos_reserva
ON pagos(id_reserva);

CREATE INDEX idx_pagos_fecha
ON pagos(fecha_pago);