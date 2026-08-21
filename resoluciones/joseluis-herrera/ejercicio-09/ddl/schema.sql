PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS pagos;
DROP TABLE IF EXISTS membresias;
DROP TABLE IF EXISTS clientes;
DROP TABLE IF EXISTS planes;

CREATE TABLE clientes (
    id_cliente INTEGER PRIMARY KEY,
    nombre_completo TEXT NOT NULL,
    documento TEXT NOT NULL UNIQUE,
    telefono TEXT NOT NULL,
    correo TEXT NOT NULL UNIQUE,
    estado TEXT NOT NULL DEFAULT 'ACTIVO',
    CHECK (estado IN ('ACTIVO', 'INACTIVO')),
    CHECK (length(telefono) >= 8)
);

CREATE TABLE planes (
    id_plan INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL UNIQUE,
    duracion_meses INTEGER NOT NULL,
    precio REAL NOT NULL,
    descripcion TEXT NOT NULL,
    CHECK (duracion_meses > 0),
    CHECK (precio > 0)
);

CREATE TABLE membresias (
    id_membresia INTEGER PRIMARY KEY,
    id_cliente INTEGER NOT NULL,
    id_plan INTEGER NOT NULL,
    fecha_inicio TEXT NOT NULL,
    fecha_fin TEXT NOT NULL,
    estado TEXT NOT NULL DEFAULT 'ACTIVA',
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_plan) REFERENCES planes(id_plan),
    UNIQUE (id_cliente, fecha_inicio),
    CHECK (estado IN ('ACTIVA', 'VENCIDA', 'CANCELADA')),
    CHECK (fecha_fin >= fecha_inicio)
);

CREATE TABLE pagos (
    id_pago INTEGER PRIMARY KEY,
    id_membresia INTEGER NOT NULL,
    fecha_pago TEXT NOT NULL,
    monto REAL NOT NULL,
    metodo_pago TEXT NOT NULL,
    estado TEXT NOT NULL DEFAULT 'PAGADO',
    FOREIGN KEY (id_membresia) REFERENCES membresias(id_membresia),
    CHECK (monto > 0),
    CHECK (metodo_pago IN ('EFECTIVO', 'TARJETA', 'TRANSFERENCIA')),
    CHECK (estado IN ('PAGADO', 'PENDIENTE', 'ANULADO'))
);