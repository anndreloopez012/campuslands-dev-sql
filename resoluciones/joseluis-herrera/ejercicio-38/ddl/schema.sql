PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS detalle_orden;
DROP TABLE IF EXISTS envios;
DROP TABLE IF EXISTS pagos;
DROP TABLE IF EXISTS ordenes;
DROP TABLE IF EXISTS productos;
DROP TABLE IF EXISTS cupones;
DROP TABLE IF EXISTS transportadoras;
DROP TABLE IF EXISTS compradores;

CREATE TABLE compradores (
    id_comprador INTEGER PRIMARY KEY,
    nombre_completo TEXT NOT NULL,
    documento TEXT NOT NULL UNIQUE,
    email TEXT NOT NULL UNIQUE,
    telefono TEXT,
    CHECK (length(documento) >= 5),
    CHECK (length(nombre_completo) >= 3)
);

CREATE TABLE productos (
    id_producto INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL UNIQUE,
    categoria TEXT NOT NULL,
    precio REAL NOT NULL,
    stock INTEGER NOT NULL DEFAULT 0,
    CHECK (precio > 0),
    CHECK (stock >= 0)
);

CREATE TABLE cupones (
    id_cupon INTEGER PRIMARY KEY,
    codigo TEXT NOT NULL UNIQUE,
    descuento REAL NOT NULL,
    fecha_inicio TEXT NOT NULL,
    fecha_fin TEXT NOT NULL,
    estado TEXT NOT NULL DEFAULT 'activo',
    CHECK (descuento > 0 AND descuento <= 100),
    CHECK (fecha_fin >= fecha_inicio),
    CHECK (estado IN ('activo', 'inactivo'))
);

CREATE TABLE transportadoras (
    id_transportadora INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL UNIQUE,
    telefono TEXT,
    estado TEXT NOT NULL DEFAULT 'activa',
    CHECK (estado IN ('activa', 'inactiva'))
);

CREATE TABLE ordenes (
    id_orden INTEGER PRIMARY KEY,
    id_comprador INTEGER NOT NULL,
    id_cupon INTEGER,
    fecha_orden TEXT NOT NULL,
    direccion_envio TEXT NOT NULL,
    estado TEXT NOT NULL DEFAULT 'pendiente',
    FOREIGN KEY (id_comprador) REFERENCES compradores(id_comprador),
    FOREIGN KEY (id_cupon) REFERENCES cupones(id_cupon),
    CHECK (estado IN ('pendiente', 'procesando', 'enviada', 'entregada', 'cancelada'))
);

CREATE TABLE detalle_orden (
    id_detalle INTEGER PRIMARY KEY,
    id_orden INTEGER NOT NULL,
    id_producto INTEGER NOT NULL,
    cantidad INTEGER NOT NULL,
    precio_unitario REAL NOT NULL,
    FOREIGN KEY (id_orden) REFERENCES ordenes(id_orden),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto),
    UNIQUE (id_orden, id_producto),
    CHECK (cantidad > 0),
    CHECK (precio_unitario > 0)
);

CREATE TABLE pagos (
    id_pago INTEGER PRIMARY KEY,
    id_orden INTEGER NOT NULL UNIQUE,
    metodo_pago TEXT NOT NULL,
    monto REAL NOT NULL,
    fecha_pago TEXT NOT NULL,
    estado TEXT NOT NULL DEFAULT 'aprobado',
    FOREIGN KEY (id_orden) REFERENCES ordenes(id_orden),
    CHECK (monto > 0),
    CHECK (estado IN ('pendiente', 'aprobado', 'rechazado')),
    CHECK (metodo_pago IN ('tarjeta', 'transferencia', 'paypal', 'efectivo'))
);

CREATE TABLE envios (
    id_envio INTEGER PRIMARY KEY,
    id_orden INTEGER NOT NULL UNIQUE,
    id_transportadora INTEGER NOT NULL,
    numero_guia TEXT NOT NULL UNIQUE,
    fecha_envio TEXT,
    fecha_entrega TEXT,
    estado TEXT NOT NULL DEFAULT 'preparando',
    FOREIGN KEY (id_orden) REFERENCES ordenes(id_orden),
    FOREIGN KEY (id_transportadora) REFERENCES transportadoras(id_transportadora),
    CHECK (estado IN ('preparando', 'en_transito', 'entregado', 'devuelto')),
    CHECK (fecha_entrega IS NULL OR fecha_envio IS NULL OR fecha_entrega >= fecha_envio)
);

CREATE INDEX idx_ordenes_comprador
ON ordenes(id_comprador);

CREATE INDEX idx_ordenes_fecha
ON ordenes(fecha_orden);

CREATE INDEX idx_detalle_orden_orden
ON detalle_orden(id_orden);

CREATE INDEX idx_detalle_orden_producto
ON detalle_orden(id_producto);

CREATE INDEX idx_pagos_fecha
ON pagos(fecha_pago);

CREATE INDEX idx_envios_transportadora
ON envios(id_transportadora);