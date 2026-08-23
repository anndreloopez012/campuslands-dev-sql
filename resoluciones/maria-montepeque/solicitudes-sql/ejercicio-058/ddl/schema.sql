PRAGMA foreign_keys = ON;

-- Ejercicio 058: Viajes y Paracaidismo
-- Modelo: clientes + experiencias -> reservas (doble FOREIGN KEY), y
-- reservas -> pagos (1:N). 4 tablas en total.

CREATE TABLE clientes (
    id_cliente     INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_cliente TEXT NOT NULL UNIQUE,
    telefono       TEXT NOT NULL
);

CREATE TABLE experiencias (
    id_experiencia     INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_experiencia TEXT NOT NULL UNIQUE,
    tipo               TEXT NOT NULL CHECK (tipo IN ('viaje', 'turismo', 'paracaidismo')),
    precio             REAL NOT NULL CHECK (precio > 0)
);

CREATE TABLE reservas (
    id_reserva      INTEGER PRIMARY KEY AUTOINCREMENT,
    id_cliente      INTEGER NOT NULL,
    id_experiencia  INTEGER NOT NULL,
    fecha_reserva   TEXT NOT NULL,
    estado          TEXT NOT NULL DEFAULT 'pendiente' CHECK (estado IN ('pendiente', 'confirmada', 'completada', 'cancelada')),

    FOREIGN KEY (id_cliente) REFERENCES clientes (id_cliente),
    FOREIGN KEY (id_experiencia) REFERENCES experiencias (id_experiencia)
);

-- pagos: una reserva puede tener cero, uno o varios pagos (deposito +
-- resto, por ejemplo).
CREATE TABLE pagos (
    id_pago      INTEGER PRIMARY KEY AUTOINCREMENT,
    id_reserva   INTEGER NOT NULL,
    monto        REAL NOT NULL CHECK (monto > 0),
    fecha_pago   TEXT NOT NULL,
    estado       TEXT NOT NULL DEFAULT 'completado' CHECK (estado IN ('completado', 'reembolsado')),

    FOREIGN KEY (id_reserva) REFERENCES reservas (id_reserva)
);
