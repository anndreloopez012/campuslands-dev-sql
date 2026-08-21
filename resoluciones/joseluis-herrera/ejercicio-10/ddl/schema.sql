PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS pagos;
DROP TABLE IF EXISTS reservas;
DROP TABLE IF EXISTS huespedes;
DROP TABLE IF EXISTS habitaciones;

CREATE TABLE huespedes (
    id_huesped INTEGER PRIMARY KEY,
    nombre_completo TEXT NOT NULL,
    documento TEXT NOT NULL UNIQUE,
    telefono TEXT NOT NULL,
    correo TEXT NOT NULL UNIQUE,
    CHECK (length(telefono) >= 8),
    CHECK (length(nombre_completo) >= 5)
);

CREATE TABLE habitaciones (
    id_habitacion INTEGER PRIMARY KEY,
    numero INTEGER NOT NULL UNIQUE,
    tipo TEXT NOT NULL,
    capacidad INTEGER NOT NULL,
    precio_noche REAL NOT NULL,
    estado TEXT NOT NULL DEFAULT 'DISPONIBLE',
    CHECK (capacidad > 0),
    CHECK (precio_noche > 0),
    CHECK (tipo IN ('INDIVIDUAL', 'DOBLE', 'SUITE')),
    CHECK (estado IN ('DISPONIBLE', 'OCUPADA', 'MANTENIMIENTO'))
);

CREATE TABLE reservas (
    id_reserva INTEGER PRIMARY KEY,
    id_huesped INTEGER NOT NULL,
    id_habitacion INTEGER NOT NULL,
    fecha_entrada TEXT NOT NULL,
    fecha_salida TEXT NOT NULL,
    cantidad_huespedes INTEGER NOT NULL,
    estado TEXT NOT NULL DEFAULT 'CONFIRMADA',
    FOREIGN KEY (id_huesped) REFERENCES huespedes(id_huesped),
    FOREIGN KEY (id_habitacion) REFERENCES habitaciones(id_habitacion),
    UNIQUE (id_habitacion, fecha_entrada),
    CHECK (cantidad_huespedes > 0),
    CHECK (fecha_salida > fecha_entrada),
    CHECK (estado IN ('CONFIRMADA', 'CHECK_IN', 'FINALIZADA', 'CANCELADA'))
);

CREATE TABLE pagos (
    id_pago INTEGER PRIMARY KEY,
    id_reserva INTEGER NOT NULL,
    fecha_pago TEXT NOT NULL,
    monto REAL NOT NULL,
    metodo_pago TEXT NOT NULL,
    estado TEXT NOT NULL DEFAULT 'PAGADO',
    FOREIGN KEY (id_reserva) REFERENCES reservas(id_reserva),
    CHECK (monto > 0),
    CHECK (metodo_pago IN ('EFECTIVO', 'TARJETA', 'TRANSFERENCIA')),
    CHECK (estado IN ('PAGADO', 'PENDIENTE', 'ANULADO'))
);