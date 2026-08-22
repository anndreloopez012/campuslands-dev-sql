PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS pagos;
DROP TABLE IF EXISTS reservas;
DROP TABLE IF EXISTS recursos;
DROP TABLE IF EXISTS usuarios;

CREATE TABLE usuarios (
    id_usuario INTEGER PRIMARY KEY,
    nombre_completo TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    telefono TEXT NOT NULL,
    fecha_registro TEXT NOT NULL,
    CHECK (length(trim(nombre_completo)) >= 5),
    CHECK (date(fecha_registro) IS NOT NULL)
);

CREATE TABLE recursos (
    id_recurso INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL UNIQUE,
    tipo TEXT NOT NULL,
    capacidad INTEGER NOT NULL,
    precio_hora REAL NOT NULL,
    estado TEXT NOT NULL DEFAULT 'disponible',
    CHECK (capacidad > 0),
    CHECK (precio_hora > 0),
    CHECK (estado IN ('disponible', 'mantenimiento', 'inactivo'))
);

CREATE TABLE reservas (
    id_reserva INTEGER PRIMARY KEY,
    id_usuario INTEGER NOT NULL,
    id_recurso INTEGER NOT NULL,
    fecha_reserva TEXT NOT NULL,
    hora_inicio TEXT NOT NULL,
    hora_fin TEXT NOT NULL,
    cantidad_horas INTEGER NOT NULL,
    total REAL NOT NULL,
    estado TEXT NOT NULL DEFAULT 'confirmada',
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_recurso) REFERENCES recursos(id_recurso),
    CHECK (cantidad_horas > 0),
    CHECK (total > 0),
    CHECK (hora_fin > hora_inicio),
    CHECK (estado IN ('pendiente', 'confirmada', 'cancelada', 'finalizada')),
    CHECK (date(fecha_reserva) IS NOT NULL),
    UNIQUE (id_recurso, fecha_reserva, hora_inicio)
);

CREATE TABLE pagos (
    id_pago INTEGER PRIMARY KEY,
    id_reserva INTEGER NOT NULL,
    fecha_pago TEXT NOT NULL,
    monto REAL NOT NULL,
    metodo_pago TEXT NOT NULL,
    estado TEXT NOT NULL DEFAULT 'aprobado',
    FOREIGN KEY (id_reserva) REFERENCES reservas(id_reserva),
    CHECK (monto > 0),
    CHECK (metodo_pago IN ('efectivo', 'tarjeta', 'transferencia')),
    CHECK (estado IN ('pendiente', 'aprobado', 'rechazado')),
    CHECK (date(fecha_pago) IS NOT NULL),
    UNIQUE (id_reserva)
);

CREATE INDEX idx_reservas_usuario
ON reservas(id_usuario);

CREATE INDEX idx_reservas_recurso
ON reservas(id_recurso);

CREATE INDEX idx_reservas_fecha
ON reservas(fecha_reserva);

CREATE INDEX idx_pagos_reserva
ON pagos(id_reserva);