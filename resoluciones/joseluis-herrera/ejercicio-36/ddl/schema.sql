PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS detalle_servicio;
DROP TABLE IF EXISTS reservas;
DROP TABLE IF EXISTS servicios;
DROP TABLE IF EXISTS habitaciones;
DROP TABLE IF EXISTS huespedes;

CREATE TABLE huespedes (
    id_huesped INTEGER PRIMARY KEY,
    nombre_completo TEXT NOT NULL,
    documento TEXT NOT NULL UNIQUE,
    telefono TEXT,
    email TEXT,
    estado TEXT NOT NULL DEFAULT 'activo',
    CHECK (length(documento) >= 5),
    CHECK (estado IN ('activo', 'inactivo'))
);

CREATE TABLE habitaciones (
    id_habitacion INTEGER PRIMARY KEY,
    numero INTEGER NOT NULL UNIQUE,
    tipo TEXT NOT NULL,
    capacidad INTEGER NOT NULL,
    precio_noche REAL NOT NULL,
    estado TEXT NOT NULL DEFAULT 'disponible',
    CHECK (capacidad > 0),
    CHECK (precio_noche > 0),
    CHECK (estado IN ('disponible', 'ocupada', 'mantenimiento'))
);

CREATE TABLE servicios (
    id_servicio INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL UNIQUE,
    descripcion TEXT,
    costo REAL NOT NULL,
    estado TEXT NOT NULL DEFAULT 'activo',
    CHECK (costo >= 0),
    CHECK (estado IN ('activo', 'inactivo'))
);

CREATE TABLE reservas (
    id_reserva INTEGER PRIMARY KEY,
    id_huesped INTEGER NOT NULL,
    id_habitacion INTEGER NOT NULL,
    fecha_entrada TEXT NOT NULL,
    fecha_salida TEXT NOT NULL,
    estado TEXT NOT NULL DEFAULT 'confirmada',
    FOREIGN KEY (id_huesped) REFERENCES huespedes(id_huesped),
    FOREIGN KEY (id_habitacion) REFERENCES habitaciones(id_habitacion),
    CHECK (fecha_salida > fecha_entrada),
    CHECK (estado IN ('pendiente', 'confirmada', 'cancelada', 'finalizada'))
);

CREATE TABLE detalle_servicio (
    id_detalle INTEGER PRIMARY KEY,
    id_reserva INTEGER NOT NULL,
    id_servicio INTEGER NOT NULL,
    cantidad INTEGER NOT NULL,
    fecha_servicio TEXT NOT NULL,
    costo_unitario REAL NOT NULL,
    FOREIGN KEY (id_reserva) REFERENCES reservas(id_reserva),
    FOREIGN KEY (id_servicio) REFERENCES servicios(id_servicio),
    UNIQUE (id_reserva, id_servicio, fecha_servicio),
    CHECK (cantidad > 0),
    CHECK (costo_unitario >= 0)
);

CREATE INDEX idx_reservas_huesped
ON reservas(id_huesped);

CREATE INDEX idx_reservas_habitacion
ON reservas(id_habitacion);

CREATE INDEX idx_reservas_fechas
ON reservas(fecha_entrada, fecha_salida);

CREATE INDEX idx_detalle_reserva
ON detalle_servicio(id_reserva);

CREATE INDEX idx_detalle_servicio
ON detalle_servicio(id_servicio);